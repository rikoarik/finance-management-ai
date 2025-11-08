import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/transactions/transaction_bloc.dart';
import '../blocs/transactions/transaction_event.dart';
import '../blocs/transactions/transaction_state.dart';
import '../models/transaction.dart' as app_transaction;
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../utils/formatters.dart';
import '../widgets/transaction_card.dart';
import '../widgets/empty_state.dart';
import 'transaction_form_screen.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> 
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  late TabController _tabController;
  bool _isFilterExpanded = false;
  
  // Memoization cache for grouped transactions
  List<app_transaction.Transaction>? _lastGroupedTransactions;
  Map<String, List<app_transaction.Transaction>>? _cachedGroupedTransactions;
  List<String>? _cachedSortedKeys;
  
  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();
    print('====== TransactionListScreen initState called ======');
    _scrollController.addListener(_onScroll);
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_onTabChanged);
    print('====== TabController initialized with index: ${_tabController.index} ======');
    // Set initial filter based on initial tab (index 0 = Pemasukkan = income)
    // Set filter SEBELUM load transactions agar filter langsung diterapkan
    context.read<TransactionBloc>().add(
      const TransactionEvent.filterByType('income'),
    );
    print('====== Dispatched filterByType(income) ======');
    context.read<TransactionBloc>().add(const TransactionEvent.loadTransactions());
    print('====== Dispatched loadTransactions ======');
  }
  
  void _onTabChanged() {
    print('====== Tab changed: index=${_tabController.index}, indexIsChanging=${_tabController.indexIsChanging} ======');
    if (!_tabController.indexIsChanging) {
      final bloc = context.read<TransactionBloc>();
      final currentState = bloc.state;
      
      // Apply filter based on tab
      // Tab order: Index 0 = Pemasukkan (income), Index 1 = Pengeluaran (expense)
      String typeFilter;
      if (_tabController.index == 0) {
        typeFilter = 'income'; // Tab Pemasukkan -> filter income
      } else {
        typeFilter = 'expense'; // Tab Pengeluaran -> filter expense
      }
      
      print('====== Applying type filter: $typeFilter ======');
      
      // Check if current category filter is compatible with new type filter
      if (currentState is TransactionLoaded && currentState.categoryFilter != null) {
        final isIncomeTab = typeFilter == 'income';
        final currentCategory = currentState.categoryFilter!;
        final incomeCategories = PredefinedCategories.incomeCategories;
        final expenseCategories = PredefinedCategories.expenseCategories;
        
        // Check if current category belongs to the new tab type
        final categoryBelongsToTab = isIncomeTab 
            ? incomeCategories.contains(currentCategory)
            : expenseCategories.contains(currentCategory);
        
        // If category doesn't belong to new tab, reset category filter
        if (!categoryBelongsToTab) {
          print('====== Category $currentCategory incompatible with $typeFilter, resetting ======');
          bloc.add(const TransactionEvent.filterByCategory(null));
        }
      }
      
      // Apply type filter
      bloc.add(TransactionEvent.filterByType(typeFilter));
    }
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }
  
  void _onScroll() {
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<TransactionBloc>().add(const TransactionEvent.loadMore());
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context),
          child: child!,
        );
      },
    );
    
    if (picked != null && mounted) {
      context.read<TransactionBloc>().add(
        TransactionEvent.filterByDateRange(
          startDate: picked.start,
          endDate: picked.end,
        ),
      );
    }
  }
  
  void _selectToday(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    context.read<TransactionBloc>().add(
      TransactionEvent.filterByDateRange(
        startDate: today,
        endDate: today.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1)),
      ),
    );
  }
  
  void _selectYesterday(BuildContext context) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
    context.read<TransactionBloc>().add(
      TransactionEvent.filterByDateRange(
        startDate: yesterday,
        endDate: yesterday.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1)),
      ),
    );
  }
  
  void _selectThisWeek(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekday = now.weekday; // Monday = 1, Sunday = 7
    final startOfWeek = today.subtract(Duration(days: weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7)).subtract(const Duration(milliseconds: 1));
    
    context.read<TransactionBloc>().add(
      TransactionEvent.filterByDateRange(
        startDate: startOfWeek,
        endDate: endOfWeek,
      ),
    );
  }
  
  void _selectThisMonth(BuildContext context) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 1).subtract(const Duration(milliseconds: 1));
    
    context.read<TransactionBloc>().add(
      TransactionEvent.filterByDateRange(
        startDate: startOfMonth,
        endDate: endOfMonth,
      ),
    );
  }
  
  Future<void> _selectCustomDateRange(BuildContext context) async {
    await _selectDateRange(context);
  }
  
  bool _isTodaySelected(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final todayEnd = today.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1));
    
    return startDate.year == today.year &&
           startDate.month == today.month &&
           startDate.day == today.day &&
           endDate.isAfter(today) &&
           endDate.isBefore(todayEnd.add(const Duration(seconds: 1)));
  }
  
  bool _isYesterdaySelected(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return false;
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 1));
    final yesterdayEnd = yesterday.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1));
    
    return startDate.year == yesterday.year &&
           startDate.month == yesterday.month &&
           startDate.day == yesterday.day &&
           endDate.isAfter(yesterday) &&
           endDate.isBefore(yesterdayEnd.add(const Duration(seconds: 1)));
  }
  
  bool _isThisWeekSelected(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekday = now.weekday;
    final startOfWeek = today.subtract(Duration(days: weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7)).subtract(const Duration(milliseconds: 1));
    
    return startDate.year == startOfWeek.year &&
           startDate.month == startOfWeek.month &&
           startDate.day == startOfWeek.day &&
           endDate.year == endOfWeek.year &&
           endDate.month == endOfWeek.month &&
           endDate.day == endOfWeek.day;
  }
  
  bool _isThisMonthSelected(DateTime? startDate, DateTime? endDate) {
    if (startDate == null || endDate == null) return false;
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 1).subtract(const Duration(milliseconds: 1));
    
    return startDate.year == startOfMonth.year &&
           startDate.month == startOfMonth.month &&
           startDate.day == startOfMonth.day &&
           endDate.year == endOfMonth.year &&
           endDate.month == endOfMonth.month &&
           endDate.day == endOfMonth.day;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pemasukkan', icon: Icon(Icons.trending_up_rounded)),
            Tab(text: 'Pengeluaran', icon: Icon(Icons.trending_down_rounded)),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                ),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari transaksi...',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded),
                          onPressed: () {
                            _searchController.clear();
                            context.read<TransactionBloc>().add(
                              const TransactionEvent.search(''),
                            );
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                ),
                onChanged: (value) {
                  context.read<TransactionBloc>().add(
                    TransactionEvent.search(value),
                  );
                },
              ),
            ),
          ),
          
          // Filter Pills (Category & Date Range)
          BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is! TransactionLoaded) return const SizedBox.shrink();
              
              return _buildFilterPills(state);
            },
          ),
          
          // Transaction List
          Expanded(
            child: BlocConsumer<TransactionBloc, TransactionState>(
              listener: (context, state) {
                state.whenOrNull(
                  error: (message) {
                    showErrorSnackbar(context, message);
                  },
                );
              },
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: CircularProgressIndicator()),
                  loading: () => _buildShimmerList(),
                  loadingMore: () => _buildShimmerList(),
                  loaded: (transactions, filteredTransactions, hasMore, currentPage, startDate, endDate, typeFilter, categoryFilter, searchQuery) {
                    // Gunakan filteredTransactions yang sudah di-filter sesuai tab
                    // Jangan fallback ke transactions karena akan menampilkan semua
                    final displayTransactions = filteredTransactions;
                    
                    if (displayTransactions.isEmpty) {
                      return EmptyState(
                        icon: Icons.receipt_long,
                        title: searchQuery.isNotEmpty 
                            ? 'Tidak Ditemukan'
                            : 'Tidak Ada Transaksi',
                        message: searchQuery.isNotEmpty 
                            ? 'Tidak ada transaksi yang cocok'
                            : 'Belum ada transaksi',
                        actionText: searchQuery.isEmpty ? 'Tambah Transaksi' : null,
                        onActionPressed: searchQuery.isEmpty ? () => _navigateToForm(context) : null,
                      );
                    }
                    
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<TransactionBloc>().add(
                          const TransactionEvent.refresh(),
                        );
                      },
                      child: _buildGroupedTransactionList(displayTransactions, hasMore),
                    );
                  },
                  error: (message) => EmptyState(
                    icon: Icons.error_outline,
                    title: 'Error',
                    message: message,
                    actionText: 'Coba Lagi',
                    onActionPressed: () {
                      context.read<TransactionBloc>().add(
                        const TransactionEvent.loadTransactions(),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.full),
          gradient: AppGradients.primary,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => _navigateToForm(context),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add_rounded, color: Colors.white),
        ),
      ),
    );
  }
  
  Widget _buildFilterPills(TransactionLoaded state) {
    final currentType = state.typeFilter ?? 'income'; // Default to income (tab pertama)
    final isIncome = currentType == 'income';
    
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header dengan tombol expand/collapse
          InkWell(
            onTap: () {
              setState(() {
                _isFilterExpanded = !_isFilterExpanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.filter_list_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Filter',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    _isFilterExpanded 
                        ? Icons.expand_less_rounded 
                        : Icons.expand_more_rounded,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ],
              ),
            ),
          ),
          // Content yang bisa expand/collapse
          AnimatedSize(
            duration: AppAnimation.medium,
            curve: Curves.easeInOut,
            child: _isFilterExpanded
                ? Container(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.md,
                      0,
                      AppSpacing.md,
                      AppSpacing.md,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date Range Pills
                        Text(
                          'Periode',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            children: [
                              _buildDatePill(
                                label: 'Hari Ini',
                                isSelected: _isTodaySelected(state.startDate, state.endDate),
                                onTap: () => _selectToday(context),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _buildDatePill(
                                label: 'Kemarin',
                                isSelected: _isYesterdaySelected(state.startDate, state.endDate),
                                onTap: () => _selectYesterday(context),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _buildDatePill(
                                label: 'Minggu Ini',
                                isSelected: _isThisWeekSelected(state.startDate, state.endDate),
                                onTap: () => _selectThisWeek(context),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _buildDatePill(
                                label: 'Bulan Ini',
                                isSelected: _isThisMonthSelected(state.startDate, state.endDate),
                                onTap: () => _selectThisMonth(context),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              _buildDatePill(
                                label: 'Custom',
                                isSelected: state.startDate != null && state.endDate != null && 
                                            !_isTodaySelected(state.startDate, state.endDate) &&
                                            !_isYesterdaySelected(state.startDate, state.endDate) &&
                                            !_isThisWeekSelected(state.startDate, state.endDate) &&
                                            !_isThisMonthSelected(state.startDate, state.endDate),
                                onTap: () => _selectCustomDateRange(context),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        // Category Pills
                        Text(
                          'Kategori',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
                              _buildCategoryPill(
                                label: 'Semua',
                                isSelected: state.categoryFilter == null,
                                onTap: () {
                  context.read<TransactionBloc>().add(
                                    const TransactionEvent.filterByCategory(null),
                  );
                },
              ),
                              ...(isIncome 
                                  ? PredefinedCategories.incomeCategories 
                                  : PredefinedCategories.expenseCategories).map((category) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: AppSpacing.sm),
                                  child: _buildCategoryPill(
                                    label: category,
                                    isSelected: state.categoryFilter == category,
                                    onTap: () {
                                      context.read<TransactionBloc>().add(
                                        TransactionEvent.filterByCategory(category),
                                      );
                                    },
                                  ),
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDatePill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primary 
              : Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isSelected 
                ? AppColors.primary 
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected 
                ? Colors.white 
                : Theme.of(context).textTheme.bodyMedium?.color,
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  
  Widget _buildCategoryPill({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primary 
              : Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(AppRadius.full),
        border: Border.all(
            color: isSelected 
                ? AppColors.primary 
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Text(
            label,
            style: TextStyle(
            color: isSelected 
                ? Colors.white 
                : Theme.of(context).textTheme.bodyMedium?.color,
              fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          ),
      ),
    );
  }
  
  Widget _buildGroupedTransactionList(
    List<app_transaction.Transaction> transactions,
    bool hasMore,
  ) {
    // Check if we can reuse cached grouped data
    final canUseCache = _lastGroupedTransactions != null &&
        _lastGroupedTransactions!.length == transactions.length &&
        _lastGroupedTransactions!.every((t) => transactions.any((tr) => tr.id == t.id && tr.date == t.date));
    
    Map<String, List<app_transaction.Transaction>> groupedTransactions;
    List<String> sortedKeys;
    
    if (canUseCache && _cachedGroupedTransactions != null && _cachedSortedKeys != null) {
      // Use cached data
      groupedTransactions = _cachedGroupedTransactions!;
      sortedKeys = _cachedSortedKeys!;
    } else {
      // Group transactions by date
      groupedTransactions = <String, List<app_transaction.Transaction>>{};
      
      for (final transaction in transactions) {
        final dateKey = DateFormat('yyyy-MM-dd').format(transaction.date);
        if (!groupedTransactions.containsKey(dateKey)) {
          groupedTransactions[dateKey] = [];
        }
        groupedTransactions[dateKey]!.add(transaction);
      }
      
      sortedKeys = groupedTransactions.keys.toList()
        ..sort((a, b) => b.compareTo(a)); // Sort descending (newest first)
      
      // Cache the results
      _lastGroupedTransactions = List.from(transactions);
      _cachedGroupedTransactions = groupedTransactions;
      _cachedSortedKeys = sortedKeys;
    }
    
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppSpacing.md),
      physics: const BouncingScrollPhysics(),
      cacheExtent: 500, // Cache 500 pixels worth of items for smoother scrolling
      itemCount: sortedKeys.length + (hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= sortedKeys.length) {
          return const Padding(
            padding: EdgeInsets.all(AppSpacing.md),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        
        final dateKey = sortedKeys[index];
        final dateTransactions = groupedTransactions[dateKey]!;
        final date = DateTime.parse(dateKey);
        
        return RepaintBoundary(
          child: Column(
            key: ValueKey('date_group_$dateKey'),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Date Header (Sticky) - wrapped in RepaintBoundary
              RepaintBoundary(
                child: _buildDateHeader(date, dateTransactions),
              ),
              const SizedBox(height: AppSpacing.sm),
              
              // Transactions for this date - each wrapped in RepaintBoundary
              ...dateTransactions.map((transaction) => 
                RepaintBoundary(
                  key: ValueKey('transaction_${transaction.id}'),
                  child: _buildSwipeableTransactionCard(transaction),
                ),
              ),
              
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        );
      },
    );
  }
  
  Widget _buildDateHeader(DateTime date, List<app_transaction.Transaction> transactions) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final transactionDate = DateTime(date.year, date.month, date.day);
    
    String dateLabel;
    if (transactionDate == today) {
      dateLabel = 'Hari Ini';
    } else if (transactionDate == yesterday) {
      dateLabel = 'Kemarin';
    } else {
      dateLabel = DateFormat('EEEE, dd MMM yyyy', 'id').format(date);
    }
    
    final totalIncome = transactions
        .where((t) => t.type == 'income')
        .fold<double>(0, (sum, t) => sum + t.amount);
    final totalExpense = transactions
        .where((t) => t.type == 'expense')
        .fold<double>(0, (sum, t) => sum + t.amount);
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.xs),
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: const Icon(
              Icons.calendar_today_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              dateLabel,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (totalIncome > 0) ...[
            Text(
              '+${formatCurrency(totalIncome)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ],
          if (totalExpense > 0)
            Text(
              '-${formatCurrency(totalExpense)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildSwipeableTransactionCard(app_transaction.Transaction transaction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Dismissible(
        key: Key(transaction.id),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.endToStart) {
            // Swipe left to delete
            return await showConfirmDialog(
              context,
              title: 'Hapus Transaksi',
              message: 'Yakin ingin menghapus transaksi ini?',
            );
          } else {
            // Swipe right to edit
            _navigateToForm(context, transaction: transaction);
            return false;
          }
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            context.read<TransactionBloc>().add(
              TransactionEvent.deleteTransaction(transaction.id),
            );
            showSuccessSnackbar(context, 'Transaksi berhasil dihapus');
          }
        },
        background: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            gradient: AppGradients.info,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: AppSpacing.lg),
          child: const Icon(
            Icons.edit_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        secondaryBackground: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          decoration: BoxDecoration(
            gradient: AppGradients.error,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: AppSpacing.lg),
          child: const Icon(
            Icons.delete_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
        child: TransactionCard(
          transaction: transaction,
          onTap: () => _navigateToForm(context, transaction: transaction),
          onDelete: () => _deleteTransaction(context, transaction),
        ),
      ),
    );
  }
  
  Widget _buildShimmerList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppSpacing.md),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.md),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(AppSpacing.sm),
            ),
          ),
        );
      },
    );
  }
  
  
  Future<void> _navigateToForm(
    BuildContext context, {
    app_transaction.Transaction? transaction,
  }) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<TransactionBloc>(),
          child: TransactionFormScreen(transaction: transaction),
        ),
      ),
    );
    
    if (result == true && mounted) {
      context.read<TransactionBloc>().add(
        const TransactionEvent.refresh(),
      );
    }
  }
  
  Future<void> _deleteTransaction(
    BuildContext context,
    app_transaction.Transaction transaction,
  ) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Hapus Transaksi',
      message: 'Yakin ingin menghapus transaksi ini?',
    );
    
    if (confirmed == true && mounted) {
      context.read<TransactionBloc>().add(
        TransactionEvent.deleteTransaction(transaction.id),
      );
      showSuccessSnackbar(context, 'Transaksi berhasil dihapus');
    }
  }
}
