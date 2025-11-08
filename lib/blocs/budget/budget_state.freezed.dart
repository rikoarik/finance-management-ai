// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'budget_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BudgetState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Budget? budget, List<String> alerts) loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Budget? budget, List<String> alerts)? loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Budget? budget, List<String> alerts)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BudgetInitial value) initial,
    required TResult Function(BudgetLoading value) loading,
    required TResult Function(BudgetLoaded value) loaded,
    required TResult Function(BudgetError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BudgetInitial value)? initial,
    TResult? Function(BudgetLoading value)? loading,
    TResult? Function(BudgetLoaded value)? loaded,
    TResult? Function(BudgetError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BudgetInitial value)? initial,
    TResult Function(BudgetLoading value)? loading,
    TResult Function(BudgetLoaded value)? loaded,
    TResult Function(BudgetError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BudgetStateCopyWith<$Res> {
  factory $BudgetStateCopyWith(
    BudgetState value,
    $Res Function(BudgetState) then,
  ) = _$BudgetStateCopyWithImpl<$Res, BudgetState>;
}

/// @nodoc
class _$BudgetStateCopyWithImpl<$Res, $Val extends BudgetState>
    implements $BudgetStateCopyWith<$Res> {
  _$BudgetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BudgetState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$BudgetInitialImplCopyWith<$Res> {
  factory _$$BudgetInitialImplCopyWith(
    _$BudgetInitialImpl value,
    $Res Function(_$BudgetInitialImpl) then,
  ) = __$$BudgetInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BudgetInitialImplCopyWithImpl<$Res>
    extends _$BudgetStateCopyWithImpl<$Res, _$BudgetInitialImpl>
    implements _$$BudgetInitialImplCopyWith<$Res> {
  __$$BudgetInitialImplCopyWithImpl(
    _$BudgetInitialImpl _value,
    $Res Function(_$BudgetInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BudgetState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BudgetInitialImpl implements BudgetInitial {
  const _$BudgetInitialImpl();

  @override
  String toString() {
    return 'BudgetState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BudgetInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Budget? budget, List<String> alerts) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Budget? budget, List<String> alerts)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Budget? budget, List<String> alerts)? loaded,
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
    required TResult Function(BudgetInitial value) initial,
    required TResult Function(BudgetLoading value) loading,
    required TResult Function(BudgetLoaded value) loaded,
    required TResult Function(BudgetError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BudgetInitial value)? initial,
    TResult? Function(BudgetLoading value)? loading,
    TResult? Function(BudgetLoaded value)? loaded,
    TResult? Function(BudgetError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BudgetInitial value)? initial,
    TResult Function(BudgetLoading value)? loading,
    TResult Function(BudgetLoaded value)? loaded,
    TResult Function(BudgetError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class BudgetInitial implements BudgetState {
  const factory BudgetInitial() = _$BudgetInitialImpl;
}

/// @nodoc
abstract class _$$BudgetLoadingImplCopyWith<$Res> {
  factory _$$BudgetLoadingImplCopyWith(
    _$BudgetLoadingImpl value,
    $Res Function(_$BudgetLoadingImpl) then,
  ) = __$$BudgetLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BudgetLoadingImplCopyWithImpl<$Res>
    extends _$BudgetStateCopyWithImpl<$Res, _$BudgetLoadingImpl>
    implements _$$BudgetLoadingImplCopyWith<$Res> {
  __$$BudgetLoadingImplCopyWithImpl(
    _$BudgetLoadingImpl _value,
    $Res Function(_$BudgetLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BudgetState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BudgetLoadingImpl implements BudgetLoading {
  const _$BudgetLoadingImpl();

  @override
  String toString() {
    return 'BudgetState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BudgetLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Budget? budget, List<String> alerts) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Budget? budget, List<String> alerts)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Budget? budget, List<String> alerts)? loaded,
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
    required TResult Function(BudgetInitial value) initial,
    required TResult Function(BudgetLoading value) loading,
    required TResult Function(BudgetLoaded value) loaded,
    required TResult Function(BudgetError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BudgetInitial value)? initial,
    TResult? Function(BudgetLoading value)? loading,
    TResult? Function(BudgetLoaded value)? loaded,
    TResult? Function(BudgetError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BudgetInitial value)? initial,
    TResult Function(BudgetLoading value)? loading,
    TResult Function(BudgetLoaded value)? loaded,
    TResult Function(BudgetError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class BudgetLoading implements BudgetState {
  const factory BudgetLoading() = _$BudgetLoadingImpl;
}

/// @nodoc
abstract class _$$BudgetLoadedImplCopyWith<$Res> {
  factory _$$BudgetLoadedImplCopyWith(
    _$BudgetLoadedImpl value,
    $Res Function(_$BudgetLoadedImpl) then,
  ) = __$$BudgetLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Budget? budget, List<String> alerts});
}

/// @nodoc
class __$$BudgetLoadedImplCopyWithImpl<$Res>
    extends _$BudgetStateCopyWithImpl<$Res, _$BudgetLoadedImpl>
    implements _$$BudgetLoadedImplCopyWith<$Res> {
  __$$BudgetLoadedImplCopyWithImpl(
    _$BudgetLoadedImpl _value,
    $Res Function(_$BudgetLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BudgetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? budget = freezed, Object? alerts = null}) {
    return _then(
      _$BudgetLoadedImpl(
        budget: freezed == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as Budget?,
        alerts: null == alerts
            ? _value._alerts
            : alerts // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc

class _$BudgetLoadedImpl implements BudgetLoaded {
  const _$BudgetLoadedImpl({
    required this.budget,
    final List<String> alerts = const [],
  }) : _alerts = alerts;

  @override
  final Budget? budget;
  final List<String> _alerts;
  @override
  @JsonKey()
  List<String> get alerts {
    if (_alerts is EqualUnmodifiableListView) return _alerts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alerts);
  }

  @override
  String toString() {
    return 'BudgetState.loaded(budget: $budget, alerts: $alerts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetLoadedImpl &&
            (identical(other.budget, budget) || other.budget == budget) &&
            const DeepCollectionEquality().equals(other._alerts, _alerts));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    budget,
    const DeepCollectionEquality().hash(_alerts),
  );

  /// Create a copy of BudgetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetLoadedImplCopyWith<_$BudgetLoadedImpl> get copyWith =>
      __$$BudgetLoadedImplCopyWithImpl<_$BudgetLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Budget? budget, List<String> alerts) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(budget, alerts);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Budget? budget, List<String> alerts)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(budget, alerts);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Budget? budget, List<String> alerts)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(budget, alerts);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(BudgetInitial value) initial,
    required TResult Function(BudgetLoading value) loading,
    required TResult Function(BudgetLoaded value) loaded,
    required TResult Function(BudgetError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BudgetInitial value)? initial,
    TResult? Function(BudgetLoading value)? loading,
    TResult? Function(BudgetLoaded value)? loaded,
    TResult? Function(BudgetError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BudgetInitial value)? initial,
    TResult Function(BudgetLoading value)? loading,
    TResult Function(BudgetLoaded value)? loaded,
    TResult Function(BudgetError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class BudgetLoaded implements BudgetState {
  const factory BudgetLoaded({
    required final Budget? budget,
    final List<String> alerts,
  }) = _$BudgetLoadedImpl;

  Budget? get budget;
  List<String> get alerts;

  /// Create a copy of BudgetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetLoadedImplCopyWith<_$BudgetLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BudgetErrorImplCopyWith<$Res> {
  factory _$$BudgetErrorImplCopyWith(
    _$BudgetErrorImpl value,
    $Res Function(_$BudgetErrorImpl) then,
  ) = __$$BudgetErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$BudgetErrorImplCopyWithImpl<$Res>
    extends _$BudgetStateCopyWithImpl<$Res, _$BudgetErrorImpl>
    implements _$$BudgetErrorImplCopyWith<$Res> {
  __$$BudgetErrorImplCopyWithImpl(
    _$BudgetErrorImpl _value,
    $Res Function(_$BudgetErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BudgetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$BudgetErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$BudgetErrorImpl implements BudgetError {
  const _$BudgetErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'BudgetState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BudgetErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of BudgetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BudgetErrorImplCopyWith<_$BudgetErrorImpl> get copyWith =>
      __$$BudgetErrorImplCopyWithImpl<_$BudgetErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(Budget? budget, List<String> alerts) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(Budget? budget, List<String> alerts)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(Budget? budget, List<String> alerts)? loaded,
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
    required TResult Function(BudgetInitial value) initial,
    required TResult Function(BudgetLoading value) loading,
    required TResult Function(BudgetLoaded value) loaded,
    required TResult Function(BudgetError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(BudgetInitial value)? initial,
    TResult? Function(BudgetLoading value)? loading,
    TResult? Function(BudgetLoaded value)? loaded,
    TResult? Function(BudgetError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(BudgetInitial value)? initial,
    TResult Function(BudgetLoading value)? loading,
    TResult Function(BudgetLoaded value)? loaded,
    TResult Function(BudgetError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class BudgetError implements BudgetState {
  const factory BudgetError(final String message) = _$BudgetErrorImpl;

  String get message;

  /// Create a copy of BudgetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BudgetErrorImplCopyWith<_$BudgetErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
