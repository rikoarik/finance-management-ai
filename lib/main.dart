import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/auth/auth_event.dart';
import 'blocs/auth/auth_state.dart';
import 'blocs/theme/theme_bloc.dart';
import 'blocs/theme/theme_state.dart';
import 'blocs/settings/settings_bloc.dart';
import 'blocs/settings/settings_event.dart';
import 'blocs/transactions/transaction_bloc.dart';
import 'blocs/budget/budget_bloc.dart';
import 'blocs/chat/chat_bloc.dart';
import 'blocs/analytics/analytics_bloc.dart';
import 'blocs/categories/category_bloc.dart';
import 'blocs/recurring/recurring_bloc.dart';
import 'blocs/export_import/export_import_bloc.dart';
import 'blocs/smart_budget/smart_budget_bloc.dart';
import 'utils/app_theme.dart';
import 'utils/constants.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/category_management_screen.dart';
import 'screens/export_import_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/recurring_transactions_screen.dart';
import 'screens/budget_planner_screen.dart';
import 'screens/notification_settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hydrated Storage for persistent BLoC states
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('id')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: MultiBlocProvider(
        providers: [
          // Core BLoCs
          BlocProvider(
            create: (_) => AuthBloc()..add(const CheckAuthStatus()),
          ),
          BlocProvider(
            create: (_) => ThemeBloc(),
          ),
          BlocProvider(
            create: (_) => SettingsBloc()..add(const LoadSettings()),
          ),
          
          // Feature BLoCs
          // TransactionBloc is kept non-lazy as it's used by multiple screens
          BlocProvider(
            create: (_) => TransactionBloc(),
          ),
          // Other feature BLoCs are lazy-loaded for better startup performance
          BlocProvider(
            create: (_) => BudgetBloc(),
            lazy: true,
          ),
          BlocProvider(
            create: (_) => ChatBloc(),
            lazy: true,
          ),
          BlocProvider(
            create: (context) => AnalyticsBloc(
              transactionBloc: context.read<TransactionBloc>(),
            ),
            lazy: true,
          ),
          BlocProvider(
            create: (_) => CategoryBloc(),
            lazy: true,
          ),
          BlocProvider(
            create: (_) => RecurringBloc(),
            lazy: true,
          ),
          BlocProvider(
            create: (_) => ExportImportBloc(),
            lazy: true,
          ),
          BlocProvider(
            create: (context) => SmartBudgetBloc(
              settingsBloc: context.read<SettingsBloc>(),
            ),
            lazy: true,
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  Future<bool> _checkFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.keyFirstTime) ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'app_name'.tr(),
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeState.themeMode,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          initialRoute: '/',
          routes: {
            '/': (context) => FutureBuilder<bool>(
                  future: _checkFirstTime(),
                  builder: (context, firstTimeSnapshot) {
                    if (firstTimeSnapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    }
                    
                    // If first time, show onboarding
                    if (firstTimeSnapshot.data == true) {
                      return const OnboardingScreen();
                    }
                    
                    // Otherwise check auth state with BLoC
                    return BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, authState) {
                        return authState.when(
                          initial: () => const Scaffold(
                            body: Center(child: CircularProgressIndicator()),
                          ),
                          loading: () => const Scaffold(
                            body: Center(child: CircularProgressIndicator()),
                          ),
                          authenticated: (_) => const HomeScreen(),
                          unauthenticated: () => const LoginScreen(),
                          error: (_) => const LoginScreen(),
                        );
                      },
                    );
                  },
                ),
            '/register': (context) => const RegisterScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/category-management': (context) => const CategoryManagementScreen(),
            '/export-import': (context) => const ExportImportScreen(),
            '/recurring-transactions': (context) => const RecurringTransactionsScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
            '/budget-planner': (context) => const BudgetPlannerScreen(),
            '/notification-settings': (context) => const NotificationSettingsScreen(),
          },
        );
      },
    );
  }
}
