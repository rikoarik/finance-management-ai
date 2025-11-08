import 'dart:async';
import '../models/transaction.dart' as app_transaction;
import '../models/budget.dart';

/// Enhanced in-memory cache service with LRU eviction and automatic cleanup
class CacheService {
  static final CacheService _instance = CacheService._internal();
  factory CacheService() => _instance;
  CacheService._internal() {
    // Start periodic cleanup timer
    _cleanupTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      clearExpired();
    });
  }

  // Caches with LRU tracking
  final Map<String, _CacheEntry<List<app_transaction.Transaction>>> _transactionsCache = {};
  final Map<String, _CacheEntry<Budget>> _budgetCache = {};
  final Map<String, _CacheEntry<dynamic>> _miscCache = {};
  
  // LRU tracking - keeps access order
  final List<String> _transactionsAccessOrder = [];
  final List<String> _budgetAccessOrder = [];
  final List<String> _miscAccessOrder = [];
  
  // Size limits (prevent memory bloat)
  static const int _maxTransactionsCacheSize = 10;
  static const int _maxBudgetCacheSize = 10;
  static const int _maxMiscCacheSize = 50;
  
  // Cleanup timer
  Timer? _cleanupTimer;

  /// Get cached transactions
  List<app_transaction.Transaction>? getTransactions(String userId) {
    final entry = _transactionsCache[userId];
    if (entry != null && !entry.isExpired) {
      // Update access order for LRU
      _transactionsAccessOrder.remove(userId);
      _transactionsAccessOrder.add(userId);
      return entry.data;
    }
    _transactionsCache.remove(userId);
    _transactionsAccessOrder.remove(userId);
    return null;
  }

  /// Cache transactions
  void cacheTransactions(String userId, List<app_transaction.Transaction> transactions) {
    // Check if we need to evict due to size limit
    if (_transactionsCache.length >= _maxTransactionsCacheSize && !_transactionsCache.containsKey(userId)) {
      _evictLRUTransaction();
    }
    
    _transactionsCache[userId] = _CacheEntry(
      data: transactions,
      timestamp: DateTime.now(),
    );
    
    // Update access order
    _transactionsAccessOrder.remove(userId);
    _transactionsAccessOrder.add(userId);
  }
  
  /// Evict least recently used transaction cache entry
  void _evictLRUTransaction() {
    if (_transactionsAccessOrder.isEmpty) return;
    final lruKey = _transactionsAccessOrder.removeAt(0);
    _transactionsCache.remove(lruKey);
  }

  /// Get cached budget
  Budget? getBudget(String userId) {
    final entry = _budgetCache[userId];
    if (entry != null && !entry.isExpired) {
      // Update access order for LRU
      _budgetAccessOrder.remove(userId);
      _budgetAccessOrder.add(userId);
      return entry.data;
    }
    _budgetCache.remove(userId);
    _budgetAccessOrder.remove(userId);
    return null;
  }

  /// Cache budget
  void cacheBudget(String userId, Budget budget) {
    // Check if we need to evict due to size limit
    if (_budgetCache.length >= _maxBudgetCacheSize && !_budgetCache.containsKey(userId)) {
      _evictLRUBudget();
    }
    
    _budgetCache[userId] = _CacheEntry(
      data: budget,
      timestamp: DateTime.now(),
    );
    
    // Update access order
    _budgetAccessOrder.remove(userId);
    _budgetAccessOrder.add(userId);
  }
  
  /// Evict least recently used budget cache entry
  void _evictLRUBudget() {
    if (_budgetAccessOrder.isEmpty) return;
    final lruKey = _budgetAccessOrder.removeAt(0);
    _budgetCache.remove(lruKey);
  }

  /// Get misc cached data
  dynamic getMisc(String key) {
    final entry = _miscCache[key];
    if (entry != null && !entry.isExpired) {
      return entry.data;
    }
    _miscCache.remove(key);
    return null;
  }

  /// Cache misc data
  void cacheMisc(String key, dynamic data) {
    _miscCache[key] = _CacheEntry(
      data: data,
      timestamp: DateTime.now(),
    );
  }

  /// Generic get method
  T? get<T>(String key) {
    final entry = _miscCache[key];
    if (entry != null && !entry.isExpired) {
      // Update access order for LRU
      _miscAccessOrder.remove(key);
      _miscAccessOrder.add(key);
      return entry.data as T?;
    }
    _miscCache.remove(key);
    _miscAccessOrder.remove(key);
    return null;
  }

  /// Generic set method
  void set<T>(String key, T data) {
    // Check if we need to evict due to size limit
    if (_miscCache.length >= _maxMiscCacheSize && !_miscCache.containsKey(key)) {
      _evictLRUMisc();
    }
    
    _miscCache[key] = _CacheEntry(
      data: data,
      timestamp: DateTime.now(),
    );
    
    // Update access order
    _miscAccessOrder.remove(key);
    _miscAccessOrder.add(key);
  }
  
  /// Evict least recently used misc cache entry
  void _evictLRUMisc() {
    if (_miscAccessOrder.isEmpty) return;
    final lruKey = _miscAccessOrder.removeAt(0);
    _miscCache.remove(lruKey);
  }

  /// Clear all caches
  void clear() {
    invalidateAll();
  }

  /// Invalidate transactions cache
  void invalidateTransactions(String userId) {
    _transactionsCache.remove(userId);
  }

  /// Invalidate budget cache
  void invalidateBudget(String userId) {
    _budgetCache.remove(userId);
  }

  /// Invalidate all caches
  void invalidateAll() {
    _transactionsCache.clear();
    _budgetCache.clear();
    _miscCache.clear();
    _transactionsAccessOrder.clear();
    _budgetAccessOrder.clear();
    _miscAccessOrder.clear();
  }

  /// Clear old caches (automatic cleanup)
  void clearExpired() {
    // Clear expired entries and their access order tracking
    _transactionsCache.removeWhere((key, entry) {
      if (entry.isExpired) {
        _transactionsAccessOrder.remove(key);
        return true;
      }
      return false;
    });
    
    _budgetCache.removeWhere((key, entry) {
      if (entry.isExpired) {
        _budgetAccessOrder.remove(key);
        return true;
      }
      return false;
    });
    
    _miscCache.removeWhere((key, entry) {
      if (entry.isExpired) {
        _miscAccessOrder.remove(key);
        return true;
      }
      return false;
    });
  }
  
  /// Dispose resources
  void dispose() {
    _cleanupTimer?.cancel();
    invalidateAll();
  }
}

class _CacheEntry<T> {
  final T data;
  final DateTime timestamp;
  final Duration duration;

  _CacheEntry({
    required this.data,
    required this.timestamp,
    this.duration = const Duration(minutes: 5),
  });

  bool get isExpired => DateTime.now().difference(timestamp) > duration;
}

