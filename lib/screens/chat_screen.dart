import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import '../blocs/chat/chat_bloc.dart';
import '../blocs/chat/chat_event.dart';
import '../blocs/chat/chat_state.dart';
import '../models/chat_message.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/chat_bubble_modern.dart';
import '../widgets/typing_indicator.dart';
import '../widgets/upgrade_dialog.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with AutomaticKeepAliveClientMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _imagePicker = ImagePicker();
  
  @override
  bool get wantKeepAlive => true;
  
  File? _selectedFile;
  String? _selectedFileName;
  String? _selectedFileType;
  
  // Quick suggestions
  final List<Map<String, dynamic>> _suggestions = [
    {'label': 'Beli makan 50rb', 'icon': Icons.restaurant_rounded},
    {'label': 'Isi bensin 100rb', 'icon': Icons.local_gas_station_rounded},
    {'label': 'Terima gaji 5jt', 'icon': Icons.account_balance_wallet_rounded},
    {'label': 'Bayar listrik 300rb', 'icon': Icons.electric_bolt_rounded},
  ];
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    // Initialize AI service (fetches API key from Firebase)
    _initializeAI();
    
    // Pastikan messages langsung load saat screen muncul
    // Trigger load messages langsung (tidak perlu postFrameCallback)
    final chatBloc = context.read<ChatBloc>();
    final currentState = chatBloc.state;
    currentState.whenOrNull(
      initial: () {
        chatBloc.add(const ChatEvent.loadMessages());
      },
    );
  }
  
  Future<void> _initializeAI() async {
    final chatBloc = context.read<ChatBloc>();
    await chatBloc.initializeAI();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
  
  void _onScroll() {
    // Pagination can be added later if needed
  }
  
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          // For reverse: true, scroll to 0 to show newest messages at bottom
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _sendMessage([String? customMessage]) {
    final message = customMessage ?? _controller.text.trim();
    if (message.isEmpty && _selectedFile == null) return;
    
    final messageText = message.isEmpty ? 
        (_selectedFileType == 'image' ? '[Foto]' : '[File: ${_selectedFileName}]') : 
        message;
    
    _controller.clear();
    
    // Send via BLoC with file attachment if any
    context.read<ChatBloc>().add(ChatEvent.sendMessage(
      messageText,
      filePath: _selectedFile?.path,
      fileName: _selectedFileName,
      fileType: _selectedFileType,
    ));
    
    // Clear selected file after sending
    _clearSelectedFile();
    
    _scrollToBottom();
  }

  void _handleSuggestionTap(String suggestion) {
    _sendMessage(suggestion);
  }
  
  void _confirmAction(Map<String, dynamic> transactionData) {
    context.read<ChatBloc>().add(ChatEvent.confirmTransaction(transactionData));
    _scrollToBottom();
  }
  
  void _cancelAction() {
    context.read<ChatBloc>().add(const ChatEvent.cancelTransaction());
    _scrollToBottom();
  }
  
  void _showAttachmentOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // Coming Soon Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                gradient: AppGradients.warning,
                borderRadius: BorderRadius.circular(AppRadius.full),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time_rounded, color: Colors.white, size: 18),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Coming Soon',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            Text(
              'Lampirkan File',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Fitur ini akan segera tersedia',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            
            // Camera option (disabled)
            Opacity(
              opacity: 0.5,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primary,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(Icons.camera_alt_rounded, color: Colors.white),
                ),
                title: const Text('Ambil Foto'),
                subtitle: const Text('Gunakan kamera'),
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoonMessage();
                },
              ),
            ),
            
            // Gallery option (disabled)
            Opacity(
              opacity: 0.5,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    gradient: AppGradients.success,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(Icons.photo_library_rounded, color: Colors.white),
                ),
                title: const Text('Pilih dari Gallery'),
                subtitle: const Text('Foto atau video'),
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoonMessage();
                },
              ),
            ),
            
            // Document option (disabled)
            Opacity(
              opacity: 0.5,
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    gradient: AppGradients.info,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(Icons.insert_drive_file_rounded, color: Colors.white),
                ),
                title: const Text('Pilih File'),
                subtitle: const Text('PDF, Excel, atau dokumen lainnya'),
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoonMessage();
                },
              ),
            ),
            
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }
  
  void _showComingSoonMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.access_time_rounded, color: Colors.white),
            const SizedBox(width: AppSpacing.sm),
            const Expanded(
              child: Text('Fitur lampiran file akan segera tersedia!'),
            ),
          ],
        ),
        backgroundColor: AppColors.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
  
  // ignore: unused_element
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );
      
      if (image != null) {
        setState(() {
          _selectedFile = File(image.path);
          _selectedFileName = image.name;
          _selectedFileType = 'image';
        });
        showSuccessSnackbar(context, 'Foto terpilih: ${image.name}');
      }
    } catch (e) {
      showErrorSnackbar(context, 'Gagal memilih foto: $e');
    }
  }
  
  // ignore: unused_element
  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'txt', 'csv'],
      );
      
      if (result != null && result.files.single.path != null) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
          _selectedFileName = result.files.single.name;
          _selectedFileType = 'document';
        });
        showSuccessSnackbar(context, 'File terpilih: ${result.files.single.name}');
      }
    } catch (e) {
      showErrorSnackbar(context, 'Gagal memilih file: $e');
    }
  }
  
  void _clearSelectedFile() {
    setState(() {
      _selectedFile = null;
      _selectedFileName = null;
      _selectedFileType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    
    return MultiBlocListener(
      listeners: [
        // Listen to settings changes and reinitialize AI
      ],
      child: Scaffold(
        body: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (message) {
                showErrorSnackbar(context, message);
              },
              loaded: (messages, pendingTransaction, isAiTyping, showUpgradeDialog) {
                if (messages.isNotEmpty) {
                  _scrollToBottom();
                }
                if (showUpgradeDialog) {
                  UpgradeDialog.show(
                    context,
                    message: 'Quota limit telah tercapai. Upgrade ke premium untuk melanjutkan.',
                    onUpgrade: () {
                      // TODO: Implement upgrade flow
                      context.read<ChatBloc>().dismissUpgradeDialog();
                    },
                  );
                }
              },
            );
          },
          builder: (context, state) {
            // Always show UI structure immediately, handle state inside
            return state.when(
              initial: () => _buildChatUI(context, [], null, false),
              loading: () => _buildChatUI(context, [], null, false, isLoading: true),
              loaded: (messages, pendingTransaction, isAiTyping, showUpgradeDialog) {
                return _buildChatUI(context, messages, pendingTransaction, isAiTyping);
              },
              error: (message) => _buildChatUI(context, [], null, false, errorMessage: message),
            );
          },
        ),
      ),
    );
  }
  
  Widget _buildChatUI(
    BuildContext context,
    List<ChatMessage> messages,
    Map<String, dynamic>? pendingTransaction,
    bool isAiTyping, {
    bool isLoading = false,
    String? errorMessage,
  }) {
    return SafeArea(
                child: Column(
                  children: [
                    // Messages
                    Expanded(
                      child: isLoading
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  const SizedBox(height: AppSpacing.md),
                                  Text(
                                    'Memuat chat...',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : errorMessage != null
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(AppSpacing.lg),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.error_outline,
                                          size: 64,
                                          color: Theme.of(context).colorScheme.error,
                                        ),
                                        const SizedBox(height: AppSpacing.md),
                                        Text(
                                          errorMessage,
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.bodyLarge,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                                  : messages.isEmpty
                                  ? _buildEmptyState()
                                  : ListView.builder(
                              controller: _scrollController,
                              reverse: true, // Newest messages at bottom
                              padding: EdgeInsets.only(
                                left: AppSpacing.sm,
                                right: AppSpacing.sm,
                                top: AppSpacing.sm,
                                bottom: AppSpacing.sm,
                              ),
                              physics: const BouncingScrollPhysics(),
                              cacheExtent: 500, // Cache 500 pixels for smoother scrolling
                            itemCount: messages.length + (isAiTyping ? 1 : 0),
                            itemBuilder: (context, index) {
                              // Reverse index calculation for reverse list
                              final reverseIndex = messages.length + (isAiTyping ? 1 : 0) - 1 - index;
                              
                              if (reverseIndex >= messages.length) {
                                return RepaintBoundary(
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                                    child: TypingIndicator(),
                                  ),
                                );
                              }
                              
                              final chatMessage = messages[reverseIndex];
                              
                              // If this is the first message (last in reverse) with transaction data and there's a pending transaction
                              final isLastMessage = reverseIndex == messages.length - 1;
                              final hasTransactionData = chatMessage.transactionData != null;
                              final hasPendingTransaction = pendingTransaction != null;
                              
                              // Debug logging
                              if (isLastMessage && hasTransactionData && !chatMessage.isUser) {
                                print('======= TRANSACTION CONFIRMATION CHECK =======');
                                print('Has transaction data: $hasTransactionData');
                                print('Has pending transaction: $hasPendingTransaction');
                                print('Transaction data: ${chatMessage.transactionData}');
                                print('Pending transaction: $pendingTransaction');
                                print('=============================================');
                              }
                              
                              if (isLastMessage && hasTransactionData && hasPendingTransaction && !chatMessage.isUser) {
                                return RepaintBoundary(
                                  key: ValueKey('msg_${chatMessage.id}_confirm'),
                                  child: ModernTransactionConfirmationBubble(
                                    transaction: chatMessage.transactionData!,
                                    onConfirm: () => _confirmAction(chatMessage.transactionData!),
                                    onCancel: _cancelAction,
                                  ),
                                );
                              }
                              
                              // Otherwise show modern chat bubble - wrapped in RepaintBoundary
                              return RepaintBoundary(
                                key: ValueKey('msg_${chatMessage.id}'),
                                child: ModernChatBubble(
                                  message: chatMessage.message,
                                  isUser: chatMessage.isUser,
                                  timestamp: chatMessage.timestamp,
                                  filePath: chatMessage.filePath,
                                  fileName: chatMessage.fileName,
                                  fileType: chatMessage.fileType,
                                ),
                              );
                            },
                          ),
                  ),
                  
                  // Suggestion chips (only show when empty or not typing)
                  if (messages.isEmpty && !isAiTyping)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _suggestions.length,
                        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                        itemBuilder: (context, index) {
                          final suggestion = _suggestions[index];
                          return SuggestionChip(
                            label: suggestion['label'] as String,
                            icon: suggestion['icon'] as IconData,
                            onTap: () => _handleSuggestionTap(suggestion['label'] as String),
                          );
                        },
                      ),
                    ),
                  
                  // Modern Input area
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: Column(
                        children: [
                          // File preview (if any)
                          if (_selectedFile != null) ...[
                            Container(
                              margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                              padding: const EdgeInsets.all(AppSpacing.sm),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer,
                                borderRadius: BorderRadius.circular(AppRadius.md),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _selectedFileType == 'image' 
                                        ? Icons.image_rounded 
                                        : Icons.insert_drive_file_rounded,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Text(
                                      _selectedFileName ?? 'File',
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                                    ),
                                    onPressed: _clearSelectedFile,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          
                          Row(
                            children: [
                              // Attach button with Coming Soon badge
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: AppGradients.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      onPressed: isAiTyping ? null : _showAttachmentOptions,
                                      icon: const Icon(Icons.attach_file_rounded, color: Colors.white),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                  // Coming Soon badge
                                  Positioned(
                                    top: -4,
                                    right: -4,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.warning,
                                        borderRadius: BorderRadius.circular(AppRadius.full),
                                        border: Border.all(
                                          color: Theme.of(context).colorScheme.surface,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Text(
                                        'SOON',
                                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          const SizedBox(width: AppSpacing.sm),
                          
                          // Text field
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(AppRadius.xl),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                                ),
                              ),
                              child: TextField(
                                controller: _controller,
                                focusNode: _focusNode,
                                decoration: InputDecoration(
                                  hintText: 'Ketik transaksi atau tanya AI...',
                                  hintStyle: TextStyle(
                                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                                  ),
                                  filled: false,
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.md,
                                    vertical: AppSpacing.sm + 2,
                                  ),
                                ),
                                maxLines: null,
                                textInputAction: TextInputAction.send,
                                onSubmitted: (_) => _sendMessage(),
                                enabled: !isAiTyping,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          
                              // Send button
                              Container(
                                decoration: BoxDecoration(
                                  gradient: AppGradients.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  onPressed: isAiTyping ? null : () => _sendMessage(),
                                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: AppGradients.primary.colors.map((c) => c.withOpacity(0.3)).toList(),
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              size: 80,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          const Text(
            'Halo! 👋',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Saya adalah AI asisten keuangan Anda',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              'Ketik transaksi dalam bahasa natural atau pilih salah satu saran di bawah',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
