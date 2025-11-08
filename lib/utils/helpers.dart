import 'package:flutter/material.dart';
import 'constants.dart';

// Global helper functions
void showSuccessSnackbar(BuildContext context, String message) {
  Helpers.showSnackBar(context, message, isError: false);
}

void showErrorSnackbar(BuildContext context, String message) {
  Helpers.showSnackBar(context, message, isError: true);
}

Future<bool?> showConfirmDialog(
  BuildContext context, {
  required String title,
  required String message,
}) {
  return Helpers.showConfirmDialog(context, title: title, message: message);
}

class Helpers {
  /// Get color by category name
  static Color getCategoryColor(String category) {
    final index = category.hashCode.abs() % AppColors.categoryColors.length;
    return AppColors.categoryColors[index];
  }
  
  /// Get icon by category name
  static IconData getCategoryIcon(String category) {
    return CategoryIcons.icons[category] ?? Icons.more_horiz;
  }
  
  /// Get budget status color
  static Color getBudgetStatusColor(double spent, double allocated) {
    if (allocated == 0) return AppColors.textSecondary;
    
    final percentage = spent / allocated;
    
    if (percentage >= 1.0) {
      return AppColors.error;
    } else if (percentage >= AppConstants.budgetDangerThreshold) {
      return AppColors.warning;
    } else if (percentage >= AppConstants.budgetWarningThreshold) {
      return AppColors.warning.withOpacity(0.7);
    } else {
      return AppColors.success;
    }
  }
  
  /// Get budget status icon
  static IconData getBudgetStatusIcon(double spent, double allocated) {
    if (allocated == 0) return Icons.info_outline;
    
    final percentage = spent / allocated;
    
    if (percentage >= 1.0) {
      return Icons.error;
    } else if (percentage >= AppConstants.budgetDangerThreshold) {
      return Icons.warning;
    } else {
      return Icons.check_circle;
    }
  }
  
  /// Show snackbar
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }
  
  /// Show loading dialog
  static void showLoadingDialog(BuildContext context, {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: AppSpacing.md),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Hide loading dialog
  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
  
  /// Show confirmation dialog
  static Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Ya',
    String cancelText = 'Tidak',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }
  
  /// Get month name
  static String getMonthName(int month) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }
  
  /// Get first day of month
  static DateTime getFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  
  /// Get last day of month
  static DateTime getLastDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59);
  }
  
  /// Check if same day
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
  
  /// Parse amount from text (handles various formats)
  static double? parseAmount(String text) {
    // Remove common words
    text = text.toLowerCase();
    text = text.replaceAll(RegExp(r'(ribu|rb|rbu|k)'), '000');
    text = text.replaceAll(RegExp(r'(juta|jt|m)'), '000000');
    text = text.replaceAll(RegExp(r'(rupiah|rp|idr)'), '');
    
    // Extract numbers
    final match = RegExp(r'(\d+\.?\d*)').firstMatch(text);
    if (match != null) {
      return double.tryParse(match.group(0) ?? '');
    }
    
    return null;
  }
  
  /// Extract category from text
  static String? extractCategory(String text, List<String> categories) {
    text = text.toLowerCase();
    for (final category in categories) {
      if (text.contains(category.toLowerCase())) {
        return category;
      }
    }
    return null;
  }
  
  /// Determine transaction type from text
  static String? determineTransactionType(String text) {
    text = text.toLowerCase();
    
    // Income keywords
    final incomeKeywords = ['gaji', 'terima', 'dapat', 'income', 'salary', 'transfer masuk', 'bonus'];
    for (final keyword in incomeKeywords) {
      if (text.contains(keyword)) {
        return 'income';
      }
    }
    
    // Expense keywords
    final expenseKeywords = ['bayar', 'beli', 'belanja', 'buat', 'expense', 'pengeluaran', 'keluar'];
    for (final keyword in expenseKeywords) {
      if (text.contains(keyword)) {
        return 'expense';
      }
    }
    
    return null;
  }
}

