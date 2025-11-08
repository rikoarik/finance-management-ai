// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'smart_budget_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SmartBudgetState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() analyzing,
    required TResult Function() generating,
    required TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )
    generated,
    required TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )
    tips,
    required TResult Function() applying,
    required TResult Function() applied,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? analyzing,
    TResult? Function()? generating,
    TResult? Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult? Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult? Function()? applying,
    TResult? Function()? applied,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? analyzing,
    TResult Function()? generating,
    TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult Function()? applying,
    TResult Function()? applied,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SmartBudgetInitial value) initial,
    required TResult Function(SmartBudgetAnalyzing value) analyzing,
    required TResult Function(SmartBudgetGenerating value) generating,
    required TResult Function(SmartBudgetGenerated value) generated,
    required TResult Function(SmartBudgetTips value) tips,
    required TResult Function(SmartBudgetApplying value) applying,
    required TResult Function(SmartBudgetApplied value) applied,
    required TResult Function(SmartBudgetError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartBudgetInitial value)? initial,
    TResult? Function(SmartBudgetAnalyzing value)? analyzing,
    TResult? Function(SmartBudgetGenerating value)? generating,
    TResult? Function(SmartBudgetGenerated value)? generated,
    TResult? Function(SmartBudgetTips value)? tips,
    TResult? Function(SmartBudgetApplying value)? applying,
    TResult? Function(SmartBudgetApplied value)? applied,
    TResult? Function(SmartBudgetError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartBudgetInitial value)? initial,
    TResult Function(SmartBudgetAnalyzing value)? analyzing,
    TResult Function(SmartBudgetGenerating value)? generating,
    TResult Function(SmartBudgetGenerated value)? generated,
    TResult Function(SmartBudgetTips value)? tips,
    TResult Function(SmartBudgetApplying value)? applying,
    TResult Function(SmartBudgetApplied value)? applied,
    TResult Function(SmartBudgetError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartBudgetStateCopyWith<$Res> {
  factory $SmartBudgetStateCopyWith(
    SmartBudgetState value,
    $Res Function(SmartBudgetState) then,
  ) = _$SmartBudgetStateCopyWithImpl<$Res, SmartBudgetState>;
}

/// @nodoc
class _$SmartBudgetStateCopyWithImpl<$Res, $Val extends SmartBudgetState>
    implements $SmartBudgetStateCopyWith<$Res> {
  _$SmartBudgetStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SmartBudgetInitialImplCopyWith<$Res> {
  factory _$$SmartBudgetInitialImplCopyWith(
    _$SmartBudgetInitialImpl value,
    $Res Function(_$SmartBudgetInitialImpl) then,
  ) = __$$SmartBudgetInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SmartBudgetInitialImplCopyWithImpl<$Res>
    extends _$SmartBudgetStateCopyWithImpl<$Res, _$SmartBudgetInitialImpl>
    implements _$$SmartBudgetInitialImplCopyWith<$Res> {
  __$$SmartBudgetInitialImplCopyWithImpl(
    _$SmartBudgetInitialImpl _value,
    $Res Function(_$SmartBudgetInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SmartBudgetInitialImpl implements SmartBudgetInitial {
  const _$SmartBudgetInitialImpl();

  @override
  String toString() {
    return 'SmartBudgetState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SmartBudgetInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() analyzing,
    required TResult Function() generating,
    required TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )
    generated,
    required TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )
    tips,
    required TResult Function() applying,
    required TResult Function() applied,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? analyzing,
    TResult? Function()? generating,
    TResult? Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult? Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult? Function()? applying,
    TResult? Function()? applied,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? analyzing,
    TResult Function()? generating,
    TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult Function()? applying,
    TResult Function()? applied,
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
    required TResult Function(SmartBudgetInitial value) initial,
    required TResult Function(SmartBudgetAnalyzing value) analyzing,
    required TResult Function(SmartBudgetGenerating value) generating,
    required TResult Function(SmartBudgetGenerated value) generated,
    required TResult Function(SmartBudgetTips value) tips,
    required TResult Function(SmartBudgetApplying value) applying,
    required TResult Function(SmartBudgetApplied value) applied,
    required TResult Function(SmartBudgetError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartBudgetInitial value)? initial,
    TResult? Function(SmartBudgetAnalyzing value)? analyzing,
    TResult? Function(SmartBudgetGenerating value)? generating,
    TResult? Function(SmartBudgetGenerated value)? generated,
    TResult? Function(SmartBudgetTips value)? tips,
    TResult? Function(SmartBudgetApplying value)? applying,
    TResult? Function(SmartBudgetApplied value)? applied,
    TResult? Function(SmartBudgetError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartBudgetInitial value)? initial,
    TResult Function(SmartBudgetAnalyzing value)? analyzing,
    TResult Function(SmartBudgetGenerating value)? generating,
    TResult Function(SmartBudgetGenerated value)? generated,
    TResult Function(SmartBudgetTips value)? tips,
    TResult Function(SmartBudgetApplying value)? applying,
    TResult Function(SmartBudgetApplied value)? applied,
    TResult Function(SmartBudgetError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SmartBudgetInitial implements SmartBudgetState {
  const factory SmartBudgetInitial() = _$SmartBudgetInitialImpl;
}

/// @nodoc
abstract class _$$SmartBudgetAnalyzingImplCopyWith<$Res> {
  factory _$$SmartBudgetAnalyzingImplCopyWith(
    _$SmartBudgetAnalyzingImpl value,
    $Res Function(_$SmartBudgetAnalyzingImpl) then,
  ) = __$$SmartBudgetAnalyzingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SmartBudgetAnalyzingImplCopyWithImpl<$Res>
    extends _$SmartBudgetStateCopyWithImpl<$Res, _$SmartBudgetAnalyzingImpl>
    implements _$$SmartBudgetAnalyzingImplCopyWith<$Res> {
  __$$SmartBudgetAnalyzingImplCopyWithImpl(
    _$SmartBudgetAnalyzingImpl _value,
    $Res Function(_$SmartBudgetAnalyzingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SmartBudgetAnalyzingImpl implements SmartBudgetAnalyzing {
  const _$SmartBudgetAnalyzingImpl();

  @override
  String toString() {
    return 'SmartBudgetState.analyzing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartBudgetAnalyzingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() analyzing,
    required TResult Function() generating,
    required TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )
    generated,
    required TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )
    tips,
    required TResult Function() applying,
    required TResult Function() applied,
    required TResult Function(String message) error,
  }) {
    return analyzing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? analyzing,
    TResult? Function()? generating,
    TResult? Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult? Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult? Function()? applying,
    TResult? Function()? applied,
    TResult? Function(String message)? error,
  }) {
    return analyzing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? analyzing,
    TResult Function()? generating,
    TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult Function()? applying,
    TResult Function()? applied,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (analyzing != null) {
      return analyzing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SmartBudgetInitial value) initial,
    required TResult Function(SmartBudgetAnalyzing value) analyzing,
    required TResult Function(SmartBudgetGenerating value) generating,
    required TResult Function(SmartBudgetGenerated value) generated,
    required TResult Function(SmartBudgetTips value) tips,
    required TResult Function(SmartBudgetApplying value) applying,
    required TResult Function(SmartBudgetApplied value) applied,
    required TResult Function(SmartBudgetError value) error,
  }) {
    return analyzing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartBudgetInitial value)? initial,
    TResult? Function(SmartBudgetAnalyzing value)? analyzing,
    TResult? Function(SmartBudgetGenerating value)? generating,
    TResult? Function(SmartBudgetGenerated value)? generated,
    TResult? Function(SmartBudgetTips value)? tips,
    TResult? Function(SmartBudgetApplying value)? applying,
    TResult? Function(SmartBudgetApplied value)? applied,
    TResult? Function(SmartBudgetError value)? error,
  }) {
    return analyzing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartBudgetInitial value)? initial,
    TResult Function(SmartBudgetAnalyzing value)? analyzing,
    TResult Function(SmartBudgetGenerating value)? generating,
    TResult Function(SmartBudgetGenerated value)? generated,
    TResult Function(SmartBudgetTips value)? tips,
    TResult Function(SmartBudgetApplying value)? applying,
    TResult Function(SmartBudgetApplied value)? applied,
    TResult Function(SmartBudgetError value)? error,
    required TResult orElse(),
  }) {
    if (analyzing != null) {
      return analyzing(this);
    }
    return orElse();
  }
}

abstract class SmartBudgetAnalyzing implements SmartBudgetState {
  const factory SmartBudgetAnalyzing() = _$SmartBudgetAnalyzingImpl;
}

/// @nodoc
abstract class _$$SmartBudgetGeneratingImplCopyWith<$Res> {
  factory _$$SmartBudgetGeneratingImplCopyWith(
    _$SmartBudgetGeneratingImpl value,
    $Res Function(_$SmartBudgetGeneratingImpl) then,
  ) = __$$SmartBudgetGeneratingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SmartBudgetGeneratingImplCopyWithImpl<$Res>
    extends _$SmartBudgetStateCopyWithImpl<$Res, _$SmartBudgetGeneratingImpl>
    implements _$$SmartBudgetGeneratingImplCopyWith<$Res> {
  __$$SmartBudgetGeneratingImplCopyWithImpl(
    _$SmartBudgetGeneratingImpl _value,
    $Res Function(_$SmartBudgetGeneratingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SmartBudgetGeneratingImpl implements SmartBudgetGenerating {
  const _$SmartBudgetGeneratingImpl();

  @override
  String toString() {
    return 'SmartBudgetState.generating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartBudgetGeneratingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() analyzing,
    required TResult Function() generating,
    required TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )
    generated,
    required TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )
    tips,
    required TResult Function() applying,
    required TResult Function() applied,
    required TResult Function(String message) error,
  }) {
    return generating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? analyzing,
    TResult? Function()? generating,
    TResult? Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult? Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult? Function()? applying,
    TResult? Function()? applied,
    TResult? Function(String message)? error,
  }) {
    return generating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? analyzing,
    TResult Function()? generating,
    TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult Function()? applying,
    TResult Function()? applied,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (generating != null) {
      return generating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SmartBudgetInitial value) initial,
    required TResult Function(SmartBudgetAnalyzing value) analyzing,
    required TResult Function(SmartBudgetGenerating value) generating,
    required TResult Function(SmartBudgetGenerated value) generated,
    required TResult Function(SmartBudgetTips value) tips,
    required TResult Function(SmartBudgetApplying value) applying,
    required TResult Function(SmartBudgetApplied value) applied,
    required TResult Function(SmartBudgetError value) error,
  }) {
    return generating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartBudgetInitial value)? initial,
    TResult? Function(SmartBudgetAnalyzing value)? analyzing,
    TResult? Function(SmartBudgetGenerating value)? generating,
    TResult? Function(SmartBudgetGenerated value)? generated,
    TResult? Function(SmartBudgetTips value)? tips,
    TResult? Function(SmartBudgetApplying value)? applying,
    TResult? Function(SmartBudgetApplied value)? applied,
    TResult? Function(SmartBudgetError value)? error,
  }) {
    return generating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartBudgetInitial value)? initial,
    TResult Function(SmartBudgetAnalyzing value)? analyzing,
    TResult Function(SmartBudgetGenerating value)? generating,
    TResult Function(SmartBudgetGenerated value)? generated,
    TResult Function(SmartBudgetTips value)? tips,
    TResult Function(SmartBudgetApplying value)? applying,
    TResult Function(SmartBudgetApplied value)? applied,
    TResult Function(SmartBudgetError value)? error,
    required TResult orElse(),
  }) {
    if (generating != null) {
      return generating(this);
    }
    return orElse();
  }
}

abstract class SmartBudgetGenerating implements SmartBudgetState {
  const factory SmartBudgetGenerating() = _$SmartBudgetGeneratingImpl;
}

/// @nodoc
abstract class _$$SmartBudgetGeneratedImplCopyWith<$Res> {
  factory _$$SmartBudgetGeneratedImplCopyWith(
    _$SmartBudgetGeneratedImpl value,
    $Res Function(_$SmartBudgetGeneratedImpl) then,
  ) = __$$SmartBudgetGeneratedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    Budget budget,
    Map<String, double> breakdown,
    String? analysis,
    List<String>? tips,
  });
}

/// @nodoc
class __$$SmartBudgetGeneratedImplCopyWithImpl<$Res>
    extends _$SmartBudgetStateCopyWithImpl<$Res, _$SmartBudgetGeneratedImpl>
    implements _$$SmartBudgetGeneratedImplCopyWith<$Res> {
  __$$SmartBudgetGeneratedImplCopyWithImpl(
    _$SmartBudgetGeneratedImpl _value,
    $Res Function(_$SmartBudgetGeneratedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? budget = null,
    Object? breakdown = null,
    Object? analysis = freezed,
    Object? tips = freezed,
  }) {
    return _then(
      _$SmartBudgetGeneratedImpl(
        budget: null == budget
            ? _value.budget
            : budget // ignore: cast_nullable_to_non_nullable
                  as Budget,
        breakdown: null == breakdown
            ? _value._breakdown
            : breakdown // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        analysis: freezed == analysis
            ? _value.analysis
            : analysis // ignore: cast_nullable_to_non_nullable
                  as String?,
        tips: freezed == tips
            ? _value._tips
            : tips // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
      ),
    );
  }
}

/// @nodoc

class _$SmartBudgetGeneratedImpl implements SmartBudgetGenerated {
  const _$SmartBudgetGeneratedImpl({
    required this.budget,
    required final Map<String, double> breakdown,
    this.analysis,
    final List<String>? tips,
  }) : _breakdown = breakdown,
       _tips = tips;

  @override
  final Budget budget;
  final Map<String, double> _breakdown;
  @override
  Map<String, double> get breakdown {
    if (_breakdown is EqualUnmodifiableMapView) return _breakdown;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_breakdown);
  }

  @override
  final String? analysis;
  final List<String>? _tips;
  @override
  List<String>? get tips {
    final value = _tips;
    if (value == null) return null;
    if (_tips is EqualUnmodifiableListView) return _tips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SmartBudgetState.generated(budget: $budget, breakdown: $breakdown, analysis: $analysis, tips: $tips)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartBudgetGeneratedImpl &&
            (identical(other.budget, budget) || other.budget == budget) &&
            const DeepCollectionEquality().equals(
              other._breakdown,
              _breakdown,
            ) &&
            (identical(other.analysis, analysis) ||
                other.analysis == analysis) &&
            const DeepCollectionEquality().equals(other._tips, _tips));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    budget,
    const DeepCollectionEquality().hash(_breakdown),
    analysis,
    const DeepCollectionEquality().hash(_tips),
  );

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartBudgetGeneratedImplCopyWith<_$SmartBudgetGeneratedImpl>
  get copyWith =>
      __$$SmartBudgetGeneratedImplCopyWithImpl<_$SmartBudgetGeneratedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() analyzing,
    required TResult Function() generating,
    required TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )
    generated,
    required TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )
    tips,
    required TResult Function() applying,
    required TResult Function() applied,
    required TResult Function(String message) error,
  }) {
    return generated(budget, breakdown, analysis, this.tips);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? analyzing,
    TResult? Function()? generating,
    TResult? Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult? Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult? Function()? applying,
    TResult? Function()? applied,
    TResult? Function(String message)? error,
  }) {
    return generated?.call(budget, breakdown, analysis, this.tips);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? analyzing,
    TResult Function()? generating,
    TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult Function()? applying,
    TResult Function()? applied,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (generated != null) {
      return generated(budget, breakdown, analysis, this.tips);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SmartBudgetInitial value) initial,
    required TResult Function(SmartBudgetAnalyzing value) analyzing,
    required TResult Function(SmartBudgetGenerating value) generating,
    required TResult Function(SmartBudgetGenerated value) generated,
    required TResult Function(SmartBudgetTips value) tips,
    required TResult Function(SmartBudgetApplying value) applying,
    required TResult Function(SmartBudgetApplied value) applied,
    required TResult Function(SmartBudgetError value) error,
  }) {
    return generated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartBudgetInitial value)? initial,
    TResult? Function(SmartBudgetAnalyzing value)? analyzing,
    TResult? Function(SmartBudgetGenerating value)? generating,
    TResult? Function(SmartBudgetGenerated value)? generated,
    TResult? Function(SmartBudgetTips value)? tips,
    TResult? Function(SmartBudgetApplying value)? applying,
    TResult? Function(SmartBudgetApplied value)? applied,
    TResult? Function(SmartBudgetError value)? error,
  }) {
    return generated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartBudgetInitial value)? initial,
    TResult Function(SmartBudgetAnalyzing value)? analyzing,
    TResult Function(SmartBudgetGenerating value)? generating,
    TResult Function(SmartBudgetGenerated value)? generated,
    TResult Function(SmartBudgetTips value)? tips,
    TResult Function(SmartBudgetApplying value)? applying,
    TResult Function(SmartBudgetApplied value)? applied,
    TResult Function(SmartBudgetError value)? error,
    required TResult orElse(),
  }) {
    if (generated != null) {
      return generated(this);
    }
    return orElse();
  }
}

abstract class SmartBudgetGenerated implements SmartBudgetState {
  const factory SmartBudgetGenerated({
    required final Budget budget,
    required final Map<String, double> breakdown,
    final String? analysis,
    final List<String>? tips,
  }) = _$SmartBudgetGeneratedImpl;

  Budget get budget;
  Map<String, double> get breakdown;
  String? get analysis;
  List<String>? get tips;

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmartBudgetGeneratedImplCopyWith<_$SmartBudgetGeneratedImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SmartBudgetTipsImplCopyWith<$Res> {
  factory _$$SmartBudgetTipsImplCopyWith(
    _$SmartBudgetTipsImpl value,
    $Res Function(_$SmartBudgetTipsImpl) then,
  ) = __$$SmartBudgetTipsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String welcomeMessage, List<String> tips, Budget suggestedBudget});
}

/// @nodoc
class __$$SmartBudgetTipsImplCopyWithImpl<$Res>
    extends _$SmartBudgetStateCopyWithImpl<$Res, _$SmartBudgetTipsImpl>
    implements _$$SmartBudgetTipsImplCopyWith<$Res> {
  __$$SmartBudgetTipsImplCopyWithImpl(
    _$SmartBudgetTipsImpl _value,
    $Res Function(_$SmartBudgetTipsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? welcomeMessage = null,
    Object? tips = null,
    Object? suggestedBudget = null,
  }) {
    return _then(
      _$SmartBudgetTipsImpl(
        welcomeMessage: null == welcomeMessage
            ? _value.welcomeMessage
            : welcomeMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        tips: null == tips
            ? _value._tips
            : tips // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        suggestedBudget: null == suggestedBudget
            ? _value.suggestedBudget
            : suggestedBudget // ignore: cast_nullable_to_non_nullable
                  as Budget,
      ),
    );
  }
}

/// @nodoc

class _$SmartBudgetTipsImpl implements SmartBudgetTips {
  const _$SmartBudgetTipsImpl({
    required this.welcomeMessage,
    required final List<String> tips,
    required this.suggestedBudget,
  }) : _tips = tips;

  @override
  final String welcomeMessage;
  final List<String> _tips;
  @override
  List<String> get tips {
    if (_tips is EqualUnmodifiableListView) return _tips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tips);
  }

  @override
  final Budget suggestedBudget;

  @override
  String toString() {
    return 'SmartBudgetState.tips(welcomeMessage: $welcomeMessage, tips: $tips, suggestedBudget: $suggestedBudget)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartBudgetTipsImpl &&
            (identical(other.welcomeMessage, welcomeMessage) ||
                other.welcomeMessage == welcomeMessage) &&
            const DeepCollectionEquality().equals(other._tips, _tips) &&
            (identical(other.suggestedBudget, suggestedBudget) ||
                other.suggestedBudget == suggestedBudget));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    welcomeMessage,
    const DeepCollectionEquality().hash(_tips),
    suggestedBudget,
  );

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartBudgetTipsImplCopyWith<_$SmartBudgetTipsImpl> get copyWith =>
      __$$SmartBudgetTipsImplCopyWithImpl<_$SmartBudgetTipsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() analyzing,
    required TResult Function() generating,
    required TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )
    generated,
    required TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )
    tips,
    required TResult Function() applying,
    required TResult Function() applied,
    required TResult Function(String message) error,
  }) {
    return tips(welcomeMessage, this.tips, suggestedBudget);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? analyzing,
    TResult? Function()? generating,
    TResult? Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult? Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult? Function()? applying,
    TResult? Function()? applied,
    TResult? Function(String message)? error,
  }) {
    return tips?.call(welcomeMessage, this.tips, suggestedBudget);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? analyzing,
    TResult Function()? generating,
    TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult Function()? applying,
    TResult Function()? applied,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (tips != null) {
      return tips(welcomeMessage, this.tips, suggestedBudget);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SmartBudgetInitial value) initial,
    required TResult Function(SmartBudgetAnalyzing value) analyzing,
    required TResult Function(SmartBudgetGenerating value) generating,
    required TResult Function(SmartBudgetGenerated value) generated,
    required TResult Function(SmartBudgetTips value) tips,
    required TResult Function(SmartBudgetApplying value) applying,
    required TResult Function(SmartBudgetApplied value) applied,
    required TResult Function(SmartBudgetError value) error,
  }) {
    return tips(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartBudgetInitial value)? initial,
    TResult? Function(SmartBudgetAnalyzing value)? analyzing,
    TResult? Function(SmartBudgetGenerating value)? generating,
    TResult? Function(SmartBudgetGenerated value)? generated,
    TResult? Function(SmartBudgetTips value)? tips,
    TResult? Function(SmartBudgetApplying value)? applying,
    TResult? Function(SmartBudgetApplied value)? applied,
    TResult? Function(SmartBudgetError value)? error,
  }) {
    return tips?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartBudgetInitial value)? initial,
    TResult Function(SmartBudgetAnalyzing value)? analyzing,
    TResult Function(SmartBudgetGenerating value)? generating,
    TResult Function(SmartBudgetGenerated value)? generated,
    TResult Function(SmartBudgetTips value)? tips,
    TResult Function(SmartBudgetApplying value)? applying,
    TResult Function(SmartBudgetApplied value)? applied,
    TResult Function(SmartBudgetError value)? error,
    required TResult orElse(),
  }) {
    if (tips != null) {
      return tips(this);
    }
    return orElse();
  }
}

abstract class SmartBudgetTips implements SmartBudgetState {
  const factory SmartBudgetTips({
    required final String welcomeMessage,
    required final List<String> tips,
    required final Budget suggestedBudget,
  }) = _$SmartBudgetTipsImpl;

  String get welcomeMessage;
  List<String> get tips;
  Budget get suggestedBudget;

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmartBudgetTipsImplCopyWith<_$SmartBudgetTipsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SmartBudgetApplyingImplCopyWith<$Res> {
  factory _$$SmartBudgetApplyingImplCopyWith(
    _$SmartBudgetApplyingImpl value,
    $Res Function(_$SmartBudgetApplyingImpl) then,
  ) = __$$SmartBudgetApplyingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SmartBudgetApplyingImplCopyWithImpl<$Res>
    extends _$SmartBudgetStateCopyWithImpl<$Res, _$SmartBudgetApplyingImpl>
    implements _$$SmartBudgetApplyingImplCopyWith<$Res> {
  __$$SmartBudgetApplyingImplCopyWithImpl(
    _$SmartBudgetApplyingImpl _value,
    $Res Function(_$SmartBudgetApplyingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SmartBudgetApplyingImpl implements SmartBudgetApplying {
  const _$SmartBudgetApplyingImpl();

  @override
  String toString() {
    return 'SmartBudgetState.applying()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartBudgetApplyingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() analyzing,
    required TResult Function() generating,
    required TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )
    generated,
    required TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )
    tips,
    required TResult Function() applying,
    required TResult Function() applied,
    required TResult Function(String message) error,
  }) {
    return applying();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? analyzing,
    TResult? Function()? generating,
    TResult? Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult? Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult? Function()? applying,
    TResult? Function()? applied,
    TResult? Function(String message)? error,
  }) {
    return applying?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? analyzing,
    TResult Function()? generating,
    TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult Function()? applying,
    TResult Function()? applied,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (applying != null) {
      return applying();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SmartBudgetInitial value) initial,
    required TResult Function(SmartBudgetAnalyzing value) analyzing,
    required TResult Function(SmartBudgetGenerating value) generating,
    required TResult Function(SmartBudgetGenerated value) generated,
    required TResult Function(SmartBudgetTips value) tips,
    required TResult Function(SmartBudgetApplying value) applying,
    required TResult Function(SmartBudgetApplied value) applied,
    required TResult Function(SmartBudgetError value) error,
  }) {
    return applying(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartBudgetInitial value)? initial,
    TResult? Function(SmartBudgetAnalyzing value)? analyzing,
    TResult? Function(SmartBudgetGenerating value)? generating,
    TResult? Function(SmartBudgetGenerated value)? generated,
    TResult? Function(SmartBudgetTips value)? tips,
    TResult? Function(SmartBudgetApplying value)? applying,
    TResult? Function(SmartBudgetApplied value)? applied,
    TResult? Function(SmartBudgetError value)? error,
  }) {
    return applying?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartBudgetInitial value)? initial,
    TResult Function(SmartBudgetAnalyzing value)? analyzing,
    TResult Function(SmartBudgetGenerating value)? generating,
    TResult Function(SmartBudgetGenerated value)? generated,
    TResult Function(SmartBudgetTips value)? tips,
    TResult Function(SmartBudgetApplying value)? applying,
    TResult Function(SmartBudgetApplied value)? applied,
    TResult Function(SmartBudgetError value)? error,
    required TResult orElse(),
  }) {
    if (applying != null) {
      return applying(this);
    }
    return orElse();
  }
}

abstract class SmartBudgetApplying implements SmartBudgetState {
  const factory SmartBudgetApplying() = _$SmartBudgetApplyingImpl;
}

/// @nodoc
abstract class _$$SmartBudgetAppliedImplCopyWith<$Res> {
  factory _$$SmartBudgetAppliedImplCopyWith(
    _$SmartBudgetAppliedImpl value,
    $Res Function(_$SmartBudgetAppliedImpl) then,
  ) = __$$SmartBudgetAppliedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SmartBudgetAppliedImplCopyWithImpl<$Res>
    extends _$SmartBudgetStateCopyWithImpl<$Res, _$SmartBudgetAppliedImpl>
    implements _$$SmartBudgetAppliedImplCopyWith<$Res> {
  __$$SmartBudgetAppliedImplCopyWithImpl(
    _$SmartBudgetAppliedImpl _value,
    $Res Function(_$SmartBudgetAppliedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SmartBudgetAppliedImpl implements SmartBudgetApplied {
  const _$SmartBudgetAppliedImpl();

  @override
  String toString() {
    return 'SmartBudgetState.applied()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SmartBudgetAppliedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() analyzing,
    required TResult Function() generating,
    required TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )
    generated,
    required TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )
    tips,
    required TResult Function() applying,
    required TResult Function() applied,
    required TResult Function(String message) error,
  }) {
    return applied();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? analyzing,
    TResult? Function()? generating,
    TResult? Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult? Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult? Function()? applying,
    TResult? Function()? applied,
    TResult? Function(String message)? error,
  }) {
    return applied?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? analyzing,
    TResult Function()? generating,
    TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult Function()? applying,
    TResult Function()? applied,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (applied != null) {
      return applied();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SmartBudgetInitial value) initial,
    required TResult Function(SmartBudgetAnalyzing value) analyzing,
    required TResult Function(SmartBudgetGenerating value) generating,
    required TResult Function(SmartBudgetGenerated value) generated,
    required TResult Function(SmartBudgetTips value) tips,
    required TResult Function(SmartBudgetApplying value) applying,
    required TResult Function(SmartBudgetApplied value) applied,
    required TResult Function(SmartBudgetError value) error,
  }) {
    return applied(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartBudgetInitial value)? initial,
    TResult? Function(SmartBudgetAnalyzing value)? analyzing,
    TResult? Function(SmartBudgetGenerating value)? generating,
    TResult? Function(SmartBudgetGenerated value)? generated,
    TResult? Function(SmartBudgetTips value)? tips,
    TResult? Function(SmartBudgetApplying value)? applying,
    TResult? Function(SmartBudgetApplied value)? applied,
    TResult? Function(SmartBudgetError value)? error,
  }) {
    return applied?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartBudgetInitial value)? initial,
    TResult Function(SmartBudgetAnalyzing value)? analyzing,
    TResult Function(SmartBudgetGenerating value)? generating,
    TResult Function(SmartBudgetGenerated value)? generated,
    TResult Function(SmartBudgetTips value)? tips,
    TResult Function(SmartBudgetApplying value)? applying,
    TResult Function(SmartBudgetApplied value)? applied,
    TResult Function(SmartBudgetError value)? error,
    required TResult orElse(),
  }) {
    if (applied != null) {
      return applied(this);
    }
    return orElse();
  }
}

abstract class SmartBudgetApplied implements SmartBudgetState {
  const factory SmartBudgetApplied() = _$SmartBudgetAppliedImpl;
}

/// @nodoc
abstract class _$$SmartBudgetErrorImplCopyWith<$Res> {
  factory _$$SmartBudgetErrorImplCopyWith(
    _$SmartBudgetErrorImpl value,
    $Res Function(_$SmartBudgetErrorImpl) then,
  ) = __$$SmartBudgetErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SmartBudgetErrorImplCopyWithImpl<$Res>
    extends _$SmartBudgetStateCopyWithImpl<$Res, _$SmartBudgetErrorImpl>
    implements _$$SmartBudgetErrorImplCopyWith<$Res> {
  __$$SmartBudgetErrorImplCopyWithImpl(
    _$SmartBudgetErrorImpl _value,
    $Res Function(_$SmartBudgetErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$SmartBudgetErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SmartBudgetErrorImpl implements SmartBudgetError {
  const _$SmartBudgetErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SmartBudgetState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartBudgetErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartBudgetErrorImplCopyWith<_$SmartBudgetErrorImpl> get copyWith =>
      __$$SmartBudgetErrorImplCopyWithImpl<_$SmartBudgetErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() analyzing,
    required TResult Function() generating,
    required TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )
    generated,
    required TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )
    tips,
    required TResult Function() applying,
    required TResult Function() applied,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? analyzing,
    TResult? Function()? generating,
    TResult? Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult? Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult? Function()? applying,
    TResult? Function()? applied,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? analyzing,
    TResult Function()? generating,
    TResult Function(
      Budget budget,
      Map<String, double> breakdown,
      String? analysis,
      List<String>? tips,
    )?
    generated,
    TResult Function(
      String welcomeMessage,
      List<String> tips,
      Budget suggestedBudget,
    )?
    tips,
    TResult Function()? applying,
    TResult Function()? applied,
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
    required TResult Function(SmartBudgetInitial value) initial,
    required TResult Function(SmartBudgetAnalyzing value) analyzing,
    required TResult Function(SmartBudgetGenerating value) generating,
    required TResult Function(SmartBudgetGenerated value) generated,
    required TResult Function(SmartBudgetTips value) tips,
    required TResult Function(SmartBudgetApplying value) applying,
    required TResult Function(SmartBudgetApplied value) applied,
    required TResult Function(SmartBudgetError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SmartBudgetInitial value)? initial,
    TResult? Function(SmartBudgetAnalyzing value)? analyzing,
    TResult? Function(SmartBudgetGenerating value)? generating,
    TResult? Function(SmartBudgetGenerated value)? generated,
    TResult? Function(SmartBudgetTips value)? tips,
    TResult? Function(SmartBudgetApplying value)? applying,
    TResult? Function(SmartBudgetApplied value)? applied,
    TResult? Function(SmartBudgetError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SmartBudgetInitial value)? initial,
    TResult Function(SmartBudgetAnalyzing value)? analyzing,
    TResult Function(SmartBudgetGenerating value)? generating,
    TResult Function(SmartBudgetGenerated value)? generated,
    TResult Function(SmartBudgetTips value)? tips,
    TResult Function(SmartBudgetApplying value)? applying,
    TResult Function(SmartBudgetApplied value)? applied,
    TResult Function(SmartBudgetError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SmartBudgetError implements SmartBudgetState {
  const factory SmartBudgetError(final String message) = _$SmartBudgetErrorImpl;

  String get message;

  /// Create a copy of SmartBudgetState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmartBudgetErrorImplCopyWith<_$SmartBudgetErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
