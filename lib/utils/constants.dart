import 'package:flutter/material.dart';

/// App Constants
class AppConstants {
  // App Info
  static const String appName = 'Finance Chat';
  static const String appVersion = '1.0.0';
  
  // API Defaults
  static const String geminiModel = 'gemini-2.5-flash-lite';  // Using stable model
  static const String defaultGeminiApiKey = 'AIzaSyDZJ7A7Z7aO7Jqvr9hsEI3goAPNR3kcxuk'; // Fallback API key (set your default here)
  
  // Storage Keys
  static const String keyApiKey = 'api_key';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyFirstTime = 'first_time';
  static const String keyDailyNotification = 'daily_notification';
  static const String keyBudgetAlert = 'budget_alert';
  static const String keyWeeklySummary = 'weekly_summary';
  static const String keyDeviceId = 'device_id';
  static const String keyTrialWelcomeShown = 'trial_welcome_shown';
  
  // AI Provider (only Gemini supported)
  static const String aiProviderGemini = 'gemini';
  
  // Subscription Types
  static const String subscriptionTypeTrial = 'trial';
  static const String subscriptionTypeProMonthly = 'pro_monthly';
  static const String subscriptionTypeProUnlimited = 'pro_unlimited';
  
  // Date Formats
  static const String dateFormatDisplay = 'dd MMM yyyy';
  static const String dateFormatFull = 'dd MMMM yyyy';
  static const String dateTimeFormat = 'dd MMM yyyy HH:mm';
  
  // Pagination
  static const int pageSize = 20;
  
  // Budget Alert Thresholds
  static const double budgetWarningThreshold = 0.8; // 80%
  static const double budgetDangerThreshold = 0.9; // 90%
  
  // Budget Analysis
  static const int budgetAnalysisMonths = 3;
  static const int minTransactionsForAnalysis = 5;
  
  // Smart Budget Allocation (50/30/20 rule)
  static const double needsPercentage = 0.50;
  static const double wantsPercentage = 0.30;
  static const double savingsPercentage = 0.20;
  
  // Category allocations
  static const Map<String, double> smartBudgetAllocation = {
    'Food': 0.20,
    'Transport': 0.10,
    'Bills': 0.15,
    'Health': 0.05,
    'Shopping': 0.10,
    'Entertainment': 0.10,
    'Other': 0.10,
    'Investment': 0.15,
    'Savings': 0.05,
  };
}

/// App Colors
class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6366F1); // Indigo
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFF818CF8);
  
  // Secondary Colors
  static const Color secondary = Color(0xFF8B5CF6); // Purple
  static const Color accent = Color(0xFFEC4899); // Pink
  
  // Semantic Colors
  static const Color success = Color(0xFF10B981); // Green
  static const Color warning = Color(0xFFF59E0B); // Orange
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Blue
  
  // Income & Expense
  static const Color income = Color(0xFF10B981); // Green
  static const Color expense = Color(0xFFEF4444); // Red
  
  // Background (Light Mode)
  static const Color background = Color(0xFFF9FAFB);
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF3F4F6);
  
  // Background (Dark Mode)
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF1F2937);
  static const Color surfaceVariantDark = Color(0xFF374151);
  
  // Text (Light Mode)
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textDisabled = Color(0xFF9CA3AF);
  
  // Text (Dark Mode)
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFFD1D5DB);
  static const Color textTertiaryDark = Color(0xFF9CA3AF);
  
  // Border (Dark Mode)
  static const Color borderDark = Color(0xFF374151);
  
  // Borders & Dividers
  static const Color border = Color(0xFFE5E7EB);
  static const Color divider = Color(0xFFE5E7EB);
  
  // Grays
  static const Color greyLight = Color(0xFFF3F4F6);
  static const Color grey = Color(0xFF9CA3AF);
  static const Color greyDark = Color(0xFF4B5563);
  
  // Budget Type Colors
  static const Color needsColor = Color(0xFF3B82F6); // Blue for needs
  static const Color wantsColor = Color(0xFF8B5CF6); // Purple for wants
  static const Color savingsColor = Color(0xFF10B981); // Green for savings
  
  // Category Colors
  static const List<Color> categoryColors = [
    Color(0xFFEF4444), // Red
    Color(0xFFF59E0B), // Orange
    Color(0xFFFBBF24), // Yellow
    Color(0xFF10B981), // Green
    Color(0xFF3B82F6), // Blue
    Color(0xFF6366F1), // Indigo
    Color(0xFF8B5CF6), // Purple
    Color(0xFFEC4899), // Pink
    Color(0xFF14B8A6), // Teal
    Color(0xFF06B6D4), // Cyan
  ];
  
  // Chart Colors
  static const List<Color> chartColors = [
    Color(0xFF6366F1), // Indigo
    Color(0xFF8B5CF6), // Purple
    Color(0xFFEC4899), // Pink
    Color(0xFF10B981), // Green
    Color(0xFF3B82F6), // Blue
    Color(0xFFF59E0B), // Orange
    Color(0xFFEF4444), // Red
    Color(0xFF14B8A6), // Teal
  ];
}

/// App Spacing
class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;
}

/// App Radius
class AppRadius {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double full = 9999.0;
}

/// App Icon Sizes
class AppIconSize {
  static const double sm = 16.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 48.0;
}

/// App Elevations
class AppElevation {
  static const double none = 0.0;
  static const double sm = 2.0;
  static const double md = 4.0;
  static const double lg = 8.0;
  static const double xl = 16.0;
  static const double xxl = 24.0;
}

/// Glass Morphism Effects
class AppGlass {
  static const double blur = 10.0;
  static const double blurLight = 5.0;
  static const double blurHeavy = 20.0;
  static const double opacity = 0.8;
  static const double opacityLight = 0.9;
  static const double opacityHeavy = 0.6;
}

/// Animation Durations
class AppAnimation {
  static const Duration instant = Duration(milliseconds: 100);
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);
}

/// Gradient Definitions
class AppGradients {
  static const LinearGradient primary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6366F1), // Indigo
      Color(0xFF8B5CF6), // Purple
    ],
  );
  
  static const LinearGradient secondary = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF8B5CF6), // Purple
      Color(0xFFEC4899), // Pink
    ],
  );
  
  static const LinearGradient success = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF10B981), // Green
      Color(0xFF14B8A6), // Teal
    ],
  );
  
  static const LinearGradient warning = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFF59E0B), // Orange
      Color(0xFFFBBF24), // Yellow
    ],
  );
  
  static const LinearGradient error = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFEF4444), // Red
      Color(0xFFF97316), // Orange-red
    ],
  );
  
  static const LinearGradient info = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF3B82F6), // Blue
      Color(0xFF06B6D4), // Cyan
    ],
  );
  
  static const LinearGradient background = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF9FAFB),
      Color(0xFFFFFFFF),
    ],
  );
  
  static const LinearGradient backgroundDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF111827),
      Color(0xFF1F2937),
    ],
  );
}

/// Category Icons
class CategoryIcons {
  static const Map<String, IconData> icons = {
    'Food': Icons.restaurant,
    'Transport': Icons.directions_car,
    'Shopping': Icons.shopping_bag,
    'Entertainment': Icons.movie,
    'Health': Icons.medical_services,
    'Education': Icons.school,
    'Bills': Icons.receipt,
    'Salary': Icons.attach_money,
    'Investment': Icons.trending_up,
    'Gift': Icons.card_giftcard,
    'Other': Icons.category,
    'Savings': Icons.savings,
  };
}

/// Predefined Categories
class PredefinedCategories {
  static const List<String> expenseCategories = [
    'Food',
    'Transport',
    'Shopping',
    'Entertainment',
    'Health',
    'Education',
    'Bills',
    'Other',
  ];
  
  static const List<String> incomeCategories = [
    'Salary',
    'Investment',
    'Gift',
    'Other',
  ];
  
  // Category definitions with icons and colors
  static const List<Map<String, dynamic>> expenseCategoriesWithData = [
    {'name': 'Food', 'icon': 'restaurant', 'color': 0xFFEF4444},
    {'name': 'Transport', 'icon': 'directions_car', 'color': 0xFF3B82F6},
    {'name': 'Shopping', 'icon': 'shopping_bag', 'color': 0xFFEC4899},
    {'name': 'Entertainment', 'icon': 'movie', 'color': 0xFF8B5CF6},
    {'name': 'Health', 'icon': 'local_hospital', 'color': 0xFF10B981},
    {'name': 'Education', 'icon': 'school', 'color': 0xFF6366F1},
    {'name': 'Bills', 'icon': 'receipt', 'color': 0xFFF59E0B},
    {'name': 'Other', 'icon': 'more_horiz', 'color': 0xFF9CA3AF},
  ];
  
  static const List<Map<String, dynamic>> incomeCategoriesWithData = [
    {'name': 'Salary', 'icon': 'account_balance_wallet', 'color': 0xFF10B981},
    {'name': 'Investment', 'icon': 'trending_up', 'color': 0xFF3B82F6},
    {'name': 'Gift', 'icon': 'card_giftcard', 'color': 0xFFEC4899},
    {'name': 'Other', 'icon': 'more_horiz', 'color': 0xFF9CA3AF},
  ];
}
