import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/category.dart';
import '../../services/category_service.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryService _categoryService;
  final FirebaseAuth _firebaseAuth;
  StreamSubscription<List<Category>>? _categorySubscription;

  CategoryBloc({
    CategoryService? categoryService,
    FirebaseAuth? firebaseAuth,
  })  : _categoryService = categoryService ?? CategoryService(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const CategoryState.initial()) {
    on<LoadCategories>(_onLoadCategories);
    on<AddCategory>(_onAddCategory);
    on<UpdateCategory>(_onUpdateCategory);
    on<DeleteCategory>(_onDeleteCategory);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      emit(const CategoryState.error('User not authenticated'));
      return;
    }

    emit(const CategoryState.loading());

    try {
      await _categorySubscription?.cancel();

      _categorySubscription = _categoryService.getCategories(user.uid).listen(
        (categories) {
          emit(CategoryState.loaded(categories: categories));
        },
        onError: (error) {
          emit(CategoryState.error(error.toString()));
        },
        cancelOnError: false,
      );
    } catch (e) {
      emit(CategoryState.error(e.toString()));
    }
  }

  Future<void> _onAddCategory(
    AddCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await _categoryService.addCategory(event.category);
    } catch (e) {
      emit(CategoryState.error(e.toString()));
    }
  }

  Future<void> _onUpdateCategory(
    UpdateCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await _categoryService.updateCategory(event.category);
    } catch (e) {
      emit(CategoryState.error(e.toString()));
    }
  }

  Future<void> _onDeleteCategory(
    DeleteCategory event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      await _categoryService.deleteCategory(event.id);
    } catch (e) {
      emit(CategoryState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _categorySubscription?.cancel();
    return super.close();
  }
}

