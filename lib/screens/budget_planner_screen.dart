import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import '../blocs/budget/budget_bloc.dart';
import '../blocs/budget/budget_event.dart';
import '../blocs/budget/budget_state.dart';
import '../models/budget.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../utils/formatters.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/hero_header.dart';
import '../widgets/glass_card.dart';
import '../widgets/gradient_button.dart';
import '../widgets/budget_status_widget.dart';

class BudgetPlannerScreen extends StatefulWidget {
  const BudgetPlannerScreen({super.key});

  @override
  State<BudgetPlannerScreen> createState() => _BudgetPlannerScreenState();
}

class _BudgetPlannerScreenState extends State<BudgetPlannerScreen> {
  final TextEditingController _incomeController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _percentageController = TextEditingController();

  List<Map<String, dynamic>> _categories = [];
  double _totalPercentage = 0.0;

  @override
  void initState() {
    super.initState();
    context.read<BudgetBloc>().add(const BudgetEvent.loadBudget());
  }

  @override
  void dispose() {
    _incomeController.dispose();
    _categoryController.dispose();
    _percentageController.dispose();
    super.dispose();
  }

  void _addCategory() {
    final name = _categoryController.text.trim();
    final percentage = double.tryParse(_percentageController.text) ?? 0.0;

    if (name.isEmpty || percentage <= 0 || _totalPercentage + percentage > 100) {
      showErrorSnackbar(context, 'Persentase tidak valid atau melebihi 100%');
      return;
    }

    setState(() {
      _categories.add({'name': name, 'percentage': percentage});
      _totalPercentage += percentage;
      _categoryController.clear();
      _percentageController.clear();
    });
  }

  void _removeCategory(int index) {
    setState(() {
      _totalPercentage -= _categories[index]['percentage'];
      _categories.removeAt(index);
    });
  }

  Future<void> _saveBudget() async {
    if (_incomeController.text.isEmpty || _categories.isEmpty) {
      showErrorSnackbar(context, 'Harap isi pendapatan dan minimal satu kategori');
      return;
    }

    if (_totalPercentage > 100) {
      showErrorSnackbar(context, 'Total persentase tidak boleh lebih dari 100%');
      return;
    }

    final income = double.tryParse(_incomeController.text);
    if (income == null || income <= 0) {
      showErrorSnackbar(context, 'Pendapatan tidak valid');
      return;
    }

    final budgetCategories = _categories.map((cat) {
      final allocatedAmount = (income * (cat['percentage'] / 100));
      return BudgetCategory(
        name: cat['name'],
        allocationPercentage: cat['percentage'] / 100,
        allocatedAmount: allocatedAmount,
        spentAmount: 0.0,
        availableAmount: allocatedAmount,
      );
    }).toList();

    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1);

    final budget = Budget(
      id: now.millisecondsSinceEpoch.toString(),
      userId: '', // Will be set by bloc
      monthlyIncome: income,
      categories: budgetCategories,
      createdAt: now,
      monthStart: monthStart,
    );

    context.read<BudgetBloc>().add(BudgetEvent.saveBudget(budget));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BudgetBloc, BudgetState>(
        listener: (context, state) {
          state.whenOrNull(
            loaded: (budget, alerts) {
              if (budget != null && _categories.isEmpty) {
                // Load existing budget into form
                _incomeController.text = budget.monthlyIncome.toString();
                _categories = budget.categories.map((cat) => {
                  'name': cat.name,
                  'percentage': cat.allocationPercentage * 100,
                }).toList();
                _totalPercentage = _categories.fold(0.0, (sum, cat) => sum + cat['percentage']);
              }
            },
            error: (message) {
              showErrorSnackbar(context, message);
            },
          );
        },
        builder: (context, state) {
          final isLoading = state.maybeWhen(
            loading: () => true,
            orElse: () => false,
          );

          return Column(
            children: [
              // Hero Header
              CompactHeroHeader(
                title: 'Budget Planner',
                subtitle: 'Atur alokasi budget bulanan',
                gradient: AppGradients.success,
              ),
              
              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Budget Status (if budget exists)
                      BlocBuilder<BudgetBloc, BudgetState>(
                        builder: (context, budgetState) {
                          if (budgetState is BudgetLoaded && budgetState.budget != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BudgetStatusWidget(
                                  budget: budgetState.budget!,
                                  onRefresh: () {
                                    context.read<BudgetBloc>().add(
                                      const BudgetEvent.loadBudget(),
                                    );
                                  },
                                ),
                                const SizedBox(height: AppSpacing.lg),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      
                      // Donut Chart Overview (only show if categories exist)
                      if (_categories.isNotEmpty) ...[
                        _buildDonutChartOverview(),
                        const SizedBox(height: AppSpacing.lg),
                      ],
                      
                      // Income Input Card
                      GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  decoration: BoxDecoration(
                                    gradient: AppGradients.success,
                                    borderRadius: BorderRadius.circular(AppRadius.md),
                                  ),
                                  child: const Icon(
                                    Icons.account_balance_wallet_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: Text(
                                    'Pendapatan Bulanan',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.md),
                            CustomTextField(
                              controller: _incomeController,
                              label: 'Pendapatan',
                              hint: 'Contoh: 5000000',
                              prefixIcon: Icons.attach_money_rounded,
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      
                      // Category Allocation Card
                      Text(
                        'Alokasi Kategori',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      
                      GlassCard(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CustomTextField(
                                    controller: _categoryController,
                                    label: 'Nama Kategori',
                                    hint: 'Contoh: Makanan',
                                    prefixIcon: Icons.category_rounded,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: CustomTextField(
                                    controller: _percentageController,
                                    label: '%',
                                    hint: '0',
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.md),
                            
                            GradientButton(
                              text: 'Tambah Kategori',
                              icon: Icons.add_rounded,
                              onPressed: _addCategory,
                              gradient: AppGradients.primary,
                              borderRadius: AppRadius.lg,
                            ),
                            
                            const SizedBox(height: AppSpacing.lg),
                            
                            // Progress bar with gradient
                            _buildProgressBar(),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      
                      // Category List
                      if (_categories.isNotEmpty) ...[
                        Text(
                          'Kategori Budget (${_categories.length})',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        
                        ..._categories.asMap().entries.map((entry) {
                          final index = entry.key;
                          final cat = entry.value;
                          return _buildCategoryCard(index, cat);
                        }),
                      ],
                      
                      const SizedBox(height: AppSpacing.xl),
                      
                      // Save Button
                      GradientButton(
                        text: 'Simpan Budget',
                        icon: Icons.save_rounded,
                        onPressed: isLoading ? null : _saveBudget,
                        gradient: AppGradients.success,
                        isLoading: isLoading,
                        borderRadius: AppRadius.lg,
                      ),
                      
                      const SizedBox(height: AppSpacing.xl),
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
  
  Widget _buildDonutChartOverview() {
    final income = double.tryParse(_incomeController.text.replaceAll('.', '').replaceAll(',', '')) ?? 0;
    
    return GlassCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  gradient: AppGradients.info,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.pie_chart_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Overview Budget',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          
          // Donut Chart
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: _buildChartSections(),
                      centerSpaceRadius: 60,
                      sectionsSpace: 2,
                      borderData: FlBorderData(show: false),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.lg),
                
                // Legend
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _categories.asMap().entries.map((entry) {
                        final cat = entry.value;
                        final color = _getCategoryColor(entry.key);
                        final amount = income > 0 ? (income * cat['percentage'] / 100) : 0.0;
                        
                        return Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(AppRadius.sm),
                                ),
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cat['name'],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      formatCurrency(amount),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  List<PieChartSectionData> _buildChartSections() {
    return _categories.asMap().entries.map((entry) {
      final index = entry.key;
      final cat = entry.value;
      
      return PieChartSectionData(
        value: cat['percentage'],
        title: '${cat['percentage'].toStringAsFixed(0)}%',
        color: _getCategoryColor(index),
        radius: 40,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }
  
  Color _getCategoryColor(int index) {
    final colors = AppColors.chartColors;
    return colors[index % colors.length];
  }
  
  Widget _buildProgressBar() {
    final isNearLimit = _totalPercentage >= 80 && _totalPercentage < 100;
    final isOverLimit = _totalPercentage > 100;
    
    Gradient progressGradient;
    
    if (isOverLimit) {
      progressGradient = AppGradients.error;
    } else if (isNearLimit) {
      progressGradient = AppGradients.warning;
    } else {
      progressGradient = AppGradients.success;
    }
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Alokasi',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                if (isOverLimit)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.error_rounded,
                          size: 14,
                          color: AppColors.error,
                        ),
                        const SizedBox(width: AppSpacing.xs / 2),
                        Text(
                          'Melebihi',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (isNearLimit)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xs / 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          size: 14,
                          color: AppColors.warning,
                        ),
                        const SizedBox(width: AppSpacing.xs / 2),
                        Text(
                          'Hampir penuh',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.warning,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '${_totalPercentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isOverLimit ? AppColors.error : AppColors.success,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.full),
          child: SizedBox(
            height: 12,
            child: Stack(
              children: [
                // Background
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(AppRadius.full),
                  ),
                ),
                
                // Progress with gradient
                FractionallySizedBox(
                  widthFactor: (_totalPercentage / 100).clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: progressGradient,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                      boxShadow: [
                        BoxShadow(
                          color: (isOverLimit ? AppColors.error : AppColors.success)
                              .withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '0%',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
            Text(
              '100%',
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Widget _buildCategoryCard(int index, Map<String, dynamic> cat) {
    final income = double.tryParse(_incomeController.text.replaceAll('.', '').replaceAll(',', '')) ?? 0;
    final amount = income > 0 ? (income * cat['percentage'] / 100) : 0.0;
    final color = _getCategoryColor(index);
    
    return Dismissible(
      key: Key('category_$index'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await showConfirmDialog(
          context,
          title: 'Hapus Kategori',
          message: 'Yakin ingin menghapus kategori ${cat['name']}?',
        );
      },
      onDismissed: (direction) {
        _removeCategory(index);
        showSuccessSnackbar(context, 'Kategori berhasil dihapus');
      },
      background: Container(
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
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Icon(
                      Icons.category_rounded,
                      color: color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cat['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          income > 0 ? formatCurrency(amount) : '-',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
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
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Text(
                      '${cat['percentage']}%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              
              // Progress bar for this category
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.full),
                child: LinearProgressIndicator(
                  value: cat['percentage'] / 100,
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
