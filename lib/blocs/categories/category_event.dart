import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/category.dart';

part 'category_event.freezed.dart';

@freezed
class CategoryEvent with _$CategoryEvent {
  const factory CategoryEvent.loadCategories() = LoadCategories;
  const factory CategoryEvent.addCategory(Category category) = AddCategory;
  const factory CategoryEvent.updateCategory(Category category) = UpdateCategory;
  const factory CategoryEvent.deleteCategory(String id) = DeleteCategory;
}

