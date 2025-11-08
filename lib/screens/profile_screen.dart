import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/categories/category_bloc.dart';
import '../blocs/categories/category_event.dart';
import '../blocs/categories/category_state.dart';
import '../blocs/theme/theme_bloc.dart';
import '../blocs/theme/theme_event.dart';
import '../models/category.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../utils/helpers.dart';
import '../services/subscription_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_button.dart';
import 'category_form_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  bool _isEditing = false;
  File? _imageFile;
  
  DateTime? _memberSince;
  bool? _isPremium;
  bool? _hasTrialActive;
  int? _remainingTrialDays;
  SubscriptionType? _subscriptionType;
  bool? _isUnlimited;
  Timer? _trialCountdownTimer;
  final SubscriptionService _subscriptionService = SubscriptionService();
  
  @override
  void initState() {
    super.initState();
    _loadUserData();
    _loadSubscriptionStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh subscription status when screen becomes visible
    _loadSubscriptionStatus();
  }

  @override
  void dispose() {
    _trialCountdownTimer?.cancel();
    _nameController.dispose();
    super.dispose();
  }
  
  void _loadUserData() {
    if (user != null) {
      _nameController.text = user!.displayName ?? '';
      _memberSince = user!.metadata.creationTime;
    }
  }

  Future<void> _loadSubscriptionStatus() async {
    if (user == null) return;

    try {
      final isPremium = await _subscriptionService.isPremium(user!.uid);
      final isTrialActive = await _subscriptionService.isTrialActive(user!.uid);
      final remainingDays = isTrialActive 
          ? await _subscriptionService.getRemainingTrialDays(user!.uid)
          : null;
      final subscriptionType = await _subscriptionService.getSubscriptionType(user!.uid);
      final isUnlimited = await _subscriptionService.isUnlimited(user!.uid);

      if (mounted) {
        setState(() {
          _isPremium = isPremium;
          _hasTrialActive = isTrialActive;
          _remainingTrialDays = remainingDays;
          _subscriptionType = subscriptionType;
          _isUnlimited = isUnlimited;
        });

        // Set up timer to update countdown every day
        if (isTrialActive && !isPremium) {
          _startTrialCountdownTimer();
        }
      }
    } catch (e) {
      print('Error loading subscription status: $e');
    }
  }

  void _startTrialCountdownTimer() {
    _trialCountdownTimer?.cancel();
    
    // Update countdown every day at midnight
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final durationUntilMidnight = tomorrow.difference(now);

    // First update at midnight
    Future.delayed(durationUntilMidnight, () {
      if (mounted) {
        _loadSubscriptionStatus();
      }
    });

    // Then update every 24 hours
    _trialCountdownTimer = Timer.periodic(const Duration(hours: 24), (timer) {
      if (mounted) {
        _loadSubscriptionStatus();
      } else {
        timer.cancel();
      }
    });
  }
  
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      
      // TODO: Upload image to storage and update user profile
      Helpers.showSnackBar(context, 'Upload foto profil akan segera hadir');
    }
  }
  
  Future<void> _saveProfile() async {
    if (user == null) return;
    
    try {
      await user!.updateDisplayName(_nameController.text);
      
      setState(() {
        _isEditing = false;
      });
      
      if (mounted) {
        Helpers.showSnackBar(context, 'Profil berhasil diupdate');
      }
    } catch (e) {
      if (mounted) {
        Helpers.showSnackBar(context, 'Gagal update profil: $e', isError: true);
      }
    }
  }
  
  Future<void> _logout() async {
    final confirmed = await Helpers.showConfirmDialog(
      context,
      title: 'Logout',
      message: 'Apakah Anda yakin ingin keluar?',
      confirmText: 'Ya, Keluar',
      cancelText: 'Batal',
    );
    
    if (confirmed) {
      await FirebaseAuth.instance.signOut();
    }
  }
  

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('User not logged in'),
        ),
      );
    }
    
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero Section with Gradient
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                gradient: AppGradients.primary,
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // App Bar
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (!_isEditing)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.edit_rounded, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    _isEditing = true;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    
                    // Profile Picture with Glass Effect
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // Glow effect (reduced for performance)
                        Container(
                          width: isSmallScreen ? 100 : 120,
                          height: isSmallScreen ? 100 : 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                blurRadius: 20,
                                spreadRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        // Avatar
                        Container(
                          width: isSmallScreen ? 90 : 110,
                          height: isSmallScreen ? 90 : 110,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 3,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: isSmallScreen ? 45 : 55,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                            child: _imageFile == null
                                ? Text(
                                    (user!.displayName?.isNotEmpty == true
                                        ? user!.displayName![0].toUpperCase()
                                        : user!.email![0].toUpperCase()),
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 32 : 48,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        if (_isEditing)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: AppGradients.secondary,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt_rounded, color: Colors.white),
                                onPressed: _pickImage,
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(height: AppSpacing.lg),
                    
                    // User Info
                    if (_isEditing) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                        child: CustomTextField(
                          controller: _nameController,
                          label: 'name'.tr(),
                          prefixIcon: Icons.person_rounded,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                        child: Row(
                          children: [
                            Expanded(
                              child: OutlineGradientButton(
                                text: 'cancel'.tr(),
                                onPressed: () {
                                  setState(() {
                                    _isEditing = false;
                                    _loadUserData();
                                  });
                                },
                                gradient: LinearGradient(
                                  colors: [Colors.white, Colors.white.withOpacity(0.9)],
                                ),
                                icon: Icons.close_rounded,
                                borderRadius: AppRadius.lg,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: GradientButton(
                                text: 'save'.tr(),
                                onPressed: _saveProfile,
                                gradient: LinearGradient(
                                  colors: [Colors.white, Colors.white.withOpacity(0.9)],
                                ),
                                icon: Icons.check_rounded,
                                textStyle: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                                borderRadius: AppRadius.lg,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else ...[
                      Text(
                        user!.displayName ?? 'No Name',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 22 : 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        user!.email ?? '',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 13 : 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      // Show trial countdown if active, otherwise show member since or premium
                      if (_hasTrialActive == true && _remainingTrialDays != null && _isPremium != true)
                        Container(
                          margin: const EdgeInsets.only(top: AppSpacing.sm),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.25),
                                Colors.white.withOpacity(0.15),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                'Trial Aktif - $_remainingTrialDays hari tersisa',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.95),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (_isPremium == true)
                        Container(
                          margin: const EdgeInsets.only(top: AppSpacing.sm),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppGradients.secondary,
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.workspace_premium_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                _isUnlimited == true 
                                    ? 'Premium Unlimited'
                                    : _subscriptionType == SubscriptionType.proMonthly
                                        ? 'Premium'
                                        : 'Premium',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (_isUnlimited == true) ...[
                                const SizedBox(width: AppSpacing.xs),
                                const Icon(
                                  Icons.all_inclusive_rounded,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ],
                            ],
                          ),
                        )
                      else if (_memberSince != null)
                        Container(
                          margin: const EdgeInsets.only(top: AppSpacing.sm),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Member sejak ${Formatters.date(_memberSince!, format: 'MMM yyyy')}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                    
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ),
          
          // Content
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -24),
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.xl),
                    
                    // Settings Sections
                    _buildSettingsGroup(
                      title: 'Akun & Preferensi',
                      children: [
                        _buildSettingTile(
                          icon: Icons.person_rounded,
                          title: 'Edit Profil',
                          subtitle: 'Ubah nama dan foto profil',
                          iconColor: AppColors.primary,
                          onTap: () {
                            setState(() {
                              _isEditing = true;
                            });
                          },
                        ),
                        _buildThemeTile(context),
                        _buildSettingTile(
                          icon: Icons.notifications_rounded,
                          title: 'Notifikasi',
                          subtitle: 'Atur pengingat dan notifikasi',
                          iconColor: Colors.orange,
                          onTap: () {
                            Navigator.pushNamed(context, '/notification-settings');
                          },
                        ),
                      ],
                    ),
                    
                    _buildSettingsGroup(
                      title: 'Manajemen Data',
                      children: [
                        _buildSettingTile(
                          icon: Icons.category_rounded,
                          title: 'Kelola Kategori',
                          subtitle: 'Tambah atau ubah kategori transaksi',
                          iconColor: AppColors.success,
                          onTap: () {
                            Navigator.pushNamed(context, '/category-management');
                          },
                        ),
                        // Quick add category section
                        BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            final hasCustomCategories = state.maybeWhen(
                              loaded: (categories) {
                                return categories.any((cat) => !cat.isDefault);
                              },
                              orElse: () => false,
                            );
                            
                            if (!hasCustomCategories) {
                              return _buildSettingTile(
                                icon: Icons.add_circle_rounded,
                                title: 'Tambah Kategori Cepat',
                                subtitle: 'Buat kategori baru untuk transaksi',
                                iconColor: AppColors.primary,
                                onTap: () => _showQuickAddCategory(context),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        _buildSettingTile(
                          icon: Icons.import_export_rounded,
                          title: 'Ekspor & Impor Data',
                          subtitle: 'Cadangkan atau pulihkan data Anda',
                          iconColor: AppColors.info,
                          onTap: () {
                            Navigator.pushNamed(context, '/export-import');
                          },
                        ),
                      ],
                    ),
                    
                    // Danger Zone
                    _buildDangerZone(),
                    
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSettingsGroup({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GlassCard(
          child: Column(
            children: ListTile.divideTiles(
              context: context,
              tiles: children,
            ).toList(),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }

  Widget _buildDangerZone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Danger Zone',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.error,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        GlassCard(
          child: Column(
            children: [
              _buildSettingTile(
                icon: Icons.logout_rounded,
                title: 'Logout',
                subtitle: 'Keluar dari akun Anda',
                iconColor: AppColors.error,
                onTap: _logout,
              ),
              const Divider(height: 1),
              _buildSettingTile(
                icon: Icons.delete_forever_rounded,
                title: 'Hapus Akun',
                subtitle: 'Semua data Anda akan dihapus permanen',
                iconColor: AppColors.error,
                onTap: () {
                  Helpers.showSnackBar(context, 'Fitur hapus akun akan segera hadir', isError: true);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }

  Future<void> _showQuickAddCategory(BuildContext context) async {
    // Pilih tipe kategori dulu
    final selectedType = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Tipe Kategori'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.arrow_downward, color: Colors.red),
              title: const Text('Pengeluaran'),
              subtitle: const Text('Untuk kategori pengeluaran'),
              onTap: () => Navigator.pop(context, 'expense'),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.arrow_upward, color: Colors.green),
              title: const Text('Pemasukan'),
              subtitle: const Text('Untuk kategori pemasukan'),
              onTap: () => Navigator.pop(context, 'income'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
    
    if (selectedType == null || !mounted) return;
    
    // Tampilkan form tambah kategori dengan tipe yang dipilih
    final result = await showDialog<Category>(
      context: context,
      builder: (context) => CategoryFormDialog(
        type: selectedType,
      ),
    );
    
    if (result != null && mounted) {
      context.read<CategoryBloc>().add(CategoryEvent.addCategory(result));
      showSuccessSnackbar(context, 'Kategori berhasil ditambahkan');
    }
  }

  Widget _buildThemeTile(BuildContext context) {
    return _buildSettingTile(
      icon: Icons.palette_rounded,
      title: 'Tampilan',
      subtitle: 'Ganti tema aplikasi',
      iconColor: Colors.purple,
      onTap: () => _showThemeDialog(context),
    );
  }
  
  Future<void> _showThemeDialog(BuildContext context) async {
    final themeBloc = context.read<ThemeBloc>();
    final currentTheme = themeBloc.state.themeMode;
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pilih Tema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildThemeOption(
              context: context,
              icon: Icons.brightness_auto_rounded,
              title: 'Sistem',
              subtitle: 'Mengikuti pengaturan sistem',
              themeMode: ThemeMode.system,
              selected: currentTheme == ThemeMode.system,
              onTap: () {
                themeBloc.add(ThemeEvent.setThemeMode(ThemeMode.system));
                Navigator.pop(context);
                showSuccessSnackbar(context, 'Tema diubah ke Sistem');
              },
            ),
            const Divider(),
            _buildThemeOption(
              context: context,
              icon: Icons.light_mode_rounded,
              title: 'Terang',
              subtitle: 'Tema terang',
              themeMode: ThemeMode.light,
              selected: currentTheme == ThemeMode.light,
              onTap: () {
                themeBloc.add(ThemeEvent.setThemeMode(ThemeMode.light));
                Navigator.pop(context);
                showSuccessSnackbar(context, 'Tema diubah ke Terang');
              },
            ),
            const Divider(),
            _buildThemeOption(
              context: context,
              icon: Icons.dark_mode_rounded,
              title: 'Gelap',
              subtitle: 'Tema gelap',
              themeMode: ThemeMode.dark,
              selected: currentTheme == ThemeMode.dark,
              onTap: () {
                themeBloc.add(ThemeEvent.setThemeMode(ThemeMode.dark));
                Navigator.pop(context);
                showSuccessSnackbar(context, 'Tema diubah ke Gelap');
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildThemeOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required ThemeMode themeMode,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: selected ? Theme.of(context).colorScheme.primary : null,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? Theme.of(context).colorScheme.primary : null,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: selected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }


  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Icon(icon, color: iconColor, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
      ),
      trailing: onTap != null 
          ? Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            )
          : null,
    );
  }
}

