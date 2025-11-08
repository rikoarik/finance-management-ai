// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RecurringState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RecurringTransaction> recurringTransactions)
    loaded,
    required TResult Function() processing,
    required TResult Function(int count) processed,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult? Function()? processing,
    TResult? Function(int count)? processed,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult Function()? processing,
    TResult Function(int count)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RecurringInitial value) initial,
    required TResult Function(RecurringLoading value) loading,
    required TResult Function(RecurringLoaded value) loaded,
    required TResult Function(RecurringProcessing value) processing,
    required TResult Function(RecurringProcessed value) processed,
    required TResult Function(RecurringError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RecurringInitial value)? initial,
    TResult? Function(RecurringLoading value)? loading,
    TResult? Function(RecurringLoaded value)? loaded,
    TResult? Function(RecurringProcessing value)? processing,
    TResult? Function(RecurringProcessed value)? processed,
    TResult? Function(RecurringError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RecurringInitial value)? initial,
    TResult Function(RecurringLoading value)? loading,
    TResult Function(RecurringLoaded value)? loaded,
    TResult Function(RecurringProcessing value)? processing,
    TResult Function(RecurringProcessed value)? processed,
    TResult Function(RecurringError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecurringStateCopyWith<$Res> {
  factory $RecurringStateCopyWith(
    RecurringState value,
    $Res Function(RecurringState) then,
  ) = _$RecurringStateCopyWithImpl<$Res, RecurringState>;
}

/// @nodoc
class _$RecurringStateCopyWithImpl<$Res, $Val extends RecurringState>
    implements $RecurringStateCopyWith<$Res> {
  _$RecurringStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RecurringInitialImplCopyWith<$Res> {
  factory _$$RecurringInitialImplCopyWith(
    _$RecurringInitialImpl value,
    $Res Function(_$RecurringInitialImpl) then,
  ) = __$$RecurringInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RecurringInitialImplCopyWithImpl<$Res>
    extends _$RecurringStateCopyWithImpl<$Res, _$RecurringInitialImpl>
    implements _$$RecurringInitialImplCopyWith<$Res> {
  __$$RecurringInitialImplCopyWithImpl(
    _$RecurringInitialImpl _value,
    $Res Function(_$RecurringInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RecurringInitialImpl implements RecurringInitial {
  const _$RecurringInitialImpl();

  @override
  String toString() {
    return 'RecurringState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RecurringInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RecurringTransaction> recurringTransactions)
    loaded,
    required TResult Function() processing,
    required TResult Function(int count) processed,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult? Function()? processing,
    TResult? Function(int count)? processed,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult Function()? processing,
    TResult Function(int count)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RecurringInitial value) initial,
    required TResult Function(RecurringLoading value) loading,
    required TResult Function(RecurringLoaded value) loaded,
    required TResult Function(RecurringProcessing value) processing,
    required TResult Function(RecurringProcessed value) processed,
    required TResult Function(RecurringError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RecurringInitial value)? initial,
    TResult? Function(RecurringLoading value)? loading,
    TResult? Function(RecurringLoaded value)? loaded,
    TResult? Function(RecurringProcessing value)? processing,
    TResult? Function(RecurringProcessed value)? processed,
    TResult? Function(RecurringError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RecurringInitial value)? initial,
    TResult Function(RecurringLoading value)? loading,
    TResult Function(RecurringLoaded value)? loaded,
    TResult Function(RecurringProcessing value)? processing,
    TResult Function(RecurringProcessed value)? processed,
    TResult Function(RecurringError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class RecurringInitial implements RecurringState {
  const factory RecurringInitial() = _$RecurringInitialImpl;
}

/// @nodoc
abstract class _$$RecurringLoadingImplCopyWith<$Res> {
  factory _$$RecurringLoadingImplCopyWith(
    _$RecurringLoadingImpl value,
    $Res Function(_$RecurringLoadingImpl) then,
  ) = __$$RecurringLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RecurringLoadingImplCopyWithImpl<$Res>
    extends _$RecurringStateCopyWithImpl<$Res, _$RecurringLoadingImpl>
    implements _$$RecurringLoadingImplCopyWith<$Res> {
  __$$RecurringLoadingImplCopyWithImpl(
    _$RecurringLoadingImpl _value,
    $Res Function(_$RecurringLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RecurringLoadingImpl implements RecurringLoading {
  const _$RecurringLoadingImpl();

  @override
  String toString() {
    return 'RecurringState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RecurringLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RecurringTransaction> recurringTransactions)
    loaded,
    required TResult Function() processing,
    required TResult Function(int count) processed,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult? Function()? processing,
    TResult? Function(int count)? processed,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult Function()? processing,
    TResult Function(int count)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RecurringInitial value) initial,
    required TResult Function(RecurringLoading value) loading,
    required TResult Function(RecurringLoaded value) loaded,
    required TResult Function(RecurringProcessing value) processing,
    required TResult Function(RecurringProcessed value) processed,
    required TResult Function(RecurringError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RecurringInitial value)? initial,
    TResult? Function(RecurringLoading value)? loading,
    TResult? Function(RecurringLoaded value)? loaded,
    TResult? Function(RecurringProcessing value)? processing,
    TResult? Function(RecurringProcessed value)? processed,
    TResult? Function(RecurringError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RecurringInitial value)? initial,
    TResult Function(RecurringLoading value)? loading,
    TResult Function(RecurringLoaded value)? loaded,
    TResult Function(RecurringProcessing value)? processing,
    TResult Function(RecurringProcessed value)? processed,
    TResult Function(RecurringError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RecurringLoading implements RecurringState {
  const factory RecurringLoading() = _$RecurringLoadingImpl;
}

/// @nodoc
abstract class _$$RecurringLoadedImplCopyWith<$Res> {
  factory _$$RecurringLoadedImplCopyWith(
    _$RecurringLoadedImpl value,
    $Res Function(_$RecurringLoadedImpl) then,
  ) = __$$RecurringLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<RecurringTransaction> recurringTransactions});
}

/// @nodoc
class __$$RecurringLoadedImplCopyWithImpl<$Res>
    extends _$RecurringStateCopyWithImpl<$Res, _$RecurringLoadedImpl>
    implements _$$RecurringLoadedImplCopyWith<$Res> {
  __$$RecurringLoadedImplCopyWithImpl(
    _$RecurringLoadedImpl _value,
    $Res Function(_$RecurringLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? recurringTransactions = null}) {
    return _then(
      _$RecurringLoadedImpl(
        recurringTransactions: null == recurringTransactions
            ? _value._recurringTransactions
            : recurringTransactions // ignore: cast_nullable_to_non_nullable
                  as List<RecurringTransaction>,
      ),
    );
  }
}

/// @nodoc

class _$RecurringLoadedImpl implements RecurringLoaded {
  const _$RecurringLoadedImpl({
    required final List<RecurringTransaction> recurringTransactions,
  }) : _recurringTransactions = recurringTransactions;

  final List<RecurringTransaction> _recurringTransactions;
  @override
  List<RecurringTransaction> get recurringTransactions {
    if (_recurringTransactions is EqualUnmodifiableListView)
      return _recurringTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recurringTransactions);
  }

  @override
  String toString() {
    return 'RecurringState.loaded(recurringTransactions: $recurringTransactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringLoadedImpl &&
            const DeepCollectionEquality().equals(
              other._recurringTransactions,
              _recurringTransactions,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_recurringTransactions),
  );

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringLoadedImplCopyWith<_$RecurringLoadedImpl> get copyWith =>
      __$$RecurringLoadedImplCopyWithImpl<_$RecurringLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RecurringTransaction> recurringTransactions)
    loaded,
    required TResult Function() processing,
    required TResult Function(int count) processed,
    required TResult Function(String message) error,
  }) {
    return loaded(recurringTransactions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult? Function()? processing,
    TResult? Function(int count)? processed,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(recurringTransactions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult Function()? processing,
    TResult Function(int count)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(recurringTransactions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RecurringInitial value) initial,
    required TResult Function(RecurringLoading value) loading,
    required TResult Function(RecurringLoaded value) loaded,
    required TResult Function(RecurringProcessing value) processing,
    required TResult Function(RecurringProcessed value) processed,
    required TResult Function(RecurringError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RecurringInitial value)? initial,
    TResult? Function(RecurringLoading value)? loading,
    TResult? Function(RecurringLoaded value)? loaded,
    TResult? Function(RecurringProcessing value)? processing,
    TResult? Function(RecurringProcessed value)? processed,
    TResult? Function(RecurringError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RecurringInitial value)? initial,
    TResult Function(RecurringLoading value)? loading,
    TResult Function(RecurringLoaded value)? loaded,
    TResult Function(RecurringProcessing value)? processing,
    TResult Function(RecurringProcessed value)? processed,
    TResult Function(RecurringError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class RecurringLoaded implements RecurringState {
  const factory RecurringLoaded({
    required final List<RecurringTransaction> recurringTransactions,
  }) = _$RecurringLoadedImpl;

  List<RecurringTransaction> get recurringTransactions;

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecurringLoadedImplCopyWith<_$RecurringLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RecurringProcessingImplCopyWith<$Res> {
  factory _$$RecurringProcessingImplCopyWith(
    _$RecurringProcessingImpl value,
    $Res Function(_$RecurringProcessingImpl) then,
  ) = __$$RecurringProcessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RecurringProcessingImplCopyWithImpl<$Res>
    extends _$RecurringStateCopyWithImpl<$Res, _$RecurringProcessingImpl>
    implements _$$RecurringProcessingImplCopyWith<$Res> {
  __$$RecurringProcessingImplCopyWithImpl(
    _$RecurringProcessingImpl _value,
    $Res Function(_$RecurringProcessingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RecurringProcessingImpl implements RecurringProcessing {
  const _$RecurringProcessingImpl();

  @override
  String toString() {
    return 'RecurringState.processing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringProcessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RecurringTransaction> recurringTransactions)
    loaded,
    required TResult Function() processing,
    required TResult Function(int count) processed,
    required TResult Function(String message) error,
  }) {
    return processing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult? Function()? processing,
    TResult? Function(int count)? processed,
    TResult? Function(String message)? error,
  }) {
    return processing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult Function()? processing,
    TResult Function(int count)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RecurringInitial value) initial,
    required TResult Function(RecurringLoading value) loading,
    required TResult Function(RecurringLoaded value) loaded,
    required TResult Function(RecurringProcessing value) processing,
    required TResult Function(RecurringProcessed value) processed,
    required TResult Function(RecurringError value) error,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RecurringInitial value)? initial,
    TResult? Function(RecurringLoading value)? loading,
    TResult? Function(RecurringLoaded value)? loaded,
    TResult? Function(RecurringProcessing value)? processing,
    TResult? Function(RecurringProcessed value)? processed,
    TResult? Function(RecurringError value)? error,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RecurringInitial value)? initial,
    TResult Function(RecurringLoading value)? loading,
    TResult Function(RecurringLoaded value)? loaded,
    TResult Function(RecurringProcessing value)? processing,
    TResult Function(RecurringProcessed value)? processed,
    TResult Function(RecurringError value)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class RecurringProcessing implements RecurringState {
  const factory RecurringProcessing() = _$RecurringProcessingImpl;
}

/// @nodoc
abstract class _$$RecurringProcessedImplCopyWith<$Res> {
  factory _$$RecurringProcessedImplCopyWith(
    _$RecurringProcessedImpl value,
    $Res Function(_$RecurringProcessedImpl) then,
  ) = __$$RecurringProcessedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int count});
}

/// @nodoc
class __$$RecurringProcessedImplCopyWithImpl<$Res>
    extends _$RecurringStateCopyWithImpl<$Res, _$RecurringProcessedImpl>
    implements _$$RecurringProcessedImplCopyWith<$Res> {
  __$$RecurringProcessedImplCopyWithImpl(
    _$RecurringProcessedImpl _value,
    $Res Function(_$RecurringProcessedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? count = null}) {
    return _then(
      _$RecurringProcessedImpl(
        null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$RecurringProcessedImpl implements RecurringProcessed {
  const _$RecurringProcessedImpl(this.count);

  @override
  final int count;

  @override
  String toString() {
    return 'RecurringState.processed(count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringProcessedImpl &&
            (identical(other.count, count) || other.count == count));
  }

  @override
  int get hashCode => Object.hash(runtimeType, count);

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringProcessedImplCopyWith<_$RecurringProcessedImpl> get copyWith =>
      __$$RecurringProcessedImplCopyWithImpl<_$RecurringProcessedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RecurringTransaction> recurringTransactions)
    loaded,
    required TResult Function() processing,
    required TResult Function(int count) processed,
    required TResult Function(String message) error,
  }) {
    return processed(count);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult? Function()? processing,
    TResult? Function(int count)? processed,
    TResult? Function(String message)? error,
  }) {
    return processed?.call(count);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult Function()? processing,
    TResult Function(int count)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (processed != null) {
      return processed(count);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RecurringInitial value) initial,
    required TResult Function(RecurringLoading value) loading,
    required TResult Function(RecurringLoaded value) loaded,
    required TResult Function(RecurringProcessing value) processing,
    required TResult Function(RecurringProcessed value) processed,
    required TResult Function(RecurringError value) error,
  }) {
    return processed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RecurringInitial value)? initial,
    TResult? Function(RecurringLoading value)? loading,
    TResult? Function(RecurringLoaded value)? loaded,
    TResult? Function(RecurringProcessing value)? processing,
    TResult? Function(RecurringProcessed value)? processed,
    TResult? Function(RecurringError value)? error,
  }) {
    return processed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RecurringInitial value)? initial,
    TResult Function(RecurringLoading value)? loading,
    TResult Function(RecurringLoaded value)? loaded,
    TResult Function(RecurringProcessing value)? processing,
    TResult Function(RecurringProcessed value)? processed,
    TResult Function(RecurringError value)? error,
    required TResult orElse(),
  }) {
    if (processed != null) {
      return processed(this);
    }
    return orElse();
  }
}

abstract class RecurringProcessed implements RecurringState {
  const factory RecurringProcessed(final int count) = _$RecurringProcessedImpl;

  int get count;

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecurringProcessedImplCopyWith<_$RecurringProcessedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RecurringErrorImplCopyWith<$Res> {
  factory _$$RecurringErrorImplCopyWith(
    _$RecurringErrorImpl value,
    $Res Function(_$RecurringErrorImpl) then,
  ) = __$$RecurringErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$RecurringErrorImplCopyWithImpl<$Res>
    extends _$RecurringStateCopyWithImpl<$Res, _$RecurringErrorImpl>
    implements _$$RecurringErrorImplCopyWith<$Res> {
  __$$RecurringErrorImplCopyWithImpl(
    _$RecurringErrorImpl _value,
    $Res Function(_$RecurringErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$RecurringErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RecurringErrorImpl implements RecurringError {
  const _$RecurringErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'RecurringState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecurringErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecurringErrorImplCopyWith<_$RecurringErrorImpl> get copyWith =>
      __$$RecurringErrorImplCopyWithImpl<_$RecurringErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RecurringTransaction> recurringTransactions)
    loaded,
    required TResult Function() processing,
    required TResult Function(int count) processed,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult? Function()? processing,
    TResult? Function(int count)? processed,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RecurringTransaction> recurringTransactions)? loaded,
    TResult Function()? processing,
    TResult Function(int count)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RecurringInitial value) initial,
    required TResult Function(RecurringLoading value) loading,
    required TResult Function(RecurringLoaded value) loaded,
    required TResult Function(RecurringProcessing value) processing,
    required TResult Function(RecurringProcessed value) processed,
    required TResult Function(RecurringError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RecurringInitial value)? initial,
    TResult? Function(RecurringLoading value)? loading,
    TResult? Function(RecurringLoaded value)? loaded,
    TResult? Function(RecurringProcessing value)? processing,
    TResult? Function(RecurringProcessed value)? processed,
    TResult? Function(RecurringError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RecurringInitial value)? initial,
    TResult Function(RecurringLoading value)? loading,
    TResult Function(RecurringLoaded value)? loaded,
    TResult Function(RecurringProcessing value)? processing,
    TResult Function(RecurringProcessed value)? processed,
    TResult Function(RecurringError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RecurringError implements RecurringState {
  const factory RecurringError(final String message) = _$RecurringErrorImpl;

  String get message;

  /// Create a copy of RecurringState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecurringErrorImplCopyWith<_$RecurringErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
