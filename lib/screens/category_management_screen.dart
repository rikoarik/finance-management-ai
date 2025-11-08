import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/categories/category_bloc.dart';
import '../blocs/categories/category_event.dart';
import '../blocs/categories/category_state.dart';
import '../models/category.dart';
import '../utils/constants.dart';
import '../utils/helpers.dart';
import '../widgets/empty_state.dart';
import 'category_form_dialog.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() => _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Category>? _fallbackCategories;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadFallbackCategories();
    
    // Load categories if needed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final categoryBloc = context.read<CategoryBloc>();
      final categoryState = categoryBloc.state;
      final shouldLoad = categoryState.maybeWhen(
        loaded: (_) => false,
        loading: () => false,
        orElse: () => true,
      );
      if (shouldLoad) {
        categoryBloc.add(const CategoryEvent.loadCategories());
      }
    });
  }
  
  void _loadFallbackCategories() {
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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Kategori'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Pengeluaran'),
            Tab(text: 'Pemasukan'),
          ],
        ),
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (message) {
              showErrorSnackbar(context, message);
            },
          );
        },
        builder: (context, state) {
          // Use fallback categories if not loaded yet
          List<Category> categoriesToUse = [];
          state.maybeWhen(
            loaded: (categories) {
              categoriesToUse = categories;
            },
            orElse: () {
              if (_fallbackCategories != null) {
                categoriesToUse = _fallbackCategories!;
              }
            },
          );
          
          final expenseCategories = categoriesToUse
              .where((cat) => cat.type == 'expense')
              .toList();
          final incomeCategories = categoriesToUse
              .where((cat) => cat.type == 'income')
              .toList();
          
          return TabBarView(
            controller: _tabController,
            children: [
              _buildCategoryList(expenseCategories, 'expense'),
              _buildCategoryList(incomeCategories, 'income'),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget _buildCategoryList(List<Category> categories, String type) {
    if (categories.isEmpty) {
      return EmptyState(
        icon: Icons.category,
        title: 'Tidak Ada Kategori',
        message: 'Belum ada kategori ${type == 'expense' ? 'pengeluaran' : 'pemasukan'}',
        actionText: 'Tambah Kategori',
        onActionPressed: () => _showCategoryDialog(type: type),
      );
    }
    
    return RefreshIndicator(
      onRefresh: () async {
        context.read<CategoryBloc>().add(const CategoryEvent.loadCategories());
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  category.icon,
                  color: category.color,
                ),
              ),
              title: Text(category.name),
              subtitle: Text(
                category.isDefault ? 'Kategori default' : 'Kategori custom',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
              trailing: category.isDefault
                  ? null
                  : PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit),
                              SizedBox(width: AppSpacing.sm),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: AppSpacing.sm),
                              Text('Hapus', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'edit') {
                          _showCategoryDialog(category: category);
                        } else if (value == 'delete') {
                          _deleteCategory(category);
                        }
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
  
  Future<void> _showCategoryDialog({Category? category, String? type}) async {
    final result = await showDialog<Category>(
      context: context,
      builder: (context) => CategoryFormDialog(
        category: category,
        type: type ?? (category?.type ?? 'expense'),
      ),
    );
    
    if (result != null && mounted) {
      if (category == null) {
        // Add new category
        context.read<CategoryBloc>().add(CategoryEvent.addCategory(result));
        showSuccessSnackbar(context, 'Kategori berhasil ditambahkan');
      } else {
        // Update existing category
        context.read<CategoryBloc>().add(CategoryEvent.updateCategory(result));
        showSuccessSnackbar(context, 'Kategori berhasil diperbarui');
      }
    }
  }
  
  Future<void> _deleteCategory(Category category) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Hapus Kategori',
      message: 'Yakin ingin menghapus kategori "${category.name}"?',
    );
    
    if (confirmed == true && mounted) {
      context.read<CategoryBloc>().add(CategoryEvent.deleteCategory(category.id));
      showSuccessSnackbar(context, 'Kategori berhasil dihapus');
    }
  }
}
