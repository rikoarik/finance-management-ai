import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/category.dart';
import '../utils/constants.dart';
import '../widgets/icon_picker.dart';
import '../widgets/color_picker.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class CategoryFormDialog extends StatefulWidget {
  final Category? category;
  final String type;

  const CategoryFormDialog({
    super.key,
    this.category,
    required this.type,
  });

  @override
  State<CategoryFormDialog> createState() => _CategoryFormDialogState();
}

class _CategoryFormDialogState extends State<CategoryFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  
  late IconData _selectedIcon;
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    
    if (widget.category != null) {
      _nameController.text = widget.category!.name;
      _selectedIcon = widget.category!.icon;
      _selectedColor = widget.category!.color;
    } else {
      _selectedIcon = Icons.category;
      _selectedColor = AppColors.categoryColors.first;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showIconPicker() {
    showDialog(
      context: context,
      builder: (context) => IconPicker(
        selectedIcon: _selectedIcon,
        onIconSelected: (icon) {
          setState(() => _selectedIcon = icon);
        },
      ),
    );
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) => ColorPicker(
        selectedColor: _selectedColor,
        onColorSelected: (color) {
          setState(() => _selectedColor = color);
        },
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final category = Category(
        id: widget.category?.id ?? const Uuid().v4(),
        name: _nameController.text.trim(),
        type: widget.type,
        icon: _selectedIcon,
        color: _selectedColor,
        isDefault: false,
      );
      
      Navigator.pop(context, category);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.category != null;
    
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isEditing ? 'Edit Kategori' : 'Tambah Kategori',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Name Field
              CustomTextField(
                controller: _nameController,
                label: 'Nama Kategori',
                hint: 'Contoh: Transportasi',
                prefixIcon: Icons.label,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama kategori harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              
              // Icon & Color Selector
              Row(
                children: [
                  // Icon Selector
                  Expanded(
                    child: InkWell(
                      onTap: _showIconPicker,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              _selectedIcon,
                              size: 32,
                              color: _selectedColor,
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Pilih Icon',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  
                  // Color Selector
                  Expanded(
                    child: InkWell(
                      onTap: _showColorPicker,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).dividerColor,
                          ),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: _selectedColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Pilih Warna',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              
              // Preview
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: _selectedColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: _selectedColor.withOpacity(0.2),
                      child: Icon(
                        _selectedIcon,
                        color: _selectedColor,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Preview',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            _nameController.text.isEmpty
                                ? 'Nama Kategori'
                                : _nameController.text,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              
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
      ),
    );
  }
}

