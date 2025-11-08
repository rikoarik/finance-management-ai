import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../utils/constants.dart';
import '../services/subscription_service.dart';
import '../services/secure_storage_service.dart';
import '../widgets/trial_welcome_dialog.dart';
import 'profile_screen.dart';
import 'chat_screen.dart';
import 'analytics_screen.dart';
import 'smart_budget_screen.dart';
import 'transaction_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  // Widgets created once and reused (NOT const to preserve state)
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    // Create widgets once in initState
    _widgetOptions = [
      const ChatScreen(),
      const AnalyticsScreen(),
      const TransactionListScreen(),
      const SmartBudgetScreen(),
      const ProfileScreen(),
    ];
    
    _animationController = AnimationController(
      vsync: this,
      duration: AppAnimation.fast,
    );
    _animation = Tween<double>(begin: 1, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    // Start dengan opacity 1 agar langsung terlihat
    _animationController.value = 1.0;
    
    // Check if should show trial welcome dialog
    _checkAndShowTrialWelcome();
  }

  Future<void> _checkAndShowTrialWelcome() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final subscriptionService = SubscriptionService();
    final storageService = SecureStorageService();

    // Check if user is new and welcome dialog hasn't been shown
    final isNew = await subscriptionService.isNewUser(user.uid);
    final hasShown = await storageService.hasTrialWelcomeShown(user.uid);

    if (isNew && !hasShown && mounted) {
      // Wait a bit for the UI to be ready
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        TrialWelcomeDialog.show(context);
        await storageService.setTrialWelcomeShown(user.uid);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Content - langsung show tanpa fade untuk index 0 (ChatScreen)
          _selectedIndex == 0
              ? IndexedStack(
                  index: _selectedIndex,
                  children: _widgetOptions,
                )
              : FadeTransition(
                  opacity: _animation,
                  child: IndexedStack(
                    index: _selectedIndex,
                    children: _widgetOptions,
                  ),
                ),
        ],
      ),
      
      // Modern Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 20,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline_rounded),
                activeIcon: Icon(Icons.chat_bubble_rounded),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_outlined),
                activeIcon: Icon(Icons.analytics_rounded),
                label: 'Analytics',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_outlined),
                activeIcon: Icon(Icons.history_rounded),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.auto_awesome_outlined),
                activeIcon: Icon(Icons.auto_awesome_rounded),
                label: 'Budget',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.grey,
            selectedFontSize: 12,
            unselectedFontSize: 11,
            showUnselectedLabels: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
