import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/transaction.dart';
import '../../services/database_service.dart';
import '../../services/cache_service.dart';
import '../transactions/transaction_bloc.dart';
import '../transactions/transaction_state.dart';
import 'analytics_event.dart';
import 'analytics_state.dart';

class AnalyticsBloc extends Bloc<AnalyticsEvent, AnalyticsState> {
  final DatabaseService _databaseService;
  final FirebaseAuth _firebaseAuth;
  final CacheService _cacheService;
  final TransactionBloc? _transactionBloc;
  StreamSubscription<List<Transaction>>? _transactionSubscription;
  StreamSubscription<TransactionState>? _transactionBlocSubscription;
  
  // Throttling for computation
  Timer? _computationThrottleTimer;
  TimeRange? _pendingTimeRange;
  List<Transaction>? _pendingTransactions;

  AnalyticsBloc({
    DatabaseService? databaseService,
    FirebaseAuth? firebaseAuth,
    CacheService? cacheService,
    TransactionBloc? transactionBloc,
  })  : _databaseService = databaseService ?? DatabaseService(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _cacheService = cacheService ?? CacheService(),
        _transactionBloc = transactionBloc,
        super(const AnalyticsState.initial()) {
    on<LoadAnalytics>(_onLoadAnalytics);
    on<ChangeTimeRange>(_onChangeTimeRange);
    on<RefreshAnalytics>(_onRefresh);
    
    // Subscribe to TransactionBloc if available
    if (_transactionBloc != null) {
      _transactionBlocSubscription = _transactionBloc.stream.listen((transactionState) {
        transactionState.maybeWhen(
          loaded: (transactions, _, __, ___, ____, _____, ______, _______, ________) {
            // Use transactions from TransactionBloc
            if (state is AnalyticsLoaded) {
              final currentState = state as AnalyticsLoaded;
              _throttledComputeAnalytics(transactions, currentState.timeRange);
            } else if (state is AnalyticsLoading) {
              // If loading, compute with default time range
              _throttledComputeAnalytics(transactions, TimeRange.month);
            }
          },
          orElse: () {},
        );
      });
    }
  }

  Future<void> _onLoadAnalytics(
    LoadAnalytics event,
    Emitter<AnalyticsState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      emit(const AnalyticsState.error('User not authenticated'));
      return;
    }

    emit(const AnalyticsState.loading());

    // If TransactionBloc is available, try to get transactions from it first
    if (_transactionBloc != null) {
      final transactionState = _transactionBloc.state;
      transactionState.maybeWhen(
        loaded: (transactions, _, __, ___, ____, _____, ______, _______, ________) {
          _computeAnalytics(transactions, TimeRange.month, emit);
          return;
        },
        orElse: () {
          // Fallback to database if TransactionBloc doesn't have data yet
          _loadFromDatabase(user.uid, TimeRange.month, emit);
        },
      );
    } else {
      // No TransactionBloc available, use database
      _loadFromDatabase(user.uid, TimeRange.month, emit);
    }
  }
  
  void _loadFromDatabase(String userId, TimeRange timeRange, Emitter<AnalyticsState> emit) {
    _transactionSubscription?.cancel();
    _transactionSubscription = _databaseService
        .getTransactions(userId)
        .listen((transactions) {
      _computeAnalytics(transactions, timeRange, emit);
    });
  }
  
  /// Throttled computation to avoid excessive recalculations
  void _throttledComputeAnalytics(List<Transaction> transactions, TimeRange timeRange) {
    _pendingTransactions = transactions;
    _pendingTimeRange = timeRange;
    
    _computationThrottleTimer?.cancel();
    _computationThrottleTimer = Timer(const Duration(milliseconds: 300), () {
      if (_pendingTransactions != null && _pendingTimeRange != null) {
        // Use add event to trigger computation through event handler
        // This ensures we're using the proper emit context
        add(ChangeTimeRange(_pendingTimeRange!));
        _pendingTransactions = null;
        _pendingTimeRange = null;
      }
    });
  }

  void _computeAnalytics(
    List<Transaction> allTransactions,
    TimeRange timeRange,
    Emitter<AnalyticsState> emit,
  ) {
    final dateRange = _getDateRange(timeRange);
    final startDate = dateRange['start'];
    final endDate = dateRange['end'];

    // Check cache
    final cacheKey = 'analytics_${timeRange.name}_${startDate?.millisecondsSinceEpoch}_${endDate?.millisecondsSinceEpoch}';
    final cachedData = _cacheService.get<Map<String, dynamic>>(cacheKey);

    if (cachedData != null) {
      // Use cached data
      emit(AnalyticsState.loaded(
        expenseByCategory: Map<String, double>.from(cachedData['expenseByCategory']),
        incomeByCategory: Map<String, double>.from(cachedData['incomeByCategory']),
        totalIncome: cachedData['totalIncome'],
        totalExpense: cachedData['totalExpense'],
        balance: cachedData['balance'],
        transactions: allTransactions,
        timeRange: timeRange,
        startDate: startDate,
        endDate: endDate,
      ));
      return;
    }

    // Filter by date range
    final filteredTransactions = allTransactions.where((t) {
      if (startDate != null && t.date.isBefore(startDate)) return false;
      if (endDate != null && t.date.isAfter(endDate)) return false;
      return true;
    }).toList();

    // Compute analytics
    final expenseByCategory = <String, double>{};
    final incomeByCategory = <String, double>{};
    double totalIncome = 0;
    double totalExpense = 0;

    for (final transaction in filteredTransactions) {
      if (transaction.type == 'expense') {
        totalExpense += transaction.amount;
        expenseByCategory[transaction.category] =
            (expenseByCategory[transaction.category] ?? 0) + transaction.amount;
      } else if (transaction.type == 'income') {
        totalIncome += transaction.amount;
        incomeByCategory[transaction.category] =
            (incomeByCategory[transaction.category] ?? 0) + transaction.amount;
      }
    }

    final balance = totalIncome - totalExpense;

    // Cache the result
    _cacheService.set(cacheKey, {
      'expenseByCategory': expenseByCategory,
      'incomeByCategory': incomeByCategory,
      'totalIncome': totalIncome,
      'totalExpense': totalExpense,
      'balance': balance,
    });

    emit(AnalyticsState.loaded(
      expenseByCategory: expenseByCategory,
      incomeByCategory: incomeByCategory,
      totalIncome: totalIncome,
      totalExpense: totalExpense,
      balance: balance,
      transactions: filteredTransactions,
      timeRange: timeRange,
      startDate: startDate,
      endDate: endDate,
    ));
  }

  Map<String, DateTime?> _getDateRange(TimeRange range) {
    final now = DateTime.now();
    DateTime? startDate;
    DateTime? endDate = now;

    switch (range) {
      case TimeRange.week:
        startDate = now.subtract(const Duration(days: 7));
        break;
      case TimeRange.month:
        startDate = DateTime(now.year, now.month, 1);
        break;
      case TimeRange.threeMonths:
        startDate = DateTime(now.year, now.month - 3, now.day);
        break;
      case TimeRange.year:
        startDate = DateTime(now.year, 1, 1);
        break;
      case TimeRange.all:
        startDate = null;
        endDate = null;
        break;
    }

    return {'start': startDate, 'end': endDate};
  }

  Future<void> _onChangeTimeRange(
    ChangeTimeRange event,
    Emitter<AnalyticsState> emit,
  ) async {
    List<Transaction> transactions;
    
    // Try to get transactions from current state or TransactionBloc
    if (state is AnalyticsLoaded) {
      final currentState = state as AnalyticsLoaded;
      transactions = currentState.transactions;
    } else if (_transactionBloc != null) {
      // Get from TransactionBloc if available
      final transactionState = _transactionBloc.state;
      final transactionList = transactionState.maybeWhen(
        loaded: (transactions, _, __, ___, ____, _____, ______, _______, ________) => transactions,
        orElse: () => <Transaction>[],
      );
      
      if (transactionList.isEmpty && _pendingTransactions != null) {
        transactions = _pendingTransactions!;
      } else {
        transactions = transactionList;
      }
    } else if (_pendingTransactions != null) {
      transactions = _pendingTransactions!;
    } else {
      // No transactions available, can't compute
      return;
    }
    
    if (transactions.isEmpty) {
      // If no transactions and we're not in loaded state, load from database
      final user = _firebaseAuth.currentUser;
      if (user != null && state is! AnalyticsLoaded) {
        _loadFromDatabase(user.uid, event.range, emit);
        return;
      }
    }
    
    _computeAnalytics(transactions, event.range, emit);
  }

  Future<void> _onRefresh(RefreshAnalytics event, Emitter<AnalyticsState> emit) async {
    _cacheService.clear();
    add(const LoadAnalytics());
  }

  @override
  Future<void> close() {
    _transactionSubscription?.cancel();
    _transactionBlocSubscription?.cancel();
    _computationThrottleTimer?.cancel();
    return super.close();
  }
}

