class Transaction {
  final String id;
  final String userId;
  final String type; // 'income' or 'expense'
  final double amount;
  final String category;
  final DateTime date;
  final String? note;

  Transaction({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'type': type,
      'amount': amount,
      'category': category,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  factory Transaction.fromMap(String id, Map<dynamic, dynamic> map) {
    return Transaction(
      id: id,
      userId: map['userId'] ?? '',
      type: map['type'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      category: map['category'] ?? '',
      date: DateTime.parse(map['date'] ?? DateTime.now().toIso8601String()),
      note: map['note'],
    );
  }

  Transaction copyWith({
    String? id,
    String? userId,
    String? type,
    double? amount,
    String? category,
    DateTime? date,
    String? note,
  }) {
    return Transaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }
}
