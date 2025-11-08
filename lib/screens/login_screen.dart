import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../utils/constants.dart';
import '../widgets/gradient_button.dart';
import '../widgets/glass_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppAnimation.slow,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    context.read<AuthBloc>().add(
          SignIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      const Icon(Icons.error_outline, color: Colors.white),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(child: Text(message)),
                    ],
                  ),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  margin: const EdgeInsets.all(AppSpacing.md),
                ),
              );
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Stack(
            children: [
              // Gradient Background
              Container(
                decoration: BoxDecoration(
                  gradient: AppGradients.primary,
                ),
              ),

              // Content
              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: SlideTransition(
                            position: _slideAnimation,
                            child: Column(
                              children: [
                                // Logo/Hero Section
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxxl),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(AppSpacing.xl),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.2),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.3),
                                            width: 2,
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.account_balance_wallet_rounded,
                                          size: 64,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: AppSpacing.lg),
                                      Text(
                                        'app_name'.tr(),
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: -0.5,
                                        ),
                                      ),
                                      const SizedBox(height: AppSpacing.xs),
                                      Text(
                                        'Smart Financial Assistant',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.9),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Login Form Card
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(AppRadius.xxl),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(AppSpacing.xl),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'login'.tr(),
                                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                            const SizedBox(height: AppSpacing.xs),
                                            Text(
                                              'Welcome back! Please login to continue',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: Theme.of(context).textTheme.bodySmall?.color,
                                                  ),
                                            ),
                                            const SizedBox(height: AppSpacing.xl),

                                            // Email Field
                                            TextFormField(
                                              controller: _emailController,
                                              enabled: !isLoading,
                                              decoration: InputDecoration(
                                                labelText: 'email'.tr(),
                                                hintText: 'Enter your email',
                                                prefixIcon: const Icon(Icons.email_outlined),
                                                filled: true,
                                                fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(AppRadius.lg),
                                                  borderSide: BorderSide.none,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(AppRadius.lg),
                                                  borderSide: BorderSide.none,
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(AppRadius.lg),
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    width: 2,
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(AppRadius.lg),
                                                  borderSide: const BorderSide(
                                                    color: AppColors.error,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              keyboardType: TextInputType.emailAddress,
                                              textInputAction: TextInputAction.next,
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter email';
                                                }
                                                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                                  return 'Please enter valid email';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: AppSpacing.md),

                                            // Password Field
                                            TextFormField(
                                              controller: _passwordController,
                                              enabled: !isLoading,
                                              decoration: InputDecoration(
                                                labelText: 'password'.tr(),
                                                hintText: 'Enter your password',
                                                prefixIcon: const Icon(Icons.lock_outlined),
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    _obscurePassword
                                                        ? Icons.visibility_outlined
                                                        : Icons.visibility_off_outlined,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _obscurePassword = !_obscurePassword;
                                                    });
                                                  },
                                                ),
                                                filled: true,
                                                fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(AppRadius.lg),
                                                  borderSide: BorderSide.none,
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(AppRadius.lg),
                                                  borderSide: BorderSide.none,
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(AppRadius.lg),
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    width: 2,
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(AppRadius.lg),
                                                  borderSide: const BorderSide(
                                                    color: AppColors.error,
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                              obscureText: _obscurePassword,
                                              textInputAction: TextInputAction.done,
                                              onFieldSubmitted: (_) => _login(),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Please enter password';
                                                }
                                                if (value.length < 6) {
                                                  return 'Password must be at least 6 characters';
                                                }
                                                return null;
                                              },
                                            ),
                                            const SizedBox(height: AppSpacing.xl),

                                            // Login Button
                                            GradientButton(
                                              text: 'login'.tr(),
                                              onPressed: isLoading ? null : _login,
                                              isLoading: isLoading,
                                              icon: Icons.login_rounded,
                                              borderRadius: AppRadius.lg,
                                            ),

                                            const SizedBox(height: AppSpacing.lg),

                                            const Spacer(),
                                            
                                            // Register Link with extra padding for safe area
                                            Padding(
                                              padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context).padding.bottom > 0
                                                    ? MediaQuery.of(context).padding.bottom
                                                    : AppSpacing.md,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      'dont_have_account'.tr(),
                                                      style: Theme.of(context).textTheme.bodyMedium,
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: isLoading
                                                        ? null
                                                        : () => Navigator.pushNamed(context, '/register'),
                                                    style: TextButton.styleFrom(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: AppSpacing.sm,
                                                        vertical: AppSpacing.xs,
                                                      ),
                                                      minimumSize: Size.zero,
                                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                    ),
                                                    child: Text(
                                                      'register'.tr(),
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: Theme.of(context).colorScheme.primary,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Loading Overlay
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: const Center(
                      child: GlassCard(
                        child: Padding(
                          padding: EdgeInsets.all(AppSpacing.xl),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: AppSpacing.md),
                              Text('Logging in...'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
