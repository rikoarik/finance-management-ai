// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smart_budget_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SmartBudgetEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double monthlyIncome) generateSmartBudget,
    required TResult Function(Budget budget) applySmartBudget,
    required TResult Function(double newIncome) recalculateBudget,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double monthlyIncome)? generateSmartBudget,
    TResult? Function(Budget budget)? applySmartBudget,
    TResult? Function(double newIncome)? recalculateBudget,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double monthlyIncome)? generateSmartBudget,
    TResult Function(Budget budget)? applySmartBudget,
    TResult Function(double newIncome)? recalculateBudget,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenerateSmartBudget value) generateSmartBudget,
    required TResult Function(ApplySmartBudget value) applySmartBudget,
    required TResult Function(RecalculateBudget value) recalculateBudget,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenerateSmartBudget value)? generateSmartBudget,
    TResult? Function(ApplySmartBudget value)? applySmartBudget,
    TResult? Function(RecalculateBudget value)? recalculateBudget,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenerateSmartBudget value)? generateSmartBudget,
    TResult Function(ApplySmartBudget value)? applySmartBudget,
    TResult Function(RecalculateBudget value)? recalculateBudget,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartBudgetEventCopyWith<$Res> {
  factory $SmartBudgetEventCopyWith(
    SmartBudgetEvent value,
    $Res Function(SmartBudgetEvent) then,
  ) = _$SmartBudgetEventCopyWithImpl<$Res, SmartBudgetEvent>;
}

/// @nodoc
class _$SmartBudgetEventCopyWithImpl<$Res, $Val extends SmartBudgetEvent>
    implements $SmartBudgetEventCopyWith<$Res> {
  _$SmartBudgetEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmartBudgetEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$GenerateSmartBudgetImplCopyWith<$Res> {
  factory _$$GenerateSmartBudgetImplCopyWith(
    _$GenerateSmartBudgetImpl value,
    $Res Function(_$GenerateSmartBudgetImpl) then,
  ) = __$$GenerateSmartBudgetImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double monthlyIncome});
}

/// @nodoc
class __$$GenerateSmartBudgetImplCopyWithImpl<$Res>
    extends _$SmartBudgetEventCopyWithImpl<$Res, _$GenerateSmartBudgetImpl>
    implements _$$GenerateSmartBudgetImplCopyWith<$Res> {
  __$$GenerateSmartBudgetImplCopyWithImpl(
    _$GenerateSmartBudgetImpl _value,
    $Res Function(_$GenerateSmartBudgetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? monthlyIncome = null}) {
    return _then(
      _$GenerateSmartBudgetImpl(
        null == monthlyIncome
            ? _value.monthlyIncome
            : monthlyIncome // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$GenerateSmartBudgetImpl implements GenerateSmartBudget {
  const _$GenerateSmartBudgetImpl(this.monthlyIncome);

  @override
  final double monthlyIncome;

  @override
  String toString() {
    return 'SmartBudgetEvent.generateSmartBudget(monthlyIncome: $monthlyIncome)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GenerateSmartBudgetImpl &&
            (identical(other.monthlyIncome, monthlyIncome) ||
                other.monthlyIncome == monthlyIncome));
  }

  @override
  int get hashCode => Object.hash(runtimeType, monthlyIncome);

  /// Create a copy of SmartBudgetEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GenerateSmartBudgetImplCopyWith<_$GenerateSmartBudgetImpl> get copyWith =>
      __$$GenerateSmartBudgetImplCopyWithImpl<_$GenerateSmartBudgetImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double monthlyIncome) generateSmartBudget,
    required TResult Function(Budget budget) applySmartBudget,
    required TResult Function(double newIncome) recalculateBudget,
  }) {
    return generateSmartBudget(monthlyIncome);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double monthlyIncome)? generateSmartBudget,
    TResult? Function(Budget budget)? applySmartBudget,
    TResult? Function(double newIncome)? recalculateBudget,
  }) {
    return generateSmartBudget?.call(monthlyIncome);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double monthlyIncome)? generateSmartBudget,
    TResult Function(Budget budget)? applySmartBudget,
    TResult Function(double newIncome)? recalculateBudget,
    required TResult orElse(),
  }) {
    if (generateSmartBudget != null) {
      return generateSmartBudget(monthlyIncome);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenerateSmartBudget value) generateSmartBudget,
    required TResult Function(ApplySmartBudget value) applySmartBudget,
    required TResult Function(RecalculateBudget value) recalculateBudget,
  }) {
    return generateSmartBudget(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenerateSmartBudget value)? generateSmartBudget,
    TResult? Function(ApplySmartBudget value)? applySmartBudget,
    TResult? Function(RecalculateBudget value)? recalculateBudget,
  }) {
    return generateSmartBudget?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenerateSmartBudget value)? generateSmartBudget,
    TResult Function(ApplySmartBudget value)? applySmartBudget,
    TResult Function(RecalculateBudget value)? recalculateBudget,
    required TResult orElse(),
  }) {
    if (generateSmartBudget != null) {
      return generateSmartBudget(this);
    }
    return orElse();
  }
}

abstract class GenerateSmartBudget implements SmartBudgetEvent {
  const factory GenerateSmartBudget(final double monthlyIncome) =
      _$GenerateSmartBudgetImpl;

  double get monthlyIncome;

  /// Create a copy of SmartBudgetEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GenerateSmartBudgetImplCopyWith<_$GenerateSmartBudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApplySmartBudgetImplCopyWith<$Res> {
  factory _$$ApplySmartBudgetImplCopyWith(
    _$ApplySmartBudgetImpl value,
    $Res Function(_$ApplySmartBudgetImpl) then,
  ) = __$$ApplySmartBudgetImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Budget budget});
}

/// @nodoc
class __$$ApplySmartBudgetImplCopyWithImpl<$Res>
    extends _$SmartBudgetEventCopyWithImpl<$Res, _$ApplySmartBudgetImpl>
    implements _$$ApplySmartBudgetImplCopyWith<$Res> {
  __$$ApplySmartBudgetImplCopyWithImpl(
    _$ApplySmartBudgetImpl _value,
    $Res Function(_$ApplySmartBudgetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? budget = null}) {
    return _then(
      _$ApplySmartBudgetImpl(
        null == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as Budget,
      ),
    );
  }
}

/// @nodoc

class _$ApplySmartBudgetImpl implements ApplySmartBudget {
  const _$ApplySmartBudgetImpl(this.budget);

  @override
  final Budget budget;

  @override
  String toString() {
    return 'SmartBudgetEvent.applySmartBudget(budget: $budget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApplySmartBudgetImpl &&
            (identical(other.budget, budget) || other.budget == budget));
  }

  @override
  int get hashCode => Object.hash(runtimeType, budget);

  /// Create a copy of SmartBudgetEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ApplySmartBudgetImplCopyWith<_$ApplySmartBudgetImpl> get copyWith =>
      __$$ApplySmartBudgetImplCopyWithImpl<_$ApplySmartBudgetImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double monthlyIncome) generateSmartBudget,
    required TResult Function(Budget budget) applySmartBudget,
    required TResult Function(double newIncome) recalculateBudget,
  }) {
    return applySmartBudget(budget);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double monthlyIncome)? generateSmartBudget,
    TResult? Function(Budget budget)? applySmartBudget,
    TResult? Function(double newIncome)? recalculateBudget,
  }) {
    return applySmartBudget?.call(budget);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double monthlyIncome)? generateSmartBudget,
    TResult Function(Budget budget)? applySmartBudget,
    TResult Function(double newIncome)? recalculateBudget,
    required TResult orElse(),
  }) {
    if (applySmartBudget != null) {
      return applySmartBudget(budget);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenerateSmartBudget value) generateSmartBudget,
    required TResult Function(ApplySmartBudget value) applySmartBudget,
    required TResult Function(RecalculateBudget value) recalculateBudget,
  }) {
    return applySmartBudget(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenerateSmartBudget value)? generateSmartBudget,
    TResult? Function(ApplySmartBudget value)? applySmartBudget,
    TResult? Function(RecalculateBudget value)? recalculateBudget,
  }) {
    return applySmartBudget?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenerateSmartBudget value)? generateSmartBudget,
    TResult Function(ApplySmartBudget value)? applySmartBudget,
    TResult Function(RecalculateBudget value)? recalculateBudget,
    required TResult orElse(),
  }) {
    if (applySmartBudget != null) {
      return applySmartBudget(this);
    }
    return orElse();
  }
}

abstract class ApplySmartBudget implements SmartBudgetEvent {
  const factory ApplySmartBudget(final Budget budget) = _$ApplySmartBudgetImpl;

  Budget get budget;

  /// Create a copy of SmartBudgetEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ApplySmartBudgetImplCopyWith<_$ApplySmartBudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RecalculateBudgetImplCopyWith<$Res> {
  factory _$$RecalculateBudgetImplCopyWith(
    _$RecalculateBudgetImpl value,
    $Res Function(_$RecalculateBudgetImpl) then,
  ) = __$$RecalculateBudgetImplCopyWithImpl<$Res>;
  @useResult
  $Res call({double newIncome});
}

/// @nodoc
class __$$RecalculateBudgetImplCopyWithImpl<$Res>
    extends _$SmartBudgetEventCopyWithImpl<$Res, _$RecalculateBudgetImpl>
    implements _$$RecalculateBudgetImplCopyWith<$Res> {
  __$$RecalculateBudgetImplCopyWithImpl(
    _$RecalculateBudgetImpl _value,
    $Res Function(_$RecalculateBudgetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? newIncome = null}) {
    return _then(
      _$RecalculateBudgetImpl(
        null == newIncome
            ? _value.newIncome
            : newIncome // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$RecalculateBudgetImpl implements RecalculateBudget {
  const _$RecalculateBudgetImpl(this.newIncome);

  @override
  final double newIncome;

  @override
  String toString() {
    return 'SmartBudgetEvent.recalculateBudget(newIncome: $newIncome)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecalculateBudgetImpl &&
            (identical(other.newIncome, newIncome) ||
                other.newIncome == newIncome));
  }

  @override
  int get hashCode => Object.hash(runtimeType, newIncome);

  /// Create a copy of SmartBudgetEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecalculateBudgetImplCopyWith<_$RecalculateBudgetImpl> get copyWith =>
      __$$RecalculateBudgetImplCopyWithImpl<_$RecalculateBudgetImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(double monthlyIncome) generateSmartBudget,
    required TResult Function(Budget budget) applySmartBudget,
    required TResult Function(double newIncome) recalculateBudget,
  }) {
    return recalculateBudget(newIncome);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(double monthlyIncome)? generateSmartBudget,
    TResult? Function(Budget budget)? applySmartBudget,
    TResult? Function(double newIncome)? recalculateBudget,
  }) {
    return recalculateBudget?.call(newIncome);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(double monthlyIncome)? generateSmartBudget,
    TResult Function(Budget budget)? applySmartBudget,
    TResult Function(double newIncome)? recalculateBudget,
    required TResult orElse(),
  }) {
    if (recalculateBudget != null) {
      return recalculateBudget(newIncome);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(GenerateSmartBudget value) generateSmartBudget,
    required TResult Function(ApplySmartBudget value) applySmartBudget,
    required TResult Function(RecalculateBudget value) recalculateBudget,
  }) {
    return recalculateBudget(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(GenerateSmartBudget value)? generateSmartBudget,
    TResult? Function(ApplySmartBudget value)? applySmartBudget,
    TResult? Function(RecalculateBudget value)? recalculateBudget,
  }) {
    return recalculateBudget?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(GenerateSmartBudget value)? generateSmartBudget,
    TResult Function(ApplySmartBudget value)? applySmartBudget,
    TResult Function(RecalculateBudget value)? recalculateBudget,
    required TResult orElse(),
  }) {
    if (recalculateBudget != null) {
      return recalculateBudget(this);
    }
    return orElse();
  }
}

abstract class RecalculateBudget implements SmartBudgetEvent {
  const factory RecalculateBudget(final double newIncome) =
      _$RecalculateBudgetImpl;

  double get newIncome;

  /// Create a copy of SmartBudgetEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecalculateBudgetImplCopyWith<_$RecalculateBudgetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
