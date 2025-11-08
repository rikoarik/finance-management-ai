import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/recurring_transaction.dart';
import '../utils/constants.dart';
import '../utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class RecurringTransactionFormScreen extends StatefulWidget {
  final RecurringTransaction? recurring;

  const RecurringTransactionFormScreen({
    super.key,
    this.recurring,
  });

  @override
  State<RecurringTransactionFormScreen> createState() =>
      _RecurringTransactionFormScreenState();
}

class _RecurringTransactionFormScreenState
    extends State<RecurringTransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _noteController = TextEditingController();

  String _type = 'expense';
  String _frequency = 'monthly';
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();

    if (widget.recurring != null) {
      _amountController.text = widget.recurring!.amount.toString();
      _categoryController.text = widget.recurring!.category;
      _noteController.text = widget.recurring!.note;
      _type = widget.recurring!.type;
      _frequency = widget.recurring!.frequency;
      _startDate = widget.recurring!.startDate;
      _endDate = widget.recurring!.endDate;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final recurring = RecurringTransaction(
        id: widget.recurring?.id ?? '',
        amount: double.parse(_amountController.text),
        type: _type,
        category: _categoryController.text.trim(),
        note: _noteController.text.trim(),
        frequency: _frequency,
        startDate: _startDate,
        endDate: _endDate,
        lastCreated: widget.recurring?.lastCreated ?? DateTime.now(),
      );

      Navigator.pop(context, recurring);
    }
  }

  Future<void> _selectStartDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (result != null) {
      setState(() => _startDate = result);
    }
  }

  Future<void> _selectEndDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate.add(const Duration(days: 365)),
      firstDate: _startDate,
      lastDate: DateTime(2030),
    );

    if (result != null) {
      setState(() => _endDate = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.recurring != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Transaksi Berulang' : 'Tambah Transaksi Berulang'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            // Type Selection
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tipe Transaksi',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Expanded(
                          child: ChoiceChip(
                            label: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.trending_down, size: 16),
                                SizedBox(width: 4),
                                Text('Pengeluaran'),
                              ],
                            ),
                            selected: _type == 'expense',
                            onSelected: (selected) {
                              if (selected) setState(() => _type = 'expense');
                            },
                            selectedColor: AppColors.error.withOpacity(0.2),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: ChoiceChip(
                            label: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.trending_up, size: 16),
                                SizedBox(width: 4),
                                Text('Pemasukan'),
                              ],
                            ),
                            selected: _type == 'income',
                            onSelected: (selected) {
                              if (selected) setState(() => _type = 'income');
                            },
                            selectedColor: AppColors.success.withOpacity(0.2),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Amount
            CustomTextField(
              controller: _amountController,
              label: 'Jumlah',
              hint: '50000',
              prefixIcon: Icons.attach_money,
              keyboardType: TextInputType.number,
              validator: Validators.amount,
            ),
            const SizedBox(height: AppSpacing.md),

            // Category
            CustomTextField(
              controller: _categoryController,
              label: 'Kategori',
              hint: 'Subscription, Gaji, dll',
              prefixIcon: Icons.category,
              validator: Validators.required,
            ),
            const SizedBox(height: AppSpacing.md),

            // Note
            CustomTextField(
              controller: _noteController,
              label: 'Catatan',
              hint: 'Netflix Premium',
              prefixIcon: Icons.note,
              maxLines: 2,
              validator: Validators.required,
            ),
            const SizedBox(height: AppSpacing.lg),

            // Frequency
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Frekuensi',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.sm,
                      children: [
                        ChoiceChip(
                          label: const Text('Harian'),
                          selected: _frequency == 'daily',
                          onSelected: (selected) {
                            if (selected) setState(() => _frequency = 'daily');
                          },
                        ),
                        ChoiceChip(
                          label: const Text('Mingguan'),
                          selected: _frequency == 'weekly',
                          onSelected: (selected) {
                            if (selected) setState(() => _frequency = 'weekly');
                          },
                        ),
                        ChoiceChip(
                          label: const Text('Bulanan'),
                          selected: _frequency == 'monthly',
                          onSelected: (selected) {
                            if (selected) setState(() => _frequency = 'monthly');
                          },
                        ),
                        ChoiceChip(
                          label: const Text('Tahunan'),
                          selected: _frequency == 'yearly',
                          onSelected: (selected) {
                            if (selected) setState(() => _frequency = 'yearly');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Date Range
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Periode',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    
                    // Start Date
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.play_arrow, color: AppColors.success),
                      title: const Text('Mulai'),
                      subtitle: Text(DateFormat('dd MMM yyyy').format(_startDate)),
                      trailing: const Icon(Icons.calendar_today, size: 20),
                      onTap: _selectStartDate,
                    ),
                    const Divider(),
                    
                    // End Date
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.stop, color: AppColors.error),
                      title: const Text('Berakhir (Opsional)'),
                      subtitle: Text(
                        _endDate != null
                            ? DateFormat('dd MMM yyyy').format(_endDate!)
                            : 'Tanpa batas',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_endDate != null)
                            IconButton(
                              icon: const Icon(Icons.clear, size: 20),
                              onPressed: () => setState(() => _endDate = null),
                            ),
                          const Icon(Icons.calendar_today, size: 20),
                        ],
                      ),
                      onTap: _selectEndDate,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: CustomButton(
                    text: isEditing ? 'Simpan' : 'Tambah',
                    onPressed: _submit,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

