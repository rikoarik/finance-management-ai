import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/transaction.dart' as app_transaction;
import '../services/database_service.dart';
import '../services/smart_budget_service.dart';
import '../blocs/budget/budget_bloc.dart';
import '../blocs/budget/budget_state.dart';
import '../blocs/budget/budget_event.dart';
import '../models/budget.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../widgets/empty_state.dart';
import '../widgets/stat_card.dart';
import '../widgets/glass_card.dart';
import '../widgets/animated_counter.dart';
import '../widgets/budget_status_widget.dart';
import '../widgets/budget_analysis_card.dart';
import '../widgets/expense_trends_chart.dart';

enum TimeRange { week, month, threeMonths, year, custom }

enum ChartType { pie, bar, line }

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> with SingleTickerProviderStateMixin {
  final DatabaseService _databaseService = DatabaseService();
  final SmartBudgetService _smartBudgetService = SmartBudgetService();
  final User? _user = FirebaseAuth.instance.currentUser;
  
  TimeRange _selectedTimeRange = TimeRange.month;
  ChartType _selectedChartType = ChartType.pie;
  DateTimeRange? _customDateRange;
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late TabController _tabController;
  
  // Analysis data
  Map<String, dynamic>? _expenseAnalysis;
  Map<String, dynamic>? _incomeAnalysis;
  Map<String, dynamic>? _expenseInsights;
  Map<String, dynamic>? _incomeInsights;
  bool _isLoadingAnalysis = false;
  List<app_transaction.Transaction>? _lastAnalyzedTransactions;
  
  // Pie chart interaction
  int? _selectedPieSectionIndex;
  
  DateTime get _startDate {
    final now = DateTime.now();
    switch (_selectedTimeRange) {
      case TimeRange.week:
        return now.subtract(const Duration(days: 7));
      case TimeRange.month:
        return now.subtract(const Duration(days: 30));
      case TimeRange.threeMonths:
        return now.subtract(const Duration(days: 90));
      case TimeRange.year:
        return now.subtract(const Duration(days: 365));
      case TimeRange.custom:
        return _customDateRange?.start ?? now.subtract(const Duration(days: 30));
    }
  }
  
  DateTime get _endDate {
    return _selectedTimeRange == TimeRange.custom
        ? (_customDateRange?.end ?? DateTime.now())
        : DateTime.now();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _animationController = AnimationController(
      vsync: this,
      duration: AppAnimation.medium,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    
    // Load budget on screen open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BudgetBloc>().add(const BudgetEvent.loadBudget());
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Widget _buildStatisticsTab(BuildContext context, List<app_transaction.Transaction> filteredTransactions) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Summary Cards
            _buildSummaryCards(filteredTransactions),
            const SizedBox(height: AppSpacing.md),
            
            // Budget Status Section
            BlocBuilder<BudgetBloc, BudgetState>(
              builder: (context, budgetState) {
                if (budgetState is BudgetLoaded && budgetState.budget != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status Budget',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      BudgetStatusWidget(
                        budget: budgetState.budget!,
                        onRefresh: () {
                          context.read<BudgetBloc>().add(
                            const BudgetEvent.loadBudget(),
                          );
                        },
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            
            // AI Insights/Saran Section
            if (_expenseAnalysis != null) ...[
              Text(
                'Saran & Analisis AI',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              BudgetAnalysisCard(
                expenseAnalysis: _expenseAnalysis!,
                incomeAnalysis: _incomeAnalysis,
                expenseInsights: _expenseInsights,
                incomeInsights: _incomeInsights,
                isLoading: _isLoadingAnalysis,
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChartsTab(BuildContext context, List<app_transaction.Transaction> filteredTransactions) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Income Chart
            _buildChartSection(
              'Pemasukan per Kategori',
              filteredTransactions,
              'income',
            ),
            const SizedBox(height: AppSpacing.md),
            
            // Expense Chart
            _buildChartSection(
              'Pengeluaran per Kategori',
              filteredTransactions,
              'expense',
            ),
            const SizedBox(height: AppSpacing.md),
            
            // Spending Trend
            if (_selectedChartType == ChartType.line)
              _buildSpendingTrend(filteredTransactions),
            
            // Expense Trends Chart
            if (_expenseAnalysis?['monthlyTrends'] != null) ...[
              Text(
                'Tren Pengeluaran',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              ExpenseTrendsChart(
                monthlyTrends: (_expenseAnalysis!['monthlyTrends'] as List<dynamic>)
                    .map((e) => e as double)
                    .toList(),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ],
        ),
      ),
    );
  }
  
  Future<void> _loadAnalysisData(List<app_transaction.Transaction> transactions) async {
    // Skip if same transactions already analyzed
    if (_lastAnalyzedTransactions != null && 
        _lastAnalyzedTransactions!.length == transactions.length &&
        _lastAnalyzedTransactions!.every((t) => transactions.any((tr) => tr.id == t.id))) {
      return;
    }
    
    if (transactions.isEmpty) {
      setState(() {
        _expenseAnalysis = null;
        _incomeAnalysis = null;
        _expenseInsights = null;
        _incomeInsights = null;
        _lastAnalyzedTransactions = null;
      });
      return;
    }
    
    if (_isLoadingAnalysis) return; // Prevent multiple concurrent loads
    
    setState(() {
      _isLoadingAnalysis = true;
      _lastAnalyzedTransactions = transactions.toList();
    });
    
    try {
      // Analyze expense patterns
      _expenseAnalysis = _smartBudgetService.analyzeSpendingPatterns(transactions);
      
      // Analyze income patterns
      final incomeTransactions = transactions.where((t) => t.type == 'income').toList();
      if (incomeTransactions.isNotEmpty) {
        _incomeAnalysis = _smartBudgetService.analyzeIncomePatterns(transactions);
      } else {
        _incomeAnalysis = null;
      }
      
      // Generate AI insights
      Budget? currentBudget;
      if (mounted) {
        try {
          final budgetBloc = context.read<BudgetBloc>();
          final budgetState = budgetBloc.state;
          if (budgetState is BudgetLoaded && budgetState.budget != null) {
            currentBudget = budgetState.budget;
          }
        } catch (e) {
          print('BudgetBloc not available: $e');
        }
      }
      
      // Generate expense insights
      if (_expenseAnalysis != null) {
        _expenseInsights = await _smartBudgetService.generateExpenseInsights(
          _expenseAnalysis!,
          currentBudget,
        );
      }
      
      // Generate income insights if income data exists
      if (_incomeAnalysis != null && _expenseAnalysis != null) {
        _incomeInsights = await _smartBudgetService.generateIncomeInsights(
          _incomeAnalysis!,
          _expenseAnalysis!,
        );
      } else {
        _incomeInsights = null;
      }
      
      if (mounted) {
        setState(() => _isLoadingAnalysis = false);
      }
    } catch (e) {
      print('Error loading analysis: $e');
      if (mounted) {
        setState(() {
          _isLoadingAnalysis = false;
          _lastAnalyzedTransactions = null; // Reset on error to allow retry
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Scaffold(
        body: Center(child: Text('User not authenticated')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          // Chart Type Selector
          PopupMenuButton<ChartType>(
            icon: Icon(_getChartIcon(_selectedChartType)),
            onSelected: (type) {
              setState(() => _selectedChartType = type);
              _animationController.reset();
              _animationController.forward();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ChartType.pie,
                child: Row(
                  children: [
                    Icon(_getChartIcon(ChartType.pie), size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Pie Chart'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ChartType.bar,
                child: Row(
                  children: [
                    Icon(_getChartIcon(ChartType.bar), size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Bar Chart'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: ChartType.line,
                child: Row(
                  children: [
                    Icon(_getChartIcon(ChartType.line), size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    const Text('Line Chart'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Time Range Filter with glass effect
          _buildTimeRangeFilter(),
          
          // Tab Bar
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Statistik'),
              Tab(text: 'Grafik'),
            ],
          ),
          
          // Content
          Expanded(
            child: StreamBuilder<List<app_transaction.Transaction>>(
              stream: _databaseService.getTransactions(_user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const EmptyState(
                    icon: Icons.analytics_outlined,
                    title: 'Tidak ada data',
                    message: 'Belum ada transaksi untuk ditampilkan',
                  );
                }
                
                final allTransactions = snapshot.data!;
                final filteredTransactions = _filterTransactionsByDate(allTransactions);
                
                // Load analysis data when transactions change (debounced)
                if (filteredTransactions.isNotEmpty && mounted) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      _loadAnalysisData(filteredTransactions);
                    }
                  });
                } else if (filteredTransactions.isEmpty && _expenseAnalysis != null) {
                  // Reset analysis when no transactions
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _expenseAnalysis = null;
                        _incomeAnalysis = null;
                        _expenseInsights = null;
                        _incomeInsights = null;
                        _lastAnalyzedTransactions = null;
                      });
                    }
                  });
                }
                
                if (filteredTransactions.isEmpty) {
                  return EmptyState(
                    icon: Icons.filter_alt_outlined,
                    title: 'Tidak ada data',
                    message: 'Tidak ada transaksi dalam rentang waktu yang dipilih\nKlik tombol di bawah untuk reset filter',
                    actionText: 'Reset Filter',
                    onActionPressed: () => setState(() => _selectedTimeRange = TimeRange.month),
                  );
                }
                
                return TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab 1: Statistik
                    _buildStatisticsTab(context, filteredTransactions),
                    // Tab 2: Grafik
                    _buildChartsTab(context, filteredTransactions),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getChartIcon(ChartType type) {
    switch (type) {
      case ChartType.pie:
        return Icons.pie_chart;
      case ChartType.bar:
        return Icons.bar_chart;
      case ChartType.line:
        return Icons.show_chart;
    }
  }

  Widget _buildTimeRangeFilter() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
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
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            _buildTimeChip('7 Hari', TimeRange.week, Icons.calendar_today_rounded),
            const SizedBox(width: AppSpacing.sm),
            _buildTimeChip('30 Hari', TimeRange.month, Icons.calendar_month_rounded),
            const SizedBox(width: AppSpacing.sm),
            _buildTimeChip('3 Bulan', TimeRange.threeMonths, Icons.date_range_rounded),
            const SizedBox(width: AppSpacing.sm),
            _buildTimeChip('1 Tahun', TimeRange.year, Icons.calendar_view_month_rounded),
            const SizedBox(width: AppSpacing.sm),
            _buildTimeChip(
              _customDateRange != null
                  ? '${DateFormat('dd/MM').format(_customDateRange!.start)} - ${DateFormat('dd/MM').format(_customDateRange!.end)}'
                  : 'Custom',
              TimeRange.custom,
              Icons.edit_calendar_rounded,
              onTap: _showCustomDateRangePicker,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(String label, TimeRange range, IconData icon, {VoidCallback? onTap}) {
    final isSelected = _selectedTimeRange == range;
    
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          setState(() {
            _selectedTimeRange = range;
            // Reset analysis when time range changes
            _lastAnalyzedTransactions = null;
            _expenseAnalysis = null;
            _incomeAnalysis = null;
            _expenseInsights = null;
            _incomeInsights = null;
            _animationController.reset();
            _animationController.forward();
          });
        }
      },
      child: AnimatedContainer(
        duration: AppAnimation.fast,
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          gradient: isSelected ? AppGradients.primary : null,
          color: isSelected ? null : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(
            color: isSelected 
                ? Colors.transparent 
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ] : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCustomDateRangePicker() async {
    final now = DateTime.now();
    final result = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: now,
      initialDateRange: _customDateRange ??
          DateTimeRange(
            start: now.subtract(const Duration(days: 30)),
            end: now,
          ),
    );
    
    if (result != null) {
      setState(() {
        _customDateRange = result;
        _selectedTimeRange = TimeRange.custom;
        // Reset analysis when custom date range changes
        _lastAnalyzedTransactions = null;
        _expenseAnalysis = null;
        _incomeAnalysis = null;
        _expenseInsights = null;
        _incomeInsights = null;
      });
    }
  }

  List<app_transaction.Transaction> _filterTransactionsByDate(
      List<app_transaction.Transaction> transactions) {
    return transactions.where((t) {
      return t.date.isAfter(_startDate.subtract(const Duration(days: 1))) &&
          t.date.isBefore(_endDate.add(const Duration(days: 1)));
    }).toList();
  }

  Widget _buildSummaryCards(List<app_transaction.Transaction> transactions) {
    final totalTransactions = transactions.length;
    final income = transactions
        .where((t) => t.type == 'income')
        .fold<double>(0, (sum, t) => sum + t.amount);
    final expense = transactions
        .where((t) => t.type == 'expense')
        .fold<double>(0, (sum, t) => sum + t.amount);
    final balance = income - expense;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title
        Text(
          'Statistik',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        // Balance Hero Card
        GradientGlassCard(
          gradient: balance >= 0 ? AppGradients.success : AppGradients.error,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(
                      balance >= 0 ? Icons.account_balance_rounded : Icons.warning_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Saldo',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs / 2),
                        AnimatedCounter(
                          value: balance,
                          duration: AppAnimation.slow,
                          isCurrency: true,
                          textStyle: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        
        // Transaction Count & Income
        Row(
          children: [
            Expanded(
              child: CompactStatCard(
                title: 'Transaksi',
                value: totalTransactions.toDouble(),
                icon: Icons.receipt_long_rounded,
                color: AppColors.primary,
                isCurrency: false,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: CompactStatCard(
                title: 'Pemasukan',
                value: income,
                icon: Icons.trending_up_rounded,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        
        // Expense Card
        CompactStatCard(
          title: 'Pengeluaran',
          value: expense,
          icon: Icons.trending_down_rounded,
          color: AppColors.error,
        ),
      ],
    );
  }

  Widget _buildChartSection(
    String title,
    List<app_transaction.Transaction> transactions,
    String type,
  ) {
    final filteredTransactions =
        transactions.where((t) => t.type == type).toList();

    if (filteredTransactions.isEmpty) {
      return GlassCard(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: AppGradients.primary.colors.map((c) => c.withOpacity(0.2)).toList(),
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.hourglass_empty_rounded,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Tidak ada $title',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final categoryData = <String, double>{};
    for (var t in filteredTransactions) {
      categoryData[t.category] = (categoryData[t.category] ?? 0) + t.amount;
    }

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    gradient: type == 'income' ? AppGradients.success : AppGradients.error,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(
                    type == 'income' ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            
            // Chart with container for better visual
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: _selectedChartType == ChartType.pie
                  ? _buildPieChart(categoryData, type)
                  : _selectedChartType == ChartType.bar
                      ? _buildBarChart(categoryData, type)
                      : const SizedBox.shrink(),
            ),
            
            const SizedBox(height: AppSpacing.sm),
            
            // Category Breakdown with enhanced design
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Kategori',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ...categoryData.entries.map((entry) {
                    final total = categoryData.values.fold<double>(0, (a, b) => a + b);
                    final percentage = (entry.value / total * 100).toStringAsFixed(1);
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: _getCategoryColor(entry.key),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                              boxShadow: [
                                BoxShadow(
                                  color: _getCategoryColor(entry.key).withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              entry.key,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xs / 2,
                            ),
                            decoration: BoxDecoration(
                              color: _getCategoryColor(entry.key).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(AppRadius.sm),
                            ),
                            child: Text(
                              '$percentage%',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: _getCategoryColor(entry.key),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            formatCurrency(entry.value),
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(Map<String, double> data, String type) {
    final categoryList = data.keys.toList();
    final sections = data.entries.toList().asMap().entries.map((entry) {
      final index = entry.key;
      final categoryName = entry.value.key;
      final value = entry.value.value;
      final total = data.values.fold<double>(0, (a, b) => a + b);
      final percentage = value / total * 100;
      final isSelected = _selectedPieSectionIndex == index;
      
      return PieChartSectionData(
        value: value,
        title: '${percentage.toStringAsFixed(0)}%',
        color: _getCategoryColor(categoryName),
        radius: isSelected ? 110 : 100,
        titleStyle: TextStyle(
          fontSize: isSelected ? 16 : 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();

    return SizedBox(
      height: 180,
      child: PieChart(
        PieChartData(
          sections: sections,
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          borderData: FlBorderData(show: false),
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              if (!event.isInterestedForInteractions || 
                  pieTouchResponse == null || 
                  pieTouchResponse.touchedSection == null) {
                setState(() {
                  _selectedPieSectionIndex = null;
                });
                return;
              }
              
              final touchedSectionIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
              setState(() {
                _selectedPieSectionIndex = touchedSectionIndex;
              });
              
              // Show category details
              if (touchedSectionIndex < categoryList.length) {
                final categoryName = categoryList[touchedSectionIndex];
                final categoryValue = data[categoryName] ?? 0;
                final total = data.values.fold<double>(0, (a, b) => a + b);
                final percentage = (categoryValue / total * 100).toStringAsFixed(1);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categoryName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${Formatters.currency(categoryValue)} ($percentage%)',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    backgroundColor: _getCategoryColor(categoryName),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart(Map<String, double> data, String type) {
    final maxValue = data.values.isEmpty
        ? 1.0
        : data.values.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 180,
      child: InteractiveViewer(
        minScale: 0.5,
        maxScale: 3.0,
        child: BarChart(
        BarChartData(
          maxY: maxValue * 1.2,
          barGroups: data.entries.toList().asMap().entries.map((entry) {
            final index = entry.key;
            final value = entry.value.value;
            
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: value,
                  color: _getCategoryColor(entry.value.key),
                  width: 24,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
            );
          }).toList(),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    formatCompactCurrency(value),
                    style: const TextStyle(fontSize: 10),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < data.length) {
                    final category = data.keys.toList()[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        category.substring(0, category.length > 3 ? 3 : category.length),
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: maxValue / 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
          ),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final category = data.keys.toList()[groupIndex];
                return BarTooltipItem(
                  '${category}\n${Formatters.currency(rod.toY)}',
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildSpendingTrend(List<app_transaction.Transaction> transactions) {
    final expenses = transactions.where((t) => t.type == 'expense').toList();
    
    if (expenses.isEmpty) {
      return const SizedBox.shrink();
    }

    // Group by date
    final dailyExpenses = <DateTime, double>{};
    for (var t in expenses) {
      final date = DateTime(t.date.year, t.date.month, t.date.day);
      dailyExpenses[date] = (dailyExpenses[date] ?? 0) + t.amount;
    }

    final sortedDates = dailyExpenses.keys.toList()..sort();
    final spots = sortedDates.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), dailyExpenses[entry.value]!);
    }).toList();

    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primary,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: const Icon(
                    Icons.show_chart_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    'Tren Pengeluaran',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              padding: const EdgeInsets.all(AppSpacing.md),
              child: SizedBox(
                height: 180,
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 3.0,
                  child: LineChart(
                    LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        color: AppColors.primary,
                        barWidth: 3,
                        dotData: const FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: AppColors.primary.withOpacity(0.1),
                        ),
                      ),
                    ],
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              formatCompactCurrency(value),
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < sortedDates.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  DateFormat('dd/MM').format(sortedDates[index]),
                                  style: const TextStyle(fontSize: 10),
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                    ),
                    borderData: FlBorderData(show: false),
                    lineTouchData: LineTouchData(
                      enabled: true,
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipItems: (List<LineBarSpot> touchedSpots) {
                          return touchedSpots.map((LineBarSpot touchedSpot) {
                            return LineTooltipItem(
                              '${Formatters.currency(touchedSpot.y)}\n${DateFormat('dd/MM').format(sortedDates[touchedSpot.x.toInt()])}',
                              const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    final colors = AppColors.chartColors;
    final index = category.hashCode % colors.length;
    return colors[index.abs()];
  }
}

