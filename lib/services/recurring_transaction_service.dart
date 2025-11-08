import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../models/recurring_transaction.dart';
import '../models/transaction.dart' as app_transaction;
import 'database_service.dart';

class RecurringTransactionService {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();
  
  String? get _userPath {
    final userId = _auth.currentUser?.uid;
    return userId != null ? 'users/$userId/recurring_transactions' : null;
  }

  /// Get all recurring transactions
  Stream<List<RecurringTransaction>> getRecurringTransactions() {
    if (_userPath == null) return Stream.value([]);
    
    return _database.child(_userPath!).onValue.map((event) {
      if (!event.snapshot.exists) return <RecurringTransaction>[];
      
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      return data.entries
          .map((e) => RecurringTransaction.fromMap(e.value as Map))
          .toList()
        ..sort((a, b) => b.startDate.compareTo(a.startDate));
    });
  }

  /// Add recurring transaction
  Future<void> addRecurringTransaction(RecurringTransaction recurring) async {
    if (_userPath == null) throw Exception('User not authenticated');
    
    final recurringWithId = recurring.copyWith(
      id: recurring.id.isEmpty ? const Uuid().v4() : recurring.id,
      lastCreated: DateTime.now(),
    );
    
    await _database
        .child(_userPath!)
        .child(recurringWithId.id)
        .set(recurringWithId.toMap());
  }

  /// Update recurring transaction
  Future<void> updateRecurringTransaction(RecurringTransaction recurring) async {
    if (_userPath == null) throw Exception('User not authenticated');
    
    await _database
        .child(_userPath!)
        .child(recurring.id)
        .update(recurring.toMap());
  }

  /// Delete recurring transaction
  Future<void> deleteRecurringTransaction(String id) async {
    if (_userPath == null) throw Exception('User not authenticated');
    
    await _database.child(_userPath!).child(id).remove();
  }

  /// Toggle active status
  Future<void> toggleActive(String id, bool isActive) async {
    if (_userPath == null) throw Exception('User not authenticated');
    
    await _database.child(_userPath!).child(id).update({
      'isActive': isActive,
    });
  }

  /// Process recurring transactions - create new transactions if needed
  Future<int> processRecurringTransactions() async {
    if (_userPath == null) return 0;
    
    final snapshot = await _database.child(_userPath!).get();
    if (!snapshot.exists) return 0;
    
    final data = snapshot.value as Map<dynamic, dynamic>;
    final recurring = data.entries
        .map((e) => RecurringTransaction.fromMap(e.value as Map))
        .toList();
    
    int created = 0;
    
    for (var r in recurring) {
      if (r.shouldCreateTransaction()) {
        // Create new transaction
        final transaction = app_transaction.Transaction(
          id: const Uuid().v4(),
          userId: _auth.currentUser!.uid,
          amount: r.amount,
          type: r.type,
          category: r.category,
          note: '${r.note} (Otomatis)',
          date: DateTime.now(),
        );
        
        await _databaseService.addTransaction(transaction);
        
        // Update lastCreated date
        await _database.child(_userPath!).child(r.id).update({
          'lastCreated': DateTime.now().millisecondsSinceEpoch,
        });
        
        created++;
      }
    }
    
    return created;
  }
}

