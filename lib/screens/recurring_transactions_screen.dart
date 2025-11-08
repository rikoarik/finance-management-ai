import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/recurring/recurring_bloc.dart';
import '../blocs/recurring/recurring_event.dart';
import '../blocs/recurring/recurring_state.dart';
import '../models/recurring_transaction.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';
import '../utils/helpers.dart';
import '../widgets/empty_state.dart';
import '../widgets/glass_card.dart';
import 'recurring_transaction_form_screen.dart';

class RecurringTransactionsScreen extends StatefulWidget {
  const RecurringTransactionsScreen({super.key});

  @override
  State<RecurringTransactionsScreen> createState() => _RecurringTransactionsScreenState();
}

class _RecurringTransactionsScreenState extends State<RecurringTransactionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RecurringBloc>().add(const RecurringEvent.loadRecurring());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Berulang'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.primary,
        ),
        child: SafeArea(
          child: BlocConsumer<RecurringBloc, RecurringState>(
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
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (transactions) {
                if (transactions.isEmpty) {
                  return EmptyState(
                    icon: Icons.repeat,
                    title: 'Tidak Ada Transaksi Berulang',
                    message: 'Belum ada transaksi berulang',
                    actionText: 'Tambah Transaksi Berulang',
                    onActionPressed: () => _navigateToForm(),
                  );
                }
                
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<RecurringBloc>().add(const RecurringEvent.loadRecurring());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final recurring = transactions[index];
                      return _buildRecurringCard(recurring);
                    },
                  ),
                );
              },
              processing: () => const Center(child: CircularProgressIndicator()),
              processed: (count) => const Center(child: CircularProgressIndicator()),
              error: (message) => EmptyState(
                icon: Icons.error_outline,
                title: 'Error',
                message: message,
                actionText: 'Coba Lagi',
                onActionPressed: () {
                  context.read<RecurringBloc>().add(const RecurringEvent.loadRecurring());
                },
              ),
            );
          },
        ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.full),
          gradient: AppGradients.secondary,
          boxShadow: [
            BoxShadow(
              color: AppColors.secondary.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => _navigateToForm(),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add_rounded, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildRecurringCard(RecurringTransaction recurring) {
    final isExpense = recurring.type == 'expense';
    final color = isExpense ? AppColors.error : AppColors.success;
    final frequencyText = _getFrequencyText(recurring.frequency);
    final nextDate = recurring.nextOccurrence;
    final daysUntilNext = nextDate.difference(DateTime.now()).inDays;

    return GlassCard(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
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
                    isExpense ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                    color: color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recurring.category,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        formatCurrency(recurring.amount),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert_rounded, color: AppColors.textSecondary),
                  onSelected: (value) {
                    if (value == 'edit') {
                      _navigateToForm(recurring: recurring);
                    } else if (value == 'delete') {
                      _deleteRecurring(recurring);
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit_rounded, size: 20),
                          SizedBox(width: AppSpacing.sm),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete_rounded, color: AppColors.error, size: 20),
                          SizedBox(width: AppSpacing.sm),
                          Text('Hapus', style: TextStyle(color: AppColors.error)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: AppSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoChip(
                  icon: Icons.repeat_rounded,
                  label: frequencyText,
                  context: context,
                ),
                _buildInfoChip(
                  icon: Icons.event_available_rounded,
                  label: 'Next: ${Formatters.date(nextDate)}',
                  context: context,
                ),
              ],
            ),
            if (daysUntilNext >= 0) ...[
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      child: LinearProgressIndicator(
                        value: 1 - (daysUntilNext / _getIntervalInDays(recurring.frequency)),
                        backgroundColor: color.withOpacity(0.2),
                        color: color,
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '$daysUntilNext hari lagi',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
  
  Widget _buildInfoChip({required IconData icon, required String label, required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  double _getIntervalInDays(String frequency) {
    switch (frequency) {
      case 'daily':
        return 1;
      case 'weekly':
        return 7;
      case 'monthly':
        return 30;
      case 'yearly':
        return 365;
      default:
        return 30;
    }
  }

  String _getFrequencyText(String frequency) {
    switch (frequency) {
      case 'daily':
        return 'Harian';
      case 'weekly':
        return 'Mingguan';
      case 'monthly':
        return 'Bulanan';
      case 'yearly':
        return 'Tahunan';
      default:
        return frequency;
    }
  }
  
  Future<void> _navigateToForm({RecurringTransaction? recurring}) async {
    final result = await Navigator.push<RecurringTransaction>(
      context,
      MaterialPageRoute(
        builder: (context) => RecurringTransactionFormScreen(recurring: recurring),
      ),
    );
    
    if (result != null && mounted) {
      if (recurring == null) {
        context.read<RecurringBloc>().add(RecurringEvent.addRecurring(result));
        showSuccessSnackbar(context, 'Transaksi berulang berhasil ditambahkan');
      } else {
        context.read<RecurringBloc>().add(RecurringEvent.updateRecurring(result));
        showSuccessSnackbar(context, 'Transaksi berulang berhasil diperbarui');
      }
    }
  }
  
  Future<void> _deleteRecurring(RecurringTransaction recurring) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Hapus Transaksi Berulang',
      message: 'Yakin ingin menghapus transaksi berulang ini?',
    );
    
    if (confirmed == true && mounted) {
      context.read<RecurringBloc>().add(RecurringEvent.deleteRecurring(recurring.id));
      showSuccessSnackbar(context, 'Transaksi berulang berhasil dihapus');
    }
  }
}
