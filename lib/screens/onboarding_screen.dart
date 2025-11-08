import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../widgets/gradient_button.dart';
import '../widgets/smooth_page_indicator.dart';
import '../widgets/glass_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  double _pageOffset = 0.0;
  late AnimationController _iconAnimationController;
  late AnimationController _fadeAnimationController;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Selamat Datang!',
      description: 'Finance Chat membantu Anda mengelola keuangan dengan mudah melalui chat AI yang cerdas',
      icon: Icons.chat_bubble_outline,
      gradient: AppGradients.primary,
    ),
    OnboardingPage(
      title: 'Chat dengan AI',
      description: 'Cukup ketik transaksi Anda dalam bahasa natural, AI akan memahami dan mencatatnya',
      icon: Icons.smart_toy_outlined,
      gradient: AppGradients.success,
    ),
    OnboardingPage(
      title: 'Lacak Budget',
      description: 'Set budget bulanan dan pantau pengeluaran Anda secara real-time dengan visual yang menarik',
      icon: Icons.account_balance_wallet_outlined,
      gradient: AppGradients.warning,
    ),
    OnboardingPage(
      title: 'Analisis Keuangan',
      description: 'Lihat laporan dan grafik lengkap tentang pemasukan dan pengeluaran Anda',
      icon: Icons.analytics_outlined,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.info, AppColors.primary],
      ),
    ),
    OnboardingPage(
      title: 'Siap Memulai?',
      description: 'Mari kelola keuangan Anda dengan lebih baik bersama Finance Chat!',
      icon: Icons.rocket_launch_outlined,
      gradient: AppGradients.secondary,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageScroll);
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: AppAnimation.slow,
    );
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: AppAnimation.medium,
    );
    _iconAnimationController.forward();
    _fadeAnimationController.forward();
  }

  void _onPageScroll() {
    setState(() {
      _pageOffset = _pageController.page ?? 0;
    });
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageScroll);
    _pageController.dispose();
    _iconAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyFirstTime, false);
    
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Stack(
        children: [
          // Animated Gradient Background
          AnimatedContainer(
            duration: AppAnimation.slow,
            decoration: BoxDecoration(
              gradient: _pages[_currentPage].gradient,
            ),
          ),

          // Parallax Background Shapes
          ...List.generate(3, (index) {
            final parallaxOffset = _pageOffset * (100 * (index + 1));
            return Positioned(
              top: size.height * (0.1 + index * 0.15) - parallaxOffset,
              right: -100 + parallaxOffset * 0.5,
              child: Opacity(
                opacity: 0.1,
                child: Container(
                  width: 200 + (index * 50),
                  height: 200 + (index * 50),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),

          SafeArea(
            child: Column(
              children: [
                // Skip Button
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (_currentPage < _pages.length - 1)
                        GlassCard(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          borderRadius: AppRadius.full,
                          opacity: 0.7,
                          child: InkWell(
                            onTap: () => _pageController.animateToPage(
                              _pages.length - 1,
                              duration: AppAnimation.slow,
                              curve: Curves.easeInOutCubic,
                            ),
                            child: const Text(
                              'Lewati',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                
                // Pages with Parallax
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                      _iconAnimationController.reset();
                      _iconAnimationController.forward();
                      _fadeAnimationController.reset();
                      _fadeAnimationController.forward();
                    },
                    itemCount: _pages.length,
                    itemBuilder: (context, index) {
                      // Calculate parallax effect
                      double parallax = 0.0;
                      if (_pageController.position.haveDimensions) {
                        parallax = (_pageOffset - index).abs().clamp(0.0, 1.0);
                      }
                      return _buildPage(_pages[index], parallax);
                    },
                  ),
                ),
                
                // Page Indicator with Animation
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: GradientPageIndicator(
                    count: _pages.length,
                    currentIndex: _currentPage,
                    gradient: LinearGradient(
                      colors: [Colors.white.withOpacity(0.9), Colors.white],
                    ),
                    inactiveColor: Colors.white.withOpacity(0.3),
                    dotSize: 10,
                    spacing: 12,
                  ),
                ),
                
                // Navigation Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                    vertical: AppSpacing.md,
                  ),
                  child: Row(
                    children: [
                      if (_currentPage > 0)
                        SizedBox(
                          width: 120,
                          child: OutlineGradientButton(
                            text: 'Kembali',
                            onPressed: () {
                              _pageController.previousPage(
                                duration: AppAnimation.slow,
                                curve: Curves.easeInOutCubic,
                              );
                            },
                            icon: Icons.arrow_back_rounded,
                            borderRadius: AppRadius.lg,
                            gradient: LinearGradient(
                              colors: [Colors.white, Colors.white.withOpacity(0.9)],
                            ),
                          ),
                        ),
                      if (_currentPage > 0) const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: GradientButton(
                          text: _currentPage == _pages.length - 1 ? 'Mulai Sekarang' : 'Selanjutnya',
                          onPressed: () {
                            if (_currentPage == _pages.length - 1) {
                              _completeOnboarding();
                            } else {
                              _pageController.nextPage(
                                duration: AppAnimation.slow,
                                curve: Curves.easeInOutCubic,
                              );
                            }
                          },
                          icon: _currentPage == _pages.length - 1
                              ? Icons.check_rounded
                              : Icons.arrow_forward_rounded,
                          gradient: LinearGradient(
                            colors: [Colors.white, Colors.white.withOpacity(0.9)],
                          ),
                          textStyle: TextStyle(
                            color: _pages[_currentPage].gradient.colors.first,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          borderRadius: AppRadius.lg,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page, double parallax) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return FadeTransition(
      opacity: _fadeAnimationController,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? AppSpacing.md : AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with Parallax and Animation
            Transform.translate(
              offset: Offset(0, parallax * 50),
              child: ScaleTransition(
                scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _iconAnimationController,
                    curve: Curves.elasticOut,
                  ),
                ),
                child: RotationTransition(
                  turns: Tween<double>(begin: -0.1, end: 0.0).animate(
                    CurvedAnimation(
                      parent: _iconAnimationController,
                      curve: Curves.easeOut,
                    ),
                  ),
                  child: Container(
                    width: isSmallScreen ? 160 : 220,
                    height: isSmallScreen ? 160 : 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          blurRadius: 20,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Icon(
                        page.icon,
                        size: isSmallScreen ? 70 : 100,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: isSmallScreen ? AppSpacing.xl : AppSpacing.xxxl),
            
            // Content Card with Glass Effect
            Transform.translate(
              offset: Offset(0, parallax * -30),
              child: GlassCard(
                opacity: 0.7,
                blur: 15,
                padding: EdgeInsets.all(isSmallScreen ? AppSpacing.md : AppSpacing.xl),
                child: Column(
                  children: [
                    // Title
                    Text(
                      page.title,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 24 : 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isSmallScreen ? AppSpacing.sm : AppSpacing.md),
                    
                    // Description
                    Text(
                      page.description,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 14 : 16,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final Gradient gradient;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}

