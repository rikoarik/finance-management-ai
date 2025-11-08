import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/formatters.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final DateTime timestamp;
  
  const ChatBubble({
    super.key,
    required this.message,
    required this.isUser,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            _buildAvatar(context, false),
            const SizedBox(width: AppSpacing.sm),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm + 2,
                  ),
                  decoration: BoxDecoration(
                    color: isUser
                        ? AppColors.primary
                        : Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isUser ? AppRadius.md : AppRadius.sm),
                      topRight: Radius.circular(isUser ? AppRadius.sm : AppRadius.md),
                      bottomLeft: const Radius.circular(AppRadius.md),
                      bottomRight: const Radius.circular(AppRadius.md),
                    ),
                  ),
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isUser
                          ? Colors.white
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  Formatters.time(timestamp),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: AppSpacing.sm),
            _buildAvatar(context, true),
          ],
        ],
      ),
    );
  }
  
  Widget _buildAvatar(BuildContext context, bool isUser) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: isUser
          ? AppColors.primary
          : Theme.of(context).colorScheme.secondaryContainer,
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy,
        size: 18,
        color: isUser
            ? Colors.white
            : Theme.of(context).colorScheme.onSecondaryContainer,
      ),
    );
  }
}

class TransactionConfirmationBubble extends StatelessWidget {
  final Map<String, dynamic> transaction;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  
  const TransactionConfirmationBubble({
    super.key,
    required this.transaction,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final action = transaction['action'] as String;
    
    // Handle budget suggestion
    if (action == 'suggest_budget') {
      return _buildBudgetSuggestion(context);
    }
    
    // Handle regular transaction
    final amount = transaction['amount'] as double;
    final category = transaction['category'] as String;
    final note = transaction['note'] as String? ?? '';
    final type = action == 'record_income' ? 'Pemasukan' : 'Pengeluaran';
    final color = action == 'record_income'
        ? AppColors.income
        : AppColors.expense;
    
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    transaction['action'] == 'record_income'
                        ? Icons.trending_up
                        : Icons.trending_down,
                    color: color,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Konfirmasi Transaksi',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Divider(),
              _buildInfoRow(context, 'Tipe', type),
              _buildInfoRow(context, 'Jumlah', Formatters.currency(amount)),
              _buildInfoRow(context, 'Kategori', category),
              if (note.isNotEmpty) _buildInfoRow(context, 'Catatan', note),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      child: const Text('Batal'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      child: const Text('Simpan'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ),
          const Text(': '),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildBudgetSuggestion(BuildContext context) {
    final amount = (transaction['amount'] as num).toDouble();
    final categories = transaction['categories'] as Map<String, dynamic>? ?? {};
    
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppSpacing.sm,
        horizontal: AppSpacing.md,
      ),
      child: Card(
        color: AppColors.info.withOpacity(0.1),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: AppColors.info),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Saran Budget',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.info,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Budget:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Rp ${amount.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: AppSpacing.sm),
                    ...categories.entries.map((entry) {
                      final catAmount = (entry.value as num).toDouble();
                      final percentage = (catAmount / amount * 100).toStringAsFixed(0);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(entry.key),
                            ),
                            Expanded(
                              child: Text(
                                '$percentage%',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                'Rp ${catAmount.toStringAsFixed(0)}',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCancel,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey,
                        side: const BorderSide(color: Colors.grey),
                      ),
                      child: const Text('Tidak'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.info,
                      ),
                      child: const Text('Terapkan Budget'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

