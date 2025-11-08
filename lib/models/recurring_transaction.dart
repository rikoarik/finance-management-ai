class RecurringTransaction {
  final String id;
  final double amount;
  final String type; // 'income' or 'expense'
  final String category;
  final String note;
  final String frequency; // 'daily', 'weekly', 'monthly', 'yearly'
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime lastCreated;
  final bool isActive;

  RecurringTransaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.category,
    required this.note,
    required this.frequency,
    required this.startDate,
    this.endDate,
    required this.lastCreated,
    this.isActive = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'type': type,
      'category': category,
      'note': note,
      'frequency': frequency,
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'lastCreated': lastCreated.millisecondsSinceEpoch,
      'isActive': isActive,
    };
  }

  factory RecurringTransaction.fromMap(Map<dynamic, dynamic> map) {
    return RecurringTransaction(
      id: map['id'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      type: map['type'] ?? 'expense',
      category: map['category'] ?? 'Other',
      note: map['note'] ?? '',
      frequency: map['frequency'] ?? 'monthly',
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] ?? 0),
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'])
          : null,
      lastCreated: DateTime.fromMillisecondsSinceEpoch(map['lastCreated'] ?? 0),
      isActive: map['isActive'] ?? true,
    );
  }

  RecurringTransaction copyWith({
    String? id,
    double? amount,
    String? type,
    String? category,
    String? note,
    String? frequency,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? lastCreated,
    bool? isActive,
  }) {
    return RecurringTransaction(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      note: note ?? this.note,
      frequency: frequency ?? this.frequency,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      lastCreated: lastCreated ?? this.lastCreated,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Calculate next occurrence date
  DateTime getNextOccurrence() {
    DateTime next = lastCreated;
    
    switch (frequency) {
      case 'daily':
        next = next.add(const Duration(days: 1));
        break;
      case 'weekly':
        next = next.add(const Duration(days: 7));
        break;
      case 'monthly':
        next = DateTime(next.year, next.month + 1, next.day);
        break;
      case 'yearly':
        next = DateTime(next.year + 1, next.month, next.day);
        break;
    }
    
    return next;
  }

  /// Check if should create new transaction
  bool shouldCreateTransaction() {
    if (!isActive) return false;
    if (endDate != null && DateTime.now().isAfter(endDate!)) return false;
    
    final next = getNextOccurrence();
    return DateTime.now().isAfter(next) || DateTime.now().isAtSameMomentAs(next);
  }

  /// Get frequency display text
  String get frequencyDisplay {
    switch (frequency) {
      case 'daily':
        return 'Harian';
      case 'weekly':
        return 'Mingguan';
      case 'monthly':
        return 'Bulanan';
      case 'yearly':
        return 'Tahunan';
      default:
        return frequency;
    }
  }
  
  /// Getter for next occurrence (convenience)
  DateTime get nextOccurrence => getNextOccurrence();
}

