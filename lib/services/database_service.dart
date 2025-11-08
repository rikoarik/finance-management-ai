import 'package:firebase_database/firebase_database.dart';
import '../models/transaction.dart' as app_transaction;
import '../utils/constants.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  Future<void> addTransaction(app_transaction.Transaction transaction) async {
    await _db.child('transactions').child(transaction.userId).child(transaction.id).set(transaction.toMap());
  }

  Future<void> updateTransaction(String userId, app_transaction.Transaction transaction) async {
    await _db.child('transactions').child(userId).child(transaction.id).update(transaction.toMap());
  }

  Future<void> deleteTransaction(String userId, String transactionId) async {
    await _db.child('transactions').child(userId).child(transactionId).remove();
  }

  /// Get all transactions as a stream (for real-time updates)
  /// Note: This loads all transactions. For large datasets, consider using
  /// getTransactionsPaginated or getTransactionsStream with limit.
  Stream<List<app_transaction.Transaction>> getTransactions(String userId) {
    return _db.child('transactions').child(userId).onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final Map<dynamic, dynamic> transactionsMap = snapshot.value as Map;
        return transactionsMap.entries.map((entry) {
          return app_transaction.Transaction.fromMap(entry.key, entry.value);
        }).toList();
      }
      return [];
    });
  }

  /// Get transactions with pagination support (initial load)
  /// Returns transactions sorted by date (newest first), limited to pageSize
  Future<List<app_transaction.Transaction>> getTransactionsPaginated({
    required String userId,
    int limit = AppConstants.pageSize,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final query = _db.child('transactions').child(userId);
    
    // Apply limit if specified
    // Note: Ordering by 'date' (ISO8601 string) works lexicographically
    final limitedQuery = limit > 0 
        ? query.orderByChild('date').limitToLast(limit)
        : query;
    
    final snapshot = await limitedQuery.get();
    
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> transactionsMap = snapshot.value as Map;
      var transactions = transactionsMap.entries
          .map((entry) => app_transaction.Transaction.fromMap(entry.key, entry.value))
          .toList();
      
      // Apply date range filter if provided
      if (startDate != null || endDate != null) {
        transactions = transactions.where((transaction) {
          if (startDate != null && transaction.date.isBefore(startDate.subtract(const Duration(days: 1)))) {
            return false;
          }
          if (endDate != null && transaction.date.isAfter(endDate.add(const Duration(days: 1)))) {
            return false;
          }
          return true;
        }).toList();
      }
      
      // Sort by date (newest first)
      transactions.sort((a, b) => b.date.compareTo(a.date));
      
      // Apply limit after sorting if date filtering was applied
      if ((startDate != null || endDate != null) && limit > 0 && transactions.length > limit) {
        transactions = transactions.take(limit).toList();
      }
      
      return transactions;
    }
    return [];
  }

  /// Get transactions stream with optional limit for better performance
  /// Use this when you need real-time updates but want to limit initial data load
  Stream<List<app_transaction.Transaction>> getTransactionsStream({
    required String userId,
    int? limit,
  }) {
    final query = _db.child('transactions').child(userId);
    final limitedQuery = limit != null && limit > 0
        ? query.orderByChild('date').limitToLast(limit)
        : query;
    
    return limitedQuery.onValue.map((event) {
      final snapshot = event.snapshot;
      if (snapshot.value != null) {
        final Map<dynamic, dynamic> transactionsMap = snapshot.value as Map;
        final transactions = transactionsMap.entries
            .map((entry) => app_transaction.Transaction.fromMap(entry.key, entry.value))
            .toList();
        
        // Sort by date (newest first)
        transactions.sort((a, b) => b.date.compareTo(a.date));
        return transactions;
      }
      return [];
    });
  }

  Future<List<app_transaction.Transaction>> getTransactionsByDateRange({
    required String userId,
    required DateTime startDate,
    required DateTime endDate,
    int? limit,
  }) async {
    final query = _db.child('transactions').child(userId);
    
    // Optimize: Apply limit to reduce data transfer
    // Since we're filtering by date, we can use limitToLast as an approximation
    final optimizedQuery = limit != null && limit > 0
        ? query.orderByChild('date').limitToLast(limit * 2) // Fetch 2x to account for filtering
        : query;
    
    final snapshot = await optimizedQuery.get();
    
    if (snapshot.value != null) {
      final Map<dynamic, dynamic> transactionsMap = snapshot.value as Map;
      var transactions = transactionsMap.entries
          .map((entry) => app_transaction.Transaction.fromMap(entry.key, entry.value))
          .where((transaction) {
            return transaction.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
                   transaction.date.isBefore(endDate.add(const Duration(days: 1)));
          })
          .toList();
      
      // Sort by date (newest first)
      transactions.sort((a, b) => b.date.compareTo(a.date));
      
      // Apply limit after filtering
      if (limit != null && limit > 0 && transactions.length > limit) {
        transactions = transactions.take(limit).toList();
      }
      
      return transactions;
    }
    return [];
  }
}
