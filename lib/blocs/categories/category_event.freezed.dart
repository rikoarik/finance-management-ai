// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$CategoryEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCategories,
    required TResult Function(Category category) addCategory,
    required TResult Function(Category category) updateCategory,
    required TResult Function(String id) deleteCategory,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCategories,
    TResult? Function(Category category)? addCategory,
    TResult? Function(Category category)? updateCategory,
    TResult? Function(String id)? deleteCategory,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCategories,
    TResult Function(Category category)? addCategory,
    TResult Function(Category category)? updateCategory,
    TResult Function(String id)? deleteCategory,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCategories value) loadCategories,
    required TResult Function(AddCategory value) addCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCategories value)? loadCategories,
    TResult? Function(AddCategory value)? addCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCategories value)? loadCategories,
    TResult Function(AddCategory value)? addCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryEventCopyWith<$Res> {
  factory $CategoryEventCopyWith(
    CategoryEvent value,
    $Res Function(CategoryEvent) then,
  ) = _$CategoryEventCopyWithImpl<$Res, CategoryEvent>;
}

/// @nodoc
class _$CategoryEventCopyWithImpl<$Res, $Val extends CategoryEvent>
    implements $CategoryEventCopyWith<$Res> {
  _$CategoryEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadCategoriesImplCopyWith<$Res> {
  factory _$$LoadCategoriesImplCopyWith(
    _$LoadCategoriesImpl value,
    $Res Function(_$LoadCategoriesImpl) then,
  ) = __$$LoadCategoriesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadCategoriesImplCopyWithImpl<$Res>
    extends _$CategoryEventCopyWithImpl<$Res, _$LoadCategoriesImpl>
    implements _$$LoadCategoriesImplCopyWith<$Res> {
  __$$LoadCategoriesImplCopyWithImpl(
    _$LoadCategoriesImpl _value,
    $Res Function(_$LoadCategoriesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadCategoriesImpl implements LoadCategories {
  const _$LoadCategoriesImpl();

  @override
  String toString() {
    return 'CategoryEvent.loadCategories()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadCategoriesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCategories,
    required TResult Function(Category category) addCategory,
    required TResult Function(Category category) updateCategory,
    required TResult Function(String id) deleteCategory,
  }) {
    return loadCategories();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCategories,
    TResult? Function(Category category)? addCategory,
    TResult? Function(Category category)? updateCategory,
    TResult? Function(String id)? deleteCategory,
  }) {
    return loadCategories?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCategories,
    TResult Function(Category category)? addCategory,
    TResult Function(Category category)? updateCategory,
    TResult Function(String id)? deleteCategory,
    required TResult orElse(),
  }) {
    if (loadCategories != null) {
      return loadCategories();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCategories value) loadCategories,
    required TResult Function(AddCategory value) addCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
  }) {
    return loadCategories(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCategories value)? loadCategories,
    TResult? Function(AddCategory value)? addCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
  }) {
    return loadCategories?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCategories value)? loadCategories,
    TResult Function(AddCategory value)? addCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    required TResult orElse(),
  }) {
    if (loadCategories != null) {
      return loadCategories(this);
    }
    return orElse();
  }
}

abstract class LoadCategories implements CategoryEvent {
  const factory LoadCategories() = _$LoadCategoriesImpl;
}

/// @nodoc
abstract class _$$AddCategoryImplCopyWith<$Res> {
  factory _$$AddCategoryImplCopyWith(
    _$AddCategoryImpl value,
    $Res Function(_$AddCategoryImpl) then,
  ) = __$$AddCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Category category});
}

/// @nodoc
class __$$AddCategoryImplCopyWithImpl<$Res>
    extends _$CategoryEventCopyWithImpl<$Res, _$AddCategoryImpl>
    implements _$$AddCategoryImplCopyWith<$Res> {
  __$$AddCategoryImplCopyWithImpl(
    _$AddCategoryImpl _value,
    $Res Function(_$AddCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = null}) {
    return _then(
      _$AddCategoryImpl(
        null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as Category,
      ),
    );
  }
}

/// @nodoc

class _$AddCategoryImpl implements AddCategory {
  const _$AddCategoryImpl(this.category);

  @override
  final Category category;

  @override
  String toString() {
    return 'CategoryEvent.addCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddCategoryImplCopyWith<_$AddCategoryImpl> get copyWith =>
      __$$AddCategoryImplCopyWithImpl<_$AddCategoryImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCategories,
    required TResult Function(Category category) addCategory,
    required TResult Function(Category category) updateCategory,
    required TResult Function(String id) deleteCategory,
  }) {
    return addCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCategories,
    TResult? Function(Category category)? addCategory,
    TResult? Function(Category category)? updateCategory,
    TResult? Function(String id)? deleteCategory,
  }) {
    return addCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCategories,
    TResult Function(Category category)? addCategory,
    TResult Function(Category category)? updateCategory,
    TResult Function(String id)? deleteCategory,
    required TResult orElse(),
  }) {
    if (addCategory != null) {
      return addCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCategories value) loadCategories,
    required TResult Function(AddCategory value) addCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
  }) {
    return addCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCategories value)? loadCategories,
    TResult? Function(AddCategory value)? addCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
  }) {
    return addCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCategories value)? loadCategories,
    TResult Function(AddCategory value)? addCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    required TResult orElse(),
  }) {
    if (addCategory != null) {
      return addCategory(this);
    }
    return orElse();
  }
}

abstract class AddCategory implements CategoryEvent {
  const factory AddCategory(final Category category) = _$AddCategoryImpl;

  Category get category;

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddCategoryImplCopyWith<_$AddCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCategoryImplCopyWith<$Res> {
  factory _$$UpdateCategoryImplCopyWith(
    _$UpdateCategoryImpl value,
    $Res Function(_$UpdateCategoryImpl) then,
  ) = __$$UpdateCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Category category});
}

/// @nodoc
class __$$UpdateCategoryImplCopyWithImpl<$Res>
    extends _$CategoryEventCopyWithImpl<$Res, _$UpdateCategoryImpl>
    implements _$$UpdateCategoryImplCopyWith<$Res> {
  __$$UpdateCategoryImplCopyWithImpl(
    _$UpdateCategoryImpl _value,
    $Res Function(_$UpdateCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = null}) {
    return _then(
      _$UpdateCategoryImpl(
        null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as Category,
      ),
    );
  }
}

/// @nodoc

class _$UpdateCategoryImpl implements UpdateCategory {
  const _$UpdateCategoryImpl(this.category);

  @override
  final Category category;

  @override
  String toString() {
    return 'CategoryEvent.updateCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCategoryImplCopyWith<_$UpdateCategoryImpl> get copyWith =>
      __$$UpdateCategoryImplCopyWithImpl<_$UpdateCategoryImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCategories,
    required TResult Function(Category category) addCategory,
    required TResult Function(Category category) updateCategory,
    required TResult Function(String id) deleteCategory,
  }) {
    return updateCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCategories,
    TResult? Function(Category category)? addCategory,
    TResult? Function(Category category)? updateCategory,
    TResult? Function(String id)? deleteCategory,
  }) {
    return updateCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCategories,
    TResult Function(Category category)? addCategory,
    TResult Function(Category category)? updateCategory,
    TResult Function(String id)? deleteCategory,
    required TResult orElse(),
  }) {
    if (updateCategory != null) {
      return updateCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCategories value) loadCategories,
    required TResult Function(AddCategory value) addCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
  }) {
    return updateCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCategories value)? loadCategories,
    TResult? Function(AddCategory value)? addCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
  }) {
    return updateCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCategories value)? loadCategories,
    TResult Function(AddCategory value)? addCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    required TResult orElse(),
  }) {
    if (updateCategory != null) {
      return updateCategory(this);
    }
    return orElse();
  }
}

abstract class UpdateCategory implements CategoryEvent {
  const factory UpdateCategory(final Category category) = _$UpdateCategoryImpl;

  Category get category;

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCategoryImplCopyWith<_$UpdateCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCategoryImplCopyWith<$Res> {
  factory _$$DeleteCategoryImplCopyWith(
    _$DeleteCategoryImpl value,
    $Res Function(_$DeleteCategoryImpl) then,
  ) = __$$DeleteCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteCategoryImplCopyWithImpl<$Res>
    extends _$CategoryEventCopyWithImpl<$Res, _$DeleteCategoryImpl>
    implements _$$DeleteCategoryImplCopyWith<$Res> {
  __$$DeleteCategoryImplCopyWithImpl(
    _$DeleteCategoryImpl _value,
    $Res Function(_$DeleteCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$DeleteCategoryImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteCategoryImpl implements DeleteCategory {
  const _$DeleteCategoryImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'CategoryEvent.deleteCategory(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCategoryImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCategoryImplCopyWith<_$DeleteCategoryImpl> get copyWith =>
      __$$DeleteCategoryImplCopyWithImpl<_$DeleteCategoryImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadCategories,
    required TResult Function(Category category) addCategory,
    required TResult Function(Category category) updateCategory,
    required TResult Function(String id) deleteCategory,
  }) {
    return deleteCategory(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadCategories,
    TResult? Function(Category category)? addCategory,
    TResult? Function(Category category)? updateCategory,
    TResult? Function(String id)? deleteCategory,
  }) {
    return deleteCategory?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadCategories,
    TResult Function(Category category)? addCategory,
    TResult Function(Category category)? updateCategory,
    TResult Function(String id)? deleteCategory,
    required TResult orElse(),
  }) {
    if (deleteCategory != null) {
      return deleteCategory(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadCategories value) loadCategories,
    required TResult Function(AddCategory value) addCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
  }) {
    return deleteCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadCategories value)? loadCategories,
    TResult? Function(AddCategory value)? addCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
  }) {
    return deleteCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadCategories value)? loadCategories,
    TResult Function(AddCategory value)? addCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    required TResult orElse(),
  }) {
    if (deleteCategory != null) {
      return deleteCategory(this);
    }
    return orElse();
  }
}

abstract class DeleteCategory implements CategoryEvent {
  const factory DeleteCategory(final String id) = _$DeleteCategoryImpl;

  String get id;

  /// Create a copy of CategoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteCategoryImplCopyWith<_$DeleteCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
