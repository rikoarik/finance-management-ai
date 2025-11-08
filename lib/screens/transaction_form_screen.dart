import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../blocs/transactions/transaction_bloc.dart';
import '../blocs/transactions/transaction_event.dart';
import '../blocs/categories/category_bloc.dart';
import '../blocs/categories/category_event.dart';
import '../blocs/categories/category_state.dart';
import '../models/transaction.dart' as app_transaction;
import '../models/category.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../utils/formatters.dart';
import '../widgets/custom_button.dart';

class TransactionFormScreen extends StatefulWidget {
  final app_transaction.Transaction? transaction;
  
  const TransactionFormScreen({super.key, this.transaction});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  
  String _type = 'expense';
  String _category = 'Food';
  DateTime _date = DateTime.now();
  bool _isLoading = false;
  List<Category>? _fallbackCategories;
  
  @override
  void initState() {
    super.initState();
    if (widget.transaction != null) {
      _loadTransaction();
    }
    
    // Create fallback categories from defaults immediately
    _loadFallbackCategories();
    
    // Always ensure categories are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      
      final categoryBloc = context.read<CategoryBloc>();
      final categoryState = categoryBloc.state;
      final shouldLoad = categoryState.maybeWhen(
        loaded: (_) => false, // Already loaded, don't reload
        loading: () => false, // Currently loading, don't reload
        orElse: () => true, // Initial or error state, should load
      );
      if (shouldLoad) {
        categoryBloc.add(const LoadCategories());
      }
    });
  }
  
  void _loadFallbackCategories() {
    // Load default categories directly as fallback
    final expenseCats = PredefinedCategories.expenseCategoriesWithData;
    final incomeCats = PredefinedCategories.incomeCategoriesWithData;
    
    _fallbackCategories = [
      ...expenseCats.map((cat) => Category(
        id: 'default_${cat['name']}',
        name: cat['name'] as String,
        type: 'expense',
        icon: _getIconFromString(cat['icon'] as String),
        color: Color(cat['color'] as int),
        isDefault: true,
      )),
      ...incomeCats.map((cat) => Category(
        id: 'default_income_${cat['name']}',
        name: cat['name'] as String,
        type: 'income',
        icon: _getIconFromString(cat['icon'] as String),
        color: Color(cat['color'] as int),
        isDefault: true,
      )),
    ];
  }
  
  IconData _getIconFromString(String iconName) {
    final icons = {
      'restaurant': Icons.restaurant,
      'directions_car': Icons.directions_car,
      'shopping_bag': Icons.shopping_bag,
      'movie': Icons.movie,
      'local_hospital': Icons.local_hospital,
      'school': Icons.school,
      'receipt': Icons.receipt,
      'account_balance_wallet': Icons.account_balance_wallet,
      'trending_up': Icons.trending_up,
      'card_giftcard': Icons.card_giftcard,
      'more_horiz': Icons.more_horiz,
    };
    return icons[iconName] ?? Icons.more_horiz;
  }
  
  void _loadTransaction() {
    final t = widget.transaction!;
    _amountController.text = t.amount.toString();
    _noteController.text = t.note ?? '';
    _type = t.type;
    _category = t.category;
    _date = t.date;
  }
  
  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
  
  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }
  
  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    setState(() => _isLoading = true);
    
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        if (mounted) {
          showErrorSnackbar(context, 'Pengguna tidak ditemukan');
        }
        return;
      }
      
      final amount = double.parse(_amountController.text);
      
      if (widget.transaction != null) {
        // Update existing transaction
        final updated = app_transaction.Transaction(
          id: widget.transaction!.id,
          userId: user.uid,
          type: _type,
          amount: amount,
          category: _category,
          date: _date,
          note: _noteController.text.isEmpty ? null : _noteController.text,
        );
        
        context.read<TransactionBloc>().add(
          TransactionEvent.updateTransaction(updated),
        );
        
        if (mounted) {
          showSuccessSnackbar(context, 'Transaksi berhasil diperbarui');
          Navigator.pop(context, true);
        }
      } else {
        // Add new transaction
        final newTransaction = app_transaction.Transaction(
          id: const Uuid().v4(),
          userId: user.uid,
          type: _type,
          amount: amount,
          category: _category,
          date: _date,
          note: _noteController.text.isEmpty ? null : _noteController.text,
        );
        
        context.read<TransactionBloc>().add(
          TransactionEvent.addTransaction(newTransaction),
        );
        
        if (mounted) {
          showSuccessSnackbar(context, 'Transaksi berhasil ditambahkan');
          Navigator.pop(context, true);
        }
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackbar(context, 'Gagal menyimpan transaksi: $e');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.transaction != null ? 'Edit Transaksi' : 'Tambah Transaksi'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Type selector
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tipe Transaksi',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(
                            value: 'expense',
                            label: Text('Pengeluaran'),
                            icon: Icon(Icons.arrow_downward),
                          ),
                          ButtonSegment(
                            value: 'income',
                            label: Text('Pemasukan'),
                            icon: Icon(Icons.arrow_upward),
                          ),
                        ],
                        selected: {_type},
                        onSelectionChanged: (Set<String> selected) {
                          final newType = selected.first;
                          setState(() {
                            _type = newType;
                            // Reset category when type changes - will be validated when categories load
                            _category = newType == 'income' ? 'Salary' : 'Food';
                          });
                          
                          // Ensure category is valid for the new type
                          final categoryBloc = context.read<CategoryBloc>();
                          categoryBloc.state.maybeWhen(
                            loaded: (categories) {
                              final filteredCategories = categories
                                  .where((c) => c.type == newType)
                                  .toList();
                              
                              if (filteredCategories.isNotEmpty) {
                                if (!filteredCategories.any((c) => c.name == _category)) {
                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                    if (mounted) {
                                      setState(() {
                                        _category = filteredCategories.first.name;
                                      });
                                    }
                                  });
                                }
                              }
                            },
                            orElse: () {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Amount
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Jumlah',
                  hintText: 'Masukkan jumlah',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jumlah tidak boleh kosong';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Jumlah harus berupa angka';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Jumlah harus lebih dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Category
              BlocConsumer<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  // When categories are loaded, ensure selected category is valid
                  state.maybeWhen(
                    loaded: (categories) {
                      final filteredCategories = categories
                          .where((c) => c.type == _type)
                          .toList();
                      
                      if (filteredCategories.isNotEmpty) {
                        if (!filteredCategories.any((c) => c.name == _category)) {
                          // Category tidak valid, update ke yang valid
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted) {
                              setState(() {
                                _category = filteredCategories.first.name;
                              });
                            }
                          });
                        }
                      }
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  // Always use fallback categories first, then update when loaded
                  List<Category> categoriesToUse = _fallbackCategories ?? [];
                  
                  state.maybeWhen(
                    loaded: (categories) {
                      categoriesToUse = categories;
                    },
                    orElse: () {
                      // Keep using fallback categories
                    },
                  );
                  
                  final filteredCategories = categoriesToUse
                      .where((c) => c.type == _type)
                      .toList();
                  
                  if (filteredCategories.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 20,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            'Tidak ada kategori tersedia',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  // Ensure selected category is valid
                  String validCategory = _category;
                  if (!filteredCategories.any((c) => c.name == _category)) {
                    validCategory = filteredCategories.first.name;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) {
                        setState(() {
                          _category = validCategory;
                        });
                      }
                    });
                  }
                  
                  // Always show dropdown - no loading indicator
                  return DropdownButtonFormField<String>(
                    value: validCategory,
                    decoration: const InputDecoration(
                      labelText: 'Kategori',
                      prefixIcon: Icon(Icons.category),
                    ),
                    items: filteredCategories.map((category) {
                      return DropdownMenuItem(
                        value: category.name,
                        child: Row(
                          children: [
                            Icon(
                              category.icon,
                              size: 20,
                              color: category.color,
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Text(category.name),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _category = value);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Date
              InkWell(
                onTap: _selectDate,
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Tanggal',
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  child: Text(formatDate(_date)),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Note
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(
                  labelText: 'Catatan (Opsional)',
                  hintText: 'Tambahkan catatan...',
                  prefixIcon: Icon(Icons.note),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: AppSpacing.xl),
              
              // Save button
              CustomButton(
                text: widget.transaction != null ? 'Perbarui' : 'Simpan',
                onPressed: _isLoading ? null : _save,
                isLoading: _isLoading,
              ),
              
              // Delete button (only for edit mode)
              if (widget.transaction != null) ...[
                const SizedBox(height: AppSpacing.md),
                OutlinedButton(
                  onPressed: _isLoading ? null : _deleteTransaction,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                  ),
                  child: const Text('Hapus Transaksi'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _deleteTransaction() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Hapus Transaksi',
      message: 'Yakin ingin menghapus transaksi ini?',
    );
    
    if (confirmed == true && widget.transaction != null && mounted) {
      context.read<TransactionBloc>().add(
        TransactionEvent.deleteTransaction(widget.transaction!.id),
      );
      Navigator.pop(context, true);
    }
  }
}
