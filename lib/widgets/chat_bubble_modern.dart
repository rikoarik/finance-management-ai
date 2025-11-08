import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import 'glass_card.dart';
import 'gradient_button.dart';

/// Modern chat bubble with glass morphism effect
class ModernChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final DateTime timestamp;
  final String? filePath;
  final String? fileName;
  final String? fileType;
  
  const ModernChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.timestamp,
    this.filePath,
    this.fileName,
    this.fileType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            _buildAvatar(context, false),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Message bubble with glass effect
                isUser
                    ? _buildUserBubble(context)
                    : _buildAIBubble(context),
                const SizedBox(height: AppSpacing.xs),
                // Timestamp
                Text(
                  Formatters.time(timestamp),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: AppSpacing.sm),
            _buildAvatar(context, true),
          ],
        ],
      ),
    );
  }

  Widget _buildUserBubble(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        gradient: AppGradients.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppRadius.lg),
          topRight: Radius.circular(AppRadius.sm),
          bottomLeft: Radius.circular(AppRadius.lg),
          bottomRight: Radius.circular(AppRadius.lg),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // File attachment preview
          if (filePath != null) ...[
            _buildFileAttachment(context, true),
            if (message.isNotEmpty && message != '[Foto]' && !message.startsWith('[File:')) ...[
              const SizedBox(height: AppSpacing.sm),
            ],
          ],
          // Message text
          if (message.isNotEmpty && message != '[Foto]' && !message.startsWith('[File:'))
            Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                height: 1.4,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAIBubble(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      borderRadius: AppRadius.lg,
      opacity: 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // File attachment preview
          if (filePath != null) ...[
            _buildFileAttachment(context, false),
            if (message.isNotEmpty && message != '[Foto]' && !message.startsWith('[File:')) ...[
              const SizedBox(height: AppSpacing.sm),
            ],
          ],
          // Message text
          if (message.isNotEmpty && message != '[Foto]' && !message.startsWith('[File:'))
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 15,
                height: 1.4,
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildFileAttachment(BuildContext context, bool isUser) {
    if (fileType == 'image' && filePath != null) {
      final imageFile = File(filePath!);
      if (imageFile.existsSync()) {
        return Container(
          constraints: const BoxConstraints(
            maxWidth: 200,
            maxHeight: 200,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: isUser 
                  ? Colors.white.withOpacity(0.3) 
                  : Colors.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: Image.file(
              imageFile,
              fit: BoxFit.cover,
            ),
          ),
        );
      }
    }
    
    // Document file icon
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: isUser 
            ? Colors.white.withOpacity(0.2) 
            : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: isUser 
              ? Colors.white.withOpacity(0.3) 
              : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            fileType == 'image' 
                ? Icons.image_rounded 
                : Icons.insert_drive_file_rounded,
            size: 20,
            color: isUser ? Colors.white : Theme.of(context).colorScheme.onSurface,
          ),
          const SizedBox(width: AppSpacing.sm),
          Flexible(
            child: Text(
              fileName ?? 'File',
              style: TextStyle(
                color: isUser ? Colors.white : Theme.of(context).colorScheme.onSurface,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAvatar(BuildContext context, bool isUser) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        gradient: isUser
            ? AppGradients.primary
            : AppGradients.success,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (isUser ? AppColors.primary : AppColors.success).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        isUser ? Icons.person_rounded : Icons.auto_awesome_rounded,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}

/// Modern transaction confirmation bubble with glass effect
class ModernTransactionConfirmationBubble extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  
  const ModernTransactionConfirmationBubble({
    super.key,
    required this.transaction,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    // Handle multiple transactions
    if (transaction['multiple'] == true) {
      return _buildMultipleTransactions(context);
    }
    
    final action = transaction['action'] as String? ?? 'record_expense';
    
    // Handle budget suggestion
    if (action == 'suggest_budget') {
      return _buildBudgetSuggestion(context);
    }
    
    // Handle regular transaction
    return _buildSingleTransaction(context);
  }

  Widget _buildSingleTransaction(BuildContext context) {
    final action = transaction['action'] as String? ?? 'record_expense';
    final amount = (transaction['amount'] as num?)?.toDouble() ?? 0.0;
    final category = transaction['category'] as String? ?? 'Other';
    final note = transaction['note'] as String? ?? '';
    final type = action == 'record_income' ? 'Pemasukan' : 'Pengeluaran';
    final gradient = action == 'record_income' ? AppGradients.success : AppGradients.error;
    
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: GlassCard(
        blur: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.lg),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    action == 'record_income' ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Konfirmasi Transaksi',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  _buildInfoRow(context, 'Tipe', type, Icons.label_rounded),
                  _buildInfoRow(context, 'Jumlah', Formatters.currency(amount), Icons.payments_rounded),
                  _buildInfoRow(context, 'Kategori', category, Icons.category_rounded),
                  if (note.isNotEmpty) 
                    _buildInfoRow(context, 'Catatan', note, Icons.note_rounded),
                ],
              ),
            ),
            
            // Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: OutlineGradientButton(
                      text: 'Batal',
                      onPressed: onCancel,
                      icon: Icons.close_rounded,
                      borderRadius: AppRadius.lg,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: GradientButton(
                      text: 'Simpan',
                      onPressed: onConfirm,
                      icon: Icons.check_rounded,
                      gradient: gradient,
                      borderRadius: AppRadius.lg,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMultipleTransactions(BuildContext context) {
    final transactions = transaction['transactions'] as List;
    
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: GlassCard(
        blur: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: AppGradients.primary,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.lg),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.receipt_long_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Konfirmasi ${transactions.length} Transaksi',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            // Transaction list
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: transactions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final trans = entry.value as Map<String, dynamic>;
                  try {
                    return _buildTransactionItem(context, index + 1, trans);
                  } catch (e) {
                    print('Error building transaction item $index: $e');
                    return const SizedBox.shrink();
                  }
                }).toList(),
              ),
            ),
            
            // Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: OutlineGradientButton(
                      text: 'Batal',
                      onPressed: onCancel,
                      icon: Icons.close_rounded,
                      borderRadius: AppRadius.lg,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: GradientButton(
                      text: 'Simpan Semua',
                      onPressed: onConfirm,
                      icon: Icons.check_rounded,
                      borderRadius: AppRadius.lg,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(BuildContext context, int number, Map<String, dynamic> trans) {
    final action = trans['action'] as String? ?? 'record_expense';
    final amount = (trans['amount'] as num?)?.toDouble() ?? 0.0;
    final category = trans['category'] as String? ?? 'Other';
    final note = trans['note'] as String? ?? '';
    final color = action == 'record_income' ? AppColors.income : AppColors.expense;
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (note.isNotEmpty)
                  Text(
                    note,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
              ],
            ),
          ),
          Text(
            Formatters.currency(amount),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, size: 20),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBudgetSuggestion(BuildContext context) {
    final amount = (transaction['amount'] as num).toDouble();
    final categories = transaction['categories'] as Map<String, dynamic>? ?? {};
    
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: GlassCard(
        blur: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                gradient: AppGradients.warning,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.lg),
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 24),
                  SizedBox(width: AppSpacing.sm),
                  Text(
                    'Saran Budget AI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                children: [
                  // Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Budget:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        Formatters.currency(amount),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: AppSpacing.lg),
                  
                  // Categories
                  ...categories.entries.map((entry) {
                    final catAmount = (entry.value as num).toDouble();
                    final percentage = (catAmount / amount * 100).toStringAsFixed(0);
                    return Container(
                      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              entry.key,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              '$percentage%',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            Formatters.currency(catAmount),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            
            // Actions
            Padding(
              padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
              child: Row(
                children: [
                  Expanded(
                    child: OutlineGradientButton(
                      text: 'Tidak',
                      onPressed: onCancel,
                      icon: Icons.close_rounded,
                      borderRadius: AppRadius.lg,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: GradientButton(
                      text: 'Terapkan',
                      onPressed: onConfirm,
                      icon: Icons.check_rounded,
                      gradient: AppGradients.warning,
                      borderRadius: AppRadius.lg,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Suggestion chip for quick actions
class SuggestionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Gradient? gradient;

  const SuggestionChip({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: gradient ?? AppGradients.primary,
          borderRadius: BorderRadius.circular(AppRadius.full),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.white),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

