import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../blocs/smart_budget/smart_budget_bloc.dart';
import '../blocs/smart_budget/smart_budget_event.dart';
import '../blocs/smart_budget/smart_budget_state.dart';
import '../blocs/budget/budget_bloc.dart';
import '../blocs/budget/budget_event.dart';
import '../blocs/budget/budget_state.dart';
import '../models/budget.dart';
import '../services/smart_budget_service.dart';
import '../services/database_service.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../utils/formatters.dart';
import '../widgets/custom_button.dart';
import '../widgets/empty_state.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_button.dart';
import '../widgets/budget_status_widget.dart';
import '../widgets/budget_analysis_card.dart';
import '../widgets/expense_trends_chart.dart';

class SmartBudgetScreen extends StatefulWidget {
  const SmartBudgetScreen({super.key});

  @override
  State<SmartBudgetScreen> createState() => _SmartBudgetScreenState();
}

class _SmartBudgetScreenState extends State<SmartBudgetScreen> with TickerProviderStateMixin {
  final TextEditingController _incomeController = TextEditingController();
  final SmartBudgetService _smartBudgetService = SmartBudgetService();
  final DatabaseService _databaseService = DatabaseService();
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isLoadingIncome = true;
  
  // Balance data
  double? _currentBalance;
  double? _totalIncome;
  double? _totalExpense;
  int? _daysRemainingInMonth;
  double? _averageDailyExpense;
  int? _estimatedDaysBalanceCanLast;
  
  // Analysis data
  Map<String, dynamic>? _expenseAnalysis;
  Map<String, dynamic>? _incomeAnalysis;
  Map<String, dynamic>? _expenseInsights;
  Map<String, dynamic>? _incomeInsights;
  bool _isLoadingAnalysis = false;

  // Preserve last generated result so analysis remains visible after actions
  Budget? _lastGeneratedBudget;
  Map<String, double>? _lastGeneratedBreakdown;
  String? _lastGeneratedAnalysis;
  List<String>? _lastGeneratedTips;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _loadBalanceData();
    _loadAnalysisData();
    // Load budget on screen open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BudgetBloc>().add(const BudgetEvent.loadBudget());
    });
  }

  Future<void> _loadAnalysisData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoadingAnalysis = true);

    try {
      // Get last 3 months transactions
      final transactions = await _smartBudgetService.getLastThreeMonthsTransactions(user.uid);
      
      if (transactions.isEmpty) {
        setState(() => _isLoadingAnalysis = false);
        return;
      }

      // Analyze expense patterns
      _expenseAnalysis = _smartBudgetService.analyzeSpendingPatterns(transactions);
      
      // Analyze income patterns
      final incomeTransactions = transactions.where((t) => t.type == 'income').toList();
      if (incomeTransactions.isNotEmpty) {
        _incomeAnalysis = _smartBudgetService.analyzeIncomePatterns(transactions);
      }

      // Get current budget if exists
      Budget? currentBudget;
      try {
        final budgetBloc = context.read<BudgetBloc>();
        final budgetState = budgetBloc.state;
        if (budgetState is BudgetLoaded && budgetState.budget != null) {
          currentBudget = budgetState.budget;
        }
      } catch (e) {
        // BudgetBloc might not be available in context
        print('BudgetBloc not available: $e');
      }

      // Generate AI insights (async)
      _generateInsights(currentBudget);

      if (mounted) {
        setState(() => _isLoadingAnalysis = false);
        // Reload balance to recalculate estimated days with new analysis data
        if (_expenseAnalysis != null) {
          _updateBalanceEstimate();
        }
      }
    } catch (e) {
      print('Error loading analysis: $e');
      if (mounted) {
        setState(() => _isLoadingAnalysis = false);
      }
    }
  }

  void _updateBalanceEstimate() {
    if (_currentBalance == null || _currentBalance! <= 0) return;
    
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final daysRemaining = daysInMonth - now.day + 1;
    
    double? averageDailyExpense;
    int? estimatedDays;
    
    if (_expenseAnalysis != null && _expenseAnalysis!['dailySpendingRate'] != null) {
      averageDailyExpense = (_expenseAnalysis!['dailySpendingRate'] as num).toDouble();
      if (_currentBalance! > 0 && averageDailyExpense > 0) {
        estimatedDays = (_currentBalance! / averageDailyExpense).floor();
      }
    }
    
    setState(() {
      _daysRemainingInMonth = daysRemaining;
      _averageDailyExpense = averageDailyExpense;
      _estimatedDaysBalanceCanLast = estimatedDays;
    });
  }

  Future<void> _generateInsights(Budget? currentBudget) async {
    if (_expenseAnalysis == null) return;

    try {
      // Generate expense insights with survival analysis
      _expenseInsights = await _smartBudgetService.generateExpenseInsights(
        _expenseAnalysis!,
        currentBudget,
        currentBalance: _currentBalance,
        daysRemainingInMonth: _daysRemainingInMonth,
      );

      // Generate income insights if income data exists
      if (_incomeAnalysis != null) {
        _incomeInsights = await _smartBudgetService.generateIncomeInsights(
          _incomeAnalysis!,
          _expenseAnalysis!,
        );
      }

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error generating insights: $e');
    }
  }

  Future<void> _refreshAnalysis() async {
    await _loadAnalysisData();
  }

  Future<void> _loadBalanceData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() => _isLoadingIncome = false);
      return;
    }

    try {
      // Get current month's transactions
      final now = DateTime.now();
      final monthStart = DateTime(now.year, now.month, 1);
      final monthEnd = DateTime(now.year, now.month + 1, 0);

      final transactions = await _databaseService.getTransactionsByDateRange(
        userId: user.uid,
        startDate: monthStart,
        endDate: monthEnd,
      );

      // Calculate total income and expense for current month
      final totalIncome = transactions
          .where((t) => t.type == 'income')
          .fold<double>(0, (sum, t) => sum + t.amount);
      
      final totalExpense = transactions
          .where((t) => t.type == 'expense')
          .fold<double>(0, (sum, t) => sum + t.amount);

      final currentBalance = totalIncome - totalExpense;

      // Calculate days remaining in current month
      final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
      final daysRemaining = daysInMonth - now.day + 1;

      // Get average daily expense from analysis or calculate from previous months
      double? averageDailyExpense;
      int? estimatedDays;
      
      if (_expenseAnalysis != null && _expenseAnalysis!['dailySpendingRate'] != null) {
        averageDailyExpense = (_expenseAnalysis!['dailySpendingRate'] as num).toDouble();
      } else {
        // Calculate from last 3 months if analysis not available
        final lastThreeMonths = await _smartBudgetService.getLastThreeMonthsTransactions(user.uid);
        if (lastThreeMonths.isNotEmpty) {
          final totalExpense3Months = lastThreeMonths
              .where((t) => t.type == 'expense')
              .fold<double>(0, (sum, t) => sum + t.amount);
          final daysInPeriod = 90; // 3 months
          averageDailyExpense = totalExpense3Months / daysInPeriod;
        }
      }

      // Calculate estimated days balance can last
      if (currentBalance > 0 && averageDailyExpense != null && averageDailyExpense > 0) {
        estimatedDays = (currentBalance / averageDailyExpense).floor();
      }

      if (mounted) {
        setState(() {
          _totalIncome = totalIncome;
          _totalExpense = totalExpense;
          _currentBalance = currentBalance;
          _daysRemainingInMonth = daysRemaining;
          _averageDailyExpense = averageDailyExpense;
          _estimatedDaysBalanceCanLast = estimatedDays;
          _isLoadingIncome = false;
          
          // Auto-generate budget jika balance > 0
          if (currentBalance > 0) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<SmartBudgetBloc>().add(
                SmartBudgetEvent.generateSmartBudget(currentBalance),
              );
            });
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingIncome = false);
      }
    }
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }


  void _applyBudget(Budget budget) {
    context.read<SmartBudgetBloc>().add(
      SmartBudgetEvent.applySmartBudget(budget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SmartBudgetBloc, SmartBudgetState>(
        listener: (context, state) {
          state.whenOrNull(
            generated: (budget, breakdown, analysis, tips) {
              if (!mounted) return;
              setState(() {
                _lastGeneratedBudget = budget;
                _lastGeneratedBreakdown = Map<String, double>.from(breakdown);
                _lastGeneratedAnalysis = analysis;
                _lastGeneratedTips = tips;
              });
            },
            tips: (welcomeMessage, tips, suggestedBudget) {
              if (!mounted) return;
              setState(() {
                _lastGeneratedBudget = suggestedBudget;
                _lastGeneratedBreakdown = {
                  for (final category in suggestedBudget.categories)
                    category.name: category.allocatedAmount,
                };
                _lastGeneratedAnalysis = welcomeMessage;
                _lastGeneratedTips = tips;
              });
            },
            applied: () {
              showSuccessSnackbar(context, 'Budget berhasil diterapkan! 🎉');
              // Reset to initial state after a delay
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) {
                  _incomeController.clear();
                  // Optionally navigate to analytics or stay here
                }
              });
            },
            error: (message) {
              showErrorSnackbar(context, message);
            },
          );
        },
        builder: (context, state) {
          return Column(
            children: [
              // App Bar
              AppBar(
                title: const Text('Smart Budget'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.info_outline),
                    onPressed: () => _showInfoDialog(),
                    tooltip: 'Info aturan 50/30/20',
                  ),
                ],
              ),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // AI Illustration Header
                      _buildAIIllustration(),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Saldo Saat Ini Section
                      if (_isLoadingIncome)
                        GlassCard(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Center(
                              child: Text(
                                'Memuat data saldo...',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        )
                      else if (_currentBalance != null)
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(AppSpacing.sm),
                                    decoration: BoxDecoration(
                                      gradient: _currentBalance! > 0 
                                          ? AppGradients.success 
                                          : AppGradients.error,
                                      borderRadius: BorderRadius.circular(AppRadius.md),
                                    ),
                                    child: Icon(
                                      _currentBalance! > 0 
                                          ? Icons.account_balance_wallet_rounded 
                                          : Icons.warning_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  Expanded(
                                    child: Text(
                                      'Saldo Saat Ini',
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.md),
                              // Total Income
                              _buildStatItem(
                                'Total Pendapatan',
                                _totalIncome ?? 0,
                                Icons.trending_up_rounded,
                                AppColors.success,
                              ),
                              const SizedBox(height: AppSpacing.sm),
                              // Total Expense
                              _buildStatItem(
                                'Total Pengeluaran',
                                _totalExpense ?? 0,
                                Icons.trending_down_rounded,
                                AppColors.error,
                              ),
                              const SizedBox(height: AppSpacing.md),
                              const Divider(),
                              const SizedBox(height: AppSpacing.md),
                              // Current Balance
                              _buildStatItem(
                                'Saldo Saat Ini',
                                _currentBalance!,
                                _currentBalance! > 0 
                                    ? Icons.account_balance_wallet_rounded 
                                    : Icons.warning_rounded,
                                _currentBalance! > 0 
                                    ? AppColors.primary 
                                    : AppColors.warning,
                              ),
                              
                              // Balance Duration Estimate
                              if (_currentBalance! > 0 && _estimatedDaysBalanceCanLast != null && _averageDailyExpense != null) ...[
                                const SizedBox(height: AppSpacing.md),
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  decoration: BoxDecoration(
                                    color: _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth!
                                        ? AppColors.success.withOpacity(0.1)
                                        : _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth! / 2
                                            ? AppColors.warning.withOpacity(0.1)
                                            : AppColors.error.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(AppRadius.md),
                                    border: Border.all(
                                      color: _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth!
                                          ? AppColors.success.withOpacity(0.3)
                                          : _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth! / 2
                                              ? AppColors.warning.withOpacity(0.3)
                                              : AppColors.error.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth!
                                            ? Icons.check_circle_rounded
                                            : _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth! / 2
                                                ? Icons.warning_rounded
                                                : Icons.error_rounded,
                                        color: _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth!
                                            ? AppColors.success
                                            : _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth! / 2
                                                ? AppColors.warning
                                                : AppColors.error,
                                        size: 20,
                                      ),
                                      const SizedBox(width: AppSpacing.sm),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth!
                                                  ? 'Saldo cukup untuk 1 bulan penuh'
                                                  : _estimatedDaysBalanceCanLast! >= 30
                                                      ? 'Saldo cukup untuk 1 bulan penuh'
                                                      : 'Estimasi saldo bertahan',
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth!
                                                    ? AppColors.success
                                                    : _estimatedDaysBalanceCanLast! >= _daysRemainingInMonth! / 2
                                                        ? AppColors.warning
                                                        : AppColors.error,
                                              ),
                                            ),
                                            const SizedBox(height: AppSpacing.xs / 2),
                                            Text(
                                              _estimatedDaysBalanceCanLast! >= 30
                                                  ? 'Sekitar ${_estimatedDaysBalanceCanLast} hari (${(_estimatedDaysBalanceCanLast! / 30).toStringAsFixed(1)} bulan)'
                                                  : 'Sekitar ${_estimatedDaysBalanceCanLast} hari',
                                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                color: AppColors.textSecondary,
                                              ),
                                            ),
                                            if (_estimatedDaysBalanceCanLast! < _daysRemainingInMonth!) ...[
                                              const SizedBox(height: AppSpacing.xs / 2),
                                              Text(
                                                'Rata-rata pengeluaran: ${Formatters.currency(_averageDailyExpense!)}/hari',
                                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  fontSize: 11,
                                                  color: AppColors.textSecondary,
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              
                              if (_currentBalance! > 0) ...[
                                const SizedBox(height: AppSpacing.md),
                                GradientButton(
                                  onPressed: state is SmartBudgetGenerating || state is SmartBudgetApplying
                                      ? null
                                      : () {
                                          context.read<SmartBudgetBloc>().add(
                                            SmartBudgetEvent.generateSmartBudget(_currentBalance!),
                                          );
                                        },
                                  text: state is SmartBudgetGenerating
                                      ? 'Sedang Generate...'
                                      : 'Generate Smart Budget dari Saldo',
                                  icon: Icons.auto_awesome_rounded,
                                  gradient: AppGradients.secondary,
                                  borderRadius: AppRadius.lg,
                                  isLoading: state is SmartBudgetGenerating,
                                ),
                              ] else ...[
                                const SizedBox(height: AppSpacing.md),
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.md),
                                  decoration: BoxDecoration(
                                    color: AppColors.warning.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(AppRadius.md),
                                    border: Border.all(
                                      color: AppColors.warning.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.info_outline, color: AppColors.warning, size: 20),
                                      const SizedBox(width: AppSpacing.sm),
                                      Expanded(
                                        child: Text(
                                          'Saldo tidak cukup untuk membuat budget. Perlu lebih banyak pendapatan atau kurangi pengeluaran.',
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                            color: AppColors.warning,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        )
                      else
                        GlassCard(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.md),
                            child: Text(
                              'Belum ada data transaksi bulan ini.',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Preview Section (shown after generation)
                      state.when(
                        initial: () => _buildEmptyState(),
                        analyzing: () => _buildAnalyzingState(),
                        generating: () => _buildLoadingState(),
                        generated: (budget, breakdown, analysis, tips) => _buildGeneratedState(budget, breakdown, analysis, tips),
                        tips: (welcomeMessage, tips, suggestedBudget) => _buildTipsState(welcomeMessage, tips, suggestedBudget),
                        applying: () => _buildApplyingState(),
                        applied: () => _buildAppliedStateWithSummary(),
                        error: (message) => _buildErrorState(message),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildAIIllustration() {
    return GradientGlassCard(
      gradient: AppGradients.secondary,
      child: Row(
        children: [
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Budgeting Assistant',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Aturan keuangan 50/30/20 untuk hidup lebih seimbang',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const EmptyState(
      icon: Icons.account_balance_wallet,
      title: 'Belum Ada Budget',
      message: 'Masukkan pendapatan bulanan Anda untuk generate smart budget',
    );
  }

  Widget _buildAnalyzingState() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppGradients.info.colors.map((c) => c.withOpacity(0.2)).toList(),
                ),
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Menganalisis pola pengeluaran Anda...',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return GlassCard(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.xl),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppGradients.secondary.colors.map((c) => c.withOpacity(0.2)).toList(),
                ),
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Menghitung alokasi budget optimal...',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsState(String welcomeMessage, List<String> tips, Budget suggestedBudget) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Welcome Card
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.emoji_emotions, color: Theme.of(context).colorScheme.onPrimaryContainer),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Selamat Datang!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  welcomeMessage,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        // Tips Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb, color: Theme.of(context).colorScheme.secondary),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Tips untuk Pemula',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                ...tips.map((tip) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontSize: 20)),
                      Expanded(child: Text(tip)),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        // Starter Budget
        Text(
          'Budget Starter (50/30/20)',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        
        ...suggestedBudget.categories.map((category) => _buildCategoryCard(category)),
        
        const SizedBox(height: AppSpacing.lg),
        
        // Action Button
        CustomButton(
          onPressed: () => _applyBudget(suggestedBudget),
          text: 'Gunakan Budget Ini',
          icon: Icons.check_circle,
        ),
      ],
    );
  }

  Widget _buildGeneratedState(
    Budget budget,
    Map<String, double> breakdown,
    String? analysis,
    List<String>? tips, {
    bool showActions = true,
    bool showComprehensiveAnalysis = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // AI Analysis (if available)
        if (analysis != null) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.smart_toy, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Analisis AI',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(analysis, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        
        // Summary Card
        Card(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Budget',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  formatCurrency(budget.monthlyIncome),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                _buildAllocationSummary(),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: AppSpacing.md),
        
        // AI Tips (if available)
        if (tips != null && tips.isNotEmpty) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lightbulb, color: Theme.of(context).colorScheme.secondary),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Tips Keuangan',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ...tips.map((tip) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 20)),
                        Expanded(child: Text(tip)),
                      ],
                    ),
                  )),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        
        // Category Breakdown
        Text(
          'Alokasi per Kategori',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        
        ...budget.categories.map((category) => _buildCategoryCard(category)),
        
        const SizedBox(height: AppSpacing.lg),
        
        // Action Buttons
        if (showActions) ...[
          CustomButton(
            onPressed: () => _applyBudget(budget),
            text: 'Terapkan Budget',
            icon: Icons.check_circle,
          ),
          const SizedBox(height: AppSpacing.sm),
          CustomButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/budget-planner',
                arguments: budget,
              );
            },
            text: 'Sesuaikan Manual',
            variant: ButtonVariant.outlined,
            icon: Icons.tune,
          ),
        ] else ...[
          Text(
            'Rincian di atas adalah hasil generate terakhir dan tetap tersedia untuk referensi Anda.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
          ),
        ],
        
        // Comprehensive Analysis Section
        if (showComprehensiveAnalysis && (_expenseAnalysis != null || _incomeAnalysis != null)) ...[
          const SizedBox(height: AppSpacing.xl),
          const Divider(),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Analisis Komprehensif',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          
          // Budget Status (if budget is applied)
          BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, budgetState) {
              if (budgetState is BudgetLoaded && budgetState.budget != null) {
                return BudgetStatusWidget(
                  budget: budgetState.budget!,
                  onRefresh: _refreshAnalysis,
                );
              }
              return const SizedBox.shrink();
            },
          ),
          
          // Expense Trends Chart
          if (_expenseAnalysis?['monthlyTrends'] != null) ...[
            const SizedBox(height: AppSpacing.md),
            ExpenseTrendsChart(
              monthlyTrends: (_expenseAnalysis!['monthlyTrends'] as List<dynamic>)
                  .map((e) => e as double)
                  .toList(),
            ),
          ],
          
          // Comprehensive Analysis Card
          if (_expenseAnalysis != null) ...[
            const SizedBox(height: AppSpacing.md),
            BudgetAnalysisCard(
              expenseAnalysis: _expenseAnalysis!,
              incomeAnalysis: _incomeAnalysis,
              expenseInsights: _expenseInsights,
              incomeInsights: _incomeInsights,
              isLoading: _isLoadingAnalysis,
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildAllocationSummary() {
    return Row(
      children: [
        Expanded(
          child: _buildAllocationChip(
            'Kebutuhan',
            '50%',
            AppColors.needsColor,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildAllocationChip(
            'Keinginan',
            '30%',
            AppColors.wantsColor,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: _buildAllocationChip(
            'Tabungan',
            '20%',
            AppColors.savingsColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAllocationChip(String label, String percentage, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        children: [
          Text(
            percentage,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BudgetCategory category) {
    final categoryType = _smartBudgetService.getCategoryType(category.name);
    final color = _smartBudgetService.getCategoryColor(category.name);
    final icon = CategoryIcons.icons[category.name] ?? Icons.category;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs / 2),
                Text(
                  formatCurrency(category.allocatedAmount),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.8), color],
              ),
              borderRadius: BorderRadius.circular(AppRadius.full),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  '${(category.allocationPercentage * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  _getCategoryTypeLabel(categoryType),
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCategoryTypeLabel(String type) {
    switch (type) {
      case 'needs':
        return 'Kebutuhan';
      case 'wants':
        return 'Keinginan';
      case 'savings':
        return 'Tabungan';
      default:
        return 'Lainnya';
    }
  }

  Widget _buildApplyingState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Menerapkan budget...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppliedStateWithSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildAppliedState(),
        if (_lastGeneratedBudget != null) ...[
          const SizedBox(height: AppSpacing.lg),
          _buildGeneratedState(
            _lastGeneratedBudget!,
            _lastGeneratedBreakdown ?? <String, double>{},
            _lastGeneratedAnalysis,
            _lastGeneratedTips,
            showActions: false,
            showComprehensiveAnalysis: false,
          ),
        ],
      ],
    );
  }

  Widget _buildAppliedState() {
    return Card(
      color: AppColors.success.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: AppIconSize.xl * 1.5,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Budget Berhasil Diterapkan! 🎉',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.success,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Anda dapat melihat budget Anda di tab Analytics',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Card(
      color: AppColors.error.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.error,
              size: AppIconSize.xl,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Terjadi Kesalahan',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.info_outline, color: AppColors.info),
            SizedBox(width: AppSpacing.sm),
            Text('Aturan 50/30/20'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Smart Budget menggunakan aturan keuangan 50/30/20 yang populer:',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              _buildInfoItem(
                '50% - Kebutuhan',
                'Pengeluaran penting seperti makanan, transportasi, tagihan, dan kesehatan',
                AppColors.needsColor,
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildInfoItem(
                '30% - Keinginan',
                'Pengeluaran untuk hiburan, belanja, dan hal-hal yang Anda inginkan',
                AppColors.wantsColor,
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildInfoItem(
                '20% - Tabungan',
                'Investasi dan dana darurat untuk masa depan',
                AppColors.savingsColor,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Mengerti'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, double value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  formatCurrency(value),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String title, String description, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

