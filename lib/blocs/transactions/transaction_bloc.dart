import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/transaction.dart';
import '../../services/database_service.dart';
import '../../utils/constants.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final DatabaseService _databaseService;
  final FirebaseAuth _firebaseAuth;
  StreamSubscription<List<Transaction>>? _transactionSubscription;
  
  // Cache
  List<Transaction> _allTransactions = [];
  Timer? _debounceTimer;
  Timer? _filterDebounceTimer;
  String? _pendingTypeFilter; // Store pending type filter before first load
  
  // Memoization cache
  String? _lastFilterCacheKey;
  List<Transaction>? _cachedFilteredResults;
  
  // Pending filter updates for batching
  DateTime? _pendingStartDate;
  DateTime? _pendingEndDate;
  String? _pendingType;
  String? _pendingCategory;
  String _pendingSearchQuery = '';

  TransactionBloc({
    DatabaseService? databaseService,
    FirebaseAuth? firebaseAuth,
  })  : _databaseService = databaseService ?? DatabaseService(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const TransactionState.initial()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<LoadMore>(_onLoadMore);
    on<RefreshTransactions>(_onRefresh);
    on<AddTransaction>(_onAddTransaction);
    on<UpdateTransaction>(_onUpdateTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
    on<FilterByDateRange>(_onFilterByDateRange);
    on<FilterByType>(_onFilterByType);
    on<FilterByCategory>(_onFilterByCategory);
    on<SearchTransactions>(_onSearch, transformer: _debounce());
  }

  EventTransformer<SearchTransactions> _debounce<SearchTransactions>() {
    return (events, mapper) => events
        .debounceTime(const Duration(milliseconds: 300))
        .asyncExpand(mapper);
  }

  Future<void> _onLoadTransactions(
    LoadTransactions event,
    Emitter<TransactionState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      emit(const TransactionState.error('User not authenticated'));
      return;
    }

    emit(const TransactionState.loading());

    try {
      // Cancel previous subscription
      await _transactionSubscription?.cancel();

      // Subscribe to transaction stream
      _transactionSubscription = _databaseService
          .getTransactions(user.uid)
          .listen((transactions) {
        // Clear cache if data changed
        if (_allTransactions.length != transactions.length) {
          _lastFilterCacheKey = null;
          _cachedFilteredResults = null;
        }
        _allTransactions = transactions;
        _applyFiltersAndPagination();
      });
    } catch (e) {
      emit(TransactionState.error(e.toString()));
    }
  }

  void _applyFiltersAndPagination() {
    if (state is! TransactionLoaded && state is! TransactionLoadingMore) {
      // Determine effective type filter
      String? effectiveTypeFilter = _pendingTypeFilter;
      if (effectiveTypeFilter == null && state is TransactionLoaded) {
        effectiveTypeFilter = (state as TransactionLoaded).typeFilter;
      }
      effectiveTypeFilter ??= 'income';

      // Initial load - apply effective type filter
      var filtered = _applyFiltersMemoized(_allTransactions, effectiveTypeFilter, null, null, null, '');
      print('====== APPLYING INITIAL TYPE FILTER: $effectiveTypeFilter ======');
      print('Filtered transactions count: ${filtered.length}');
       
      final paginated = _paginateTransactions(filtered, 0);
       
      print('====== INITIAL STATE EMITTED ======');
      print('Type filter: $effectiveTypeFilter');
      print('Paginated count: ${paginated.length}');
       
      // ignore: invalid_use_of_visible_for_testing_member
      emit(TransactionState.loaded(
        transactions: _allTransactions,
        filteredTransactions: paginated,
        hasMore: filtered.length > AppConstants.pageSize,
        currentPage: 0,
        typeFilter: effectiveTypeFilter,
      ));
      _pendingTypeFilter = null; // Clear pending filter
    } else {
      // Update with current filters
      final currentState = state as TransactionLoaded;
      final filtered = _applyFilters(_allTransactions);
      final paginated = _paginateTransactions(filtered, currentState.currentPage);
      
      // ignore: invalid_use_of_visible_for_testing_member
      emit(currentState.copyWith(
        transactions: _allTransactions,
        filteredTransactions: paginated,
        hasMore: filtered.length > (currentState.currentPage + 1) * AppConstants.pageSize,
      ));
    }
  }
  
  /// Memoized filter application - only recalculates if filters or data changed
  List<Transaction> _applyFiltersMemoized(
    List<Transaction> transactions,
    String? typeFilter,
    DateTime? startDate,
    DateTime? endDate,
    String? categoryFilter,
    String searchQuery,
  ) {
    // Create cache key from filter parameters
    final cacheKey = _generateFilterCacheKey(
      typeFilter,
      startDate,
      endDate,
      categoryFilter,
      searchQuery,
      transactions.length,
    );
    
    // Return cached result if filters and data size haven't changed
    if (_lastFilterCacheKey == cacheKey && _cachedFilteredResults != null) {
      // Verify data hasn't changed by checking if transaction count is same
      // This is a simple check - could be enhanced with hash comparison
      return _cachedFilteredResults!;
    }
    
    // Clear cache if data changed significantly
    if (transactions.length != (_allTransactions.length)) {
      _lastFilterCacheKey = null;
      _cachedFilteredResults = null;
    }
    
    // Apply filters
    final filtered = _applyFiltersWithParams(
      transactions,
      typeFilter,
      startDate,
      endDate,
      categoryFilter,
      searchQuery,
    );
    
    // Cache the result
    _lastFilterCacheKey = cacheKey;
    _cachedFilteredResults = filtered;
    
    return filtered;
  }
  
  /// Generate cache key from filter parameters
  String _generateFilterCacheKey(
    String? typeFilter,
    DateTime? startDate,
    DateTime? endDate,
    String? categoryFilter,
    String searchQuery,
    int transactionCount,
  ) {
    return '${typeFilter ?? ''}_'
        '${startDate?.millisecondsSinceEpoch ?? ''}_'
        '${endDate?.millisecondsSinceEpoch ?? ''}_'
        '${categoryFilter ?? ''}_'
        '$searchQuery'
        '_$transactionCount';
  }
  
  /// Apply filters with explicit parameters
  List<Transaction> _applyFiltersWithParams(
    List<Transaction> transactions,
    String? typeFilter,
    DateTime? startDate,
    DateTime? endDate,
    String? categoryFilter,
    String searchQuery,
  ) {
    var filtered = transactions.toList();

    // Date range filter
    if (startDate != null || endDate != null) {
      filtered = filtered.where((t) {
        if (startDate != null && t.date.isBefore(startDate)) {
          return false;
        }
        if (endDate != null && t.date.isAfter(endDate)) {
          return false;
        }
        return true;
      }).toList();
    }

    // Type filter
    if (typeFilter != null) {
      filtered = filtered.where((t) => t.type == typeFilter).toList();
    }

    // Category filter
    if (categoryFilter != null) {
      filtered = filtered.where((t) => t.category == categoryFilter).toList();
    }

    // Search filter
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filtered = filtered.where((t) {
        final note = t.note ?? '';
        return note.toLowerCase().contains(query) ||
               t.category.toLowerCase().contains(query);
      }).toList();
    }

    // Sort by date (newest first)
    filtered.sort((a, b) => b.date.compareTo(a.date));

    return filtered;
  }
  
  /// Apply batched filter updates with debouncing
  void _applyBatchedFilters() {
    _filterDebounceTimer?.cancel();
    _filterDebounceTimer = Timer(const Duration(milliseconds: 150), () {
      // Dispatch refresh event to apply batched filters
      add(const TransactionEvent.refresh());
    });
  }
  
  /// Apply pending batched filters (called during refresh)
  void _processBatchedFilters(Emitter<TransactionState> emit) {
    if (state is! TransactionLoaded) return;
    
    final currentState = state as TransactionLoaded;
    
    // Check if there are any pending filters
    final hasPendingFilters = _pendingStartDate != null ||
        _pendingEndDate != null ||
        _pendingType != null ||
        _pendingCategory != null ||
        _pendingSearchQuery.isNotEmpty;
    
    if (!hasPendingFilters) {
      // No pending filters, just refresh with current filters
      final filtered = _applyFilters(_allTransactions);
      final paginated = _paginateTransactions(filtered, currentState.currentPage);
      
      emit(currentState.copyWith(
        filteredTransactions: paginated,
        currentPage: 0,
        hasMore: filtered.length > AppConstants.pageSize,
      ));
      return;
    }
    
    // Use pending filters if set, otherwise use current state filters
    final effectiveStartDate = _pendingStartDate ?? currentState.startDate;
    final effectiveEndDate = _pendingEndDate ?? currentState.endDate;
    final effectiveType = _pendingType ?? currentState.typeFilter;
    final effectiveCategory = _pendingCategory ?? currentState.categoryFilter;
    final effectiveSearch = _pendingSearchQuery.isNotEmpty 
        ? _pendingSearchQuery 
        : currentState.searchQuery;
    
    // Clear pending filters
    _pendingStartDate = null;
    _pendingEndDate = null;
    _pendingType = null;
    _pendingCategory = null;
    _pendingSearchQuery = '';
    
    // Invalidate cache since filters changed
    _lastFilterCacheKey = null;
    _cachedFilteredResults = null;
    
    final filtered = _applyFiltersMemoized(
      _allTransactions,
      effectiveType,
      effectiveStartDate,
      effectiveEndDate,
      effectiveCategory,
      effectiveSearch,
    );
    
    final paginated = _paginateTransactions(filtered, 0);
    
    emit(currentState.copyWith(
      startDate: effectiveStartDate,
      endDate: effectiveEndDate,
      typeFilter: effectiveType,
      categoryFilter: effectiveCategory,
      searchQuery: effectiveSearch,
      filteredTransactions: paginated,
      currentPage: 0,
      hasMore: filtered.length > AppConstants.pageSize,
    ));
  }

  List<Transaction> _applyFilters(List<Transaction> transactions) {
    if (state is! TransactionLoaded) return transactions;
    
    final currentState = state as TransactionLoaded;
    
    // Use memoized version for better performance
    return _applyFiltersMemoized(
      transactions,
      currentState.typeFilter,
      currentState.startDate,
      currentState.endDate,
      currentState.categoryFilter,
      currentState.searchQuery,
    );
  }

  List<Transaction> _paginateTransactions(List<Transaction> transactions, int page) {
    final startIndex = 0;
    final endIndex = ((page + 1) * AppConstants.pageSize).clamp(0, transactions.length);
    return transactions.sublist(startIndex, endIndex);
  }

  Future<void> _onLoadMore(LoadMore event, Emitter<TransactionState> emit) async {
    if (state is! TransactionLoaded) return;
    
    final currentState = state as TransactionLoaded;
    if (!currentState.hasMore) return;

    emit(TransactionState.loadingMore());

    final filtered = _applyFilters(_allTransactions);
    final nextPage = currentState.currentPage + 1;
    final paginated = _paginateTransactions(filtered, nextPage);

    emit(currentState.copyWith(
      filteredTransactions: paginated,
      currentPage: nextPage,
      hasMore: filtered.length > (nextPage + 1) * AppConstants.pageSize,
    ));
  }

  Future<void> _onRefresh(RefreshTransactions event, Emitter<TransactionState> emit) async {
    // Process any pending batched filters first
    _processBatchedFilters(emit);
  }

  Future<void> _onAddTransaction(
    AddTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    try {
      // Optimistic update
      if (state is TransactionLoaded) {
        // Clear cache when data changes
        _lastFilterCacheKey = null;
        _cachedFilteredResults = null;
        final optimisticTransactions = [event.transaction, ..._allTransactions];
        _allTransactions = optimisticTransactions;
        _applyFiltersAndPagination();
      }

      await _databaseService.addTransaction(event.transaction);
    } catch (e) {
      // Revert on error
      add(const RefreshTransactions());
      emit(TransactionState.error(e.toString()));
    }
  }

  Future<void> _onUpdateTransaction(
    UpdateTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    try {
      // Optimistic update
      if (state is TransactionLoaded) {
        final index = _allTransactions.indexWhere((t) => t.id == event.transaction.id);
        if (index != -1) {
          // Clear cache when data changes
          _lastFilterCacheKey = null;
          _cachedFilteredResults = null;
          _allTransactions[index] = event.transaction;
          _applyFiltersAndPagination();
        }
      }

      await _databaseService.updateTransaction(user.uid, event.transaction);
    } catch (e) {
      // Revert on error
      add(const RefreshTransactions());
      emit(TransactionState.error(e.toString()));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransaction event,
    Emitter<TransactionState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    try {
      // Optimistic update
      if (state is TransactionLoaded) {
        // Clear cache when data changes
        _lastFilterCacheKey = null;
        _cachedFilteredResults = null;
        _allTransactions.removeWhere((t) => t.id == event.id);
        _applyFiltersAndPagination();
      }

      await _databaseService.deleteTransaction(user.uid, event.id);
    } catch (e) {
      // Revert on error
      add(const RefreshTransactions());
      emit(TransactionState.error(e.toString()));
    }
  }

  Future<void> _onFilterByDateRange(
    FilterByDateRange event,
    Emitter<TransactionState> emit,
  ) async {
    if (state is! TransactionLoaded) return;

    // Batch filter updates
    _pendingStartDate = event.startDate;
    _pendingEndDate = event.endDate;
    _applyBatchedFilters();
  }

  Future<void> _onFilterByType(FilterByType event, Emitter<TransactionState> emit) async {
    if (state is! TransactionLoaded) {
      // Store pending filter if state is not loaded yet
      print('====== STORING PENDING TYPE FILTER: ${event.type} ======');
      _pendingTypeFilter = event.type;
      return;
    }
    
    print('====== APPLYING TYPE FILTER IMMEDIATELY: ${event.type} ======');

    
    // Update state with new type filter FIRST, then apply filters
    final currentState = state as TransactionLoaded;
    final updatedState = currentState.copyWith(
      typeFilter: event.type,
      currentPage: 0,
    );
    
    // Now apply filters with the updated state
    var filtered = _allTransactions.toList();
    
    // Date range filter
    if (updatedState.startDate != null || updatedState.endDate != null) {
      filtered = filtered.where((t) {
        if (updatedState.startDate != null && t.date.isBefore(updatedState.startDate!)) {
          return false;
        }
        if (updatedState.endDate != null && t.date.isAfter(updatedState.endDate!)) {
          return false;
        }
        return true;
      }).toList();
    }

    // Type filter
    if (updatedState.typeFilter != null) {
      filtered = filtered.where((t) => t.type == updatedState.typeFilter).toList();
    }

    // Category filter
    if (updatedState.categoryFilter != null) {
      filtered = filtered.where((t) => t.category == updatedState.categoryFilter).toList();
    }

    // Search filter
    if (updatedState.searchQuery.isNotEmpty) {
      final query = updatedState.searchQuery.toLowerCase();
      filtered = filtered.where((t) {
        final note = t.note ?? '';
        return note.toLowerCase().contains(query) ||
               t.category.toLowerCase().contains(query);
      }).toList();
    }

    // Sort by date (newest first)
    filtered.sort((a, b) => b.date.compareTo(a.date));
    
    final paginated = _paginateTransactions(filtered, 0);

    emit(updatedState.copyWith(
      filteredTransactions: paginated,
      hasMore: filtered.length > AppConstants.pageSize,
    ));
  }

  Future<void> _onFilterByCategory(FilterByCategory event, Emitter<TransactionState> emit) async {
    if (state is! TransactionLoaded) return;

    // Batch filter updates
    _pendingCategory = event.category;
    _applyBatchedFilters();
  }

  Future<void> _onSearch(SearchTransactions event, Emitter<TransactionState> emit) async {
    if (state is! TransactionLoaded) return;

    // Search already has debouncing via transformer, but we still batch with other filters
    final currentState = state as TransactionLoaded;
    
    // Invalidate cache for search
    _lastFilterCacheKey = null;
    _cachedFilteredResults = null;
    
    final filtered = _applyFiltersMemoized(
      _allTransactions,
      currentState.typeFilter,
      currentState.startDate,
      currentState.endDate,
      currentState.categoryFilter,
      event.query,
    );
    final paginated = _paginateTransactions(filtered, 0);

    emit(currentState.copyWith(
      searchQuery: event.query,
      filteredTransactions: paginated,
      currentPage: 0,
      hasMore: filtered.length > AppConstants.pageSize,
    ));
  }

  @override
  Future<void> close() {
    _transactionSubscription?.cancel();
    _debounceTimer?.cancel();
    _filterDebounceTimer?.cancel();
    return super.close();
  }
}

