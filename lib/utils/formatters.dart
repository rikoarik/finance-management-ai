import 'package:intl/intl.dart';

class Formatters {
  /// Format currency (IDR)
  static String currency(double amount, {String symbol = 'Rp', bool showSymbol = true}) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: showSymbol ? symbol : '',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }
  
  /// Format currency compact (e.g., 1.5K, 2.3M)
  static String currencyCompact(double amount, {String symbol = 'Rp'}) {
    if (amount >= 1000000000) {
      return '$symbol${(amount / 1000000000).toStringAsFixed(1)}B';
    } else if (amount >= 1000000) {
      return '$symbol${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '$symbol${(amount / 1000).toStringAsFixed(1)}K';
    }
    return currency(amount, symbol: symbol);
  }
  
  /// Format date
  static String date(DateTime date, {String format = 'dd MMM yyyy'}) {
    return DateFormat(format, 'id_ID').format(date);
  }
  
  /// Format date time
  static String dateTime(DateTime date, {String format = 'dd MMM yyyy HH:mm'}) {
    return DateFormat(format, 'id_ID').format(date);
  }
  
  /// Format time
  static String time(DateTime date) {
    return DateFormat('HH:mm', 'id_ID').format(date);
  }
  
  /// Format relative time (e.g., "2 hours ago", "yesterday")
  static String relativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inSeconds < 60) {
      return 'Baru saja';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit yang lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inDays < 7) {
      if (difference.inDays == 1) {
        return 'Kemarin';
      }
      return '${difference.inDays} hari yang lalu';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks minggu yang lalu';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months bulan yang lalu';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years tahun yang lalu';
    }
  }
  
  /// Format percentage
  static String percentage(double value, {int decimals = 1}) {
    return '${value.toStringAsFixed(decimals)}%';
  }
  
  /// Format number with separator
  static String number(double number, {int decimals = 0}) {
    final formatter = NumberFormat.decimalPattern('id_ID');
    return formatter.format(number);
  }
  
  /// Parse currency string to double
  static double? parseCurrency(String value) {
    // Remove non-numeric characters except dot and comma
    final cleanValue = value.replaceAll(RegExp(r'[^0-9,.]'), '');
    // Replace comma with dot
    final normalizedValue = cleanValue.replaceAll(',', '.');
    return double.tryParse(normalizedValue);
  }
  
  /// Format transaction type
  static String transactionType(String type) {
    switch (type.toLowerCase()) {
      case 'income':
        return 'Pemasukan';
      case 'expense':
        return 'Pengeluaran';
      default:
        return type;
    }
  }
}

// Global helper functions for easy access
String formatCurrency(double amount) => Formatters.currency(amount);
String formatCompactCurrency(double amount) => Formatters.currencyCompact(amount);
String formatDate(DateTime date) => Formatters.date(date);
String formatDateTime(DateTime date) => Formatters.dateTime(date);
String formatTime(DateTime date) => Formatters.time(date);
String formatRelativeTime(DateTime date) => Formatters.relativeTime(date);
String formatPercentage(double value) => Formatters.percentage(value);
String formatNumber(double number) => Formatters.number(number);

