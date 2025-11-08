// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AnalyticsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AnalyticsInitial value) initial,
    required TResult Function(AnalyticsLoading value) loading,
    required TResult Function(AnalyticsLoaded value) loaded,
    required TResult Function(AnalyticsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AnalyticsInitial value)? initial,
    TResult? Function(AnalyticsLoading value)? loading,
    TResult? Function(AnalyticsLoaded value)? loaded,
    TResult? Function(AnalyticsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AnalyticsInitial value)? initial,
    TResult Function(AnalyticsLoading value)? loading,
    TResult Function(AnalyticsLoaded value)? loaded,
    TResult Function(AnalyticsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalyticsStateCopyWith<$Res> {
  factory $AnalyticsStateCopyWith(
    AnalyticsState value,
    $Res Function(AnalyticsState) then,
  ) = _$AnalyticsStateCopyWithImpl<$Res, AnalyticsState>;
}

/// @nodoc
class _$AnalyticsStateCopyWithImpl<$Res, $Val extends AnalyticsState>
    implements $AnalyticsStateCopyWith<$Res> {
  _$AnalyticsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalyticsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AnalyticsInitialImplCopyWith<$Res> {
  factory _$$AnalyticsInitialImplCopyWith(
    _$AnalyticsInitialImpl value,
    $Res Function(_$AnalyticsInitialImpl) then,
  ) = __$$AnalyticsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AnalyticsInitialImplCopyWithImpl<$Res>
    extends _$AnalyticsStateCopyWithImpl<$Res, _$AnalyticsInitialImpl>
    implements _$$AnalyticsInitialImplCopyWith<$Res> {
  __$$AnalyticsInitialImplCopyWithImpl(
    _$AnalyticsInitialImpl _value,
    $Res Function(_$AnalyticsInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AnalyticsInitialImpl implements AnalyticsInitial {
  const _$AnalyticsInitialImpl();

  @override
  String toString() {
    return 'AnalyticsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AnalyticsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )?
    loaded,
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
    required TResult Function(AnalyticsInitial value) initial,
    required TResult Function(AnalyticsLoading value) loading,
    required TResult Function(AnalyticsLoaded value) loaded,
    required TResult Function(AnalyticsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AnalyticsInitial value)? initial,
    TResult? Function(AnalyticsLoading value)? loading,
    TResult? Function(AnalyticsLoaded value)? loaded,
    TResult? Function(AnalyticsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AnalyticsInitial value)? initial,
    TResult Function(AnalyticsLoading value)? loading,
    TResult Function(AnalyticsLoaded value)? loaded,
    TResult Function(AnalyticsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AnalyticsInitial implements AnalyticsState {
  const factory AnalyticsInitial() = _$AnalyticsInitialImpl;
}

/// @nodoc
abstract class _$$AnalyticsLoadingImplCopyWith<$Res> {
  factory _$$AnalyticsLoadingImplCopyWith(
    _$AnalyticsLoadingImpl value,
    $Res Function(_$AnalyticsLoadingImpl) then,
  ) = __$$AnalyticsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AnalyticsLoadingImplCopyWithImpl<$Res>
    extends _$AnalyticsStateCopyWithImpl<$Res, _$AnalyticsLoadingImpl>
    implements _$$AnalyticsLoadingImplCopyWith<$Res> {
  __$$AnalyticsLoadingImplCopyWithImpl(
    _$AnalyticsLoadingImpl _value,
    $Res Function(_$AnalyticsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AnalyticsLoadingImpl implements AnalyticsLoading {
  const _$AnalyticsLoadingImpl();

  @override
  String toString() {
    return 'AnalyticsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AnalyticsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )?
    loaded,
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
    required TResult Function(AnalyticsInitial value) initial,
    required TResult Function(AnalyticsLoading value) loading,
    required TResult Function(AnalyticsLoaded value) loaded,
    required TResult Function(AnalyticsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AnalyticsInitial value)? initial,
    TResult? Function(AnalyticsLoading value)? loading,
    TResult? Function(AnalyticsLoaded value)? loaded,
    TResult? Function(AnalyticsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AnalyticsInitial value)? initial,
    TResult Function(AnalyticsLoading value)? loading,
    TResult Function(AnalyticsLoaded value)? loaded,
    TResult Function(AnalyticsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AnalyticsLoading implements AnalyticsState {
  const factory AnalyticsLoading() = _$AnalyticsLoadingImpl;
}

/// @nodoc
abstract class _$$AnalyticsLoadedImplCopyWith<$Res> {
  factory _$$AnalyticsLoadedImplCopyWith(
    _$AnalyticsLoadedImpl value,
    $Res Function(_$AnalyticsLoadedImpl) then,
  ) = __$$AnalyticsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    Map<String, double> expenseByCategory,
    Map<String, double> incomeByCategory,
    double totalIncome,
    double totalExpense,
    double balance,
    List<Transaction> transactions,
    TimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  });
}

/// @nodoc
class __$$AnalyticsLoadedImplCopyWithImpl<$Res>
    extends _$AnalyticsStateCopyWithImpl<$Res, _$AnalyticsLoadedImpl>
    implements _$$AnalyticsLoadedImplCopyWith<$Res> {
  __$$AnalyticsLoadedImplCopyWithImpl(
    _$AnalyticsLoadedImpl _value,
    $Res Function(_$AnalyticsLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expenseByCategory = null,
    Object? incomeByCategory = null,
    Object? totalIncome = null,
    Object? totalExpense = null,
    Object? balance = null,
    Object? transactions = null,
    Object? timeRange = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
  }) {
    return _then(
      _$AnalyticsLoadedImpl(
        expenseByCategory: null == expenseByCategory
            ? _value._expenseByCategory
            : expenseByCategory // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        incomeByCategory: null == incomeByCategory
            ? _value._incomeByCategory
            : incomeByCategory // ignore: cast_nullable_to_non_nullable
                  as Map<String, double>,
        totalIncome: null == totalIncome
            ? _value.totalIncome
            : totalIncome // ignore: cast_nullable_to_non_nullable
                  as double,
        totalExpense: null == totalExpense
            ? _value.totalExpense
            : totalExpense // ignore: cast_nullable_to_non_nullable
                  as double,
        balance: null == balance
            ? _value.balance
            : balance // ignore: cast_nullable_to_non_nullable
                  as double,
        transactions: null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<Transaction>,
        timeRange: null == timeRange
            ? _value.timeRange
            : timeRange // ignore: cast_nullable_to_non_nullable
                  as TimeRange,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc

class _$AnalyticsLoadedImpl implements AnalyticsLoaded {
  const _$AnalyticsLoadedImpl({
    required final Map<String, double> expenseByCategory,
    required final Map<String, double> incomeByCategory,
    required this.totalIncome,
    required this.totalExpense,
    required this.balance,
    required final List<Transaction> transactions,
    this.timeRange = TimeRange.month,
    this.startDate,
    this.endDate,
  }) : _expenseByCategory = expenseByCategory,
       _incomeByCategory = incomeByCategory,
       _transactions = transactions;

  final Map<String, double> _expenseByCategory;
  @override
  Map<String, double> get expenseByCategory {
    if (_expenseByCategory is EqualUnmodifiableMapView)
      return _expenseByCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_expenseByCategory);
  }

  final Map<String, double> _incomeByCategory;
  @override
  Map<String, double> get incomeByCategory {
    if (_incomeByCategory is EqualUnmodifiableMapView) return _incomeByCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_incomeByCategory);
  }

  @override
  final double totalIncome;
  @override
  final double totalExpense;
  @override
  final double balance;
  final List<Transaction> _transactions;
  @override
  List<Transaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  @override
  @JsonKey()
  final TimeRange timeRange;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'AnalyticsState.loaded(expenseByCategory: $expenseByCategory, incomeByCategory: $incomeByCategory, totalIncome: $totalIncome, totalExpense: $totalExpense, balance: $balance, transactions: $transactions, timeRange: $timeRange, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsLoadedImpl &&
            const DeepCollectionEquality().equals(
              other._expenseByCategory,
              _expenseByCategory,
            ) &&
            const DeepCollectionEquality().equals(
              other._incomeByCategory,
              _incomeByCategory,
            ) &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.totalExpense, totalExpense) ||
                other.totalExpense == totalExpense) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ) &&
            (identical(other.timeRange, timeRange) ||
                other.timeRange == timeRange) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_expenseByCategory),
    const DeepCollectionEquality().hash(_incomeByCategory),
    totalIncome,
    totalExpense,
    balance,
    const DeepCollectionEquality().hash(_transactions),
    timeRange,
    startDate,
    endDate,
  );

  /// Create a copy of AnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsLoadedImplCopyWith<_$AnalyticsLoadedImpl> get copyWith =>
      __$$AnalyticsLoadedImplCopyWithImpl<_$AnalyticsLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
      expenseByCategory,
      incomeByCategory,
      totalIncome,
      totalExpense,
      balance,
      transactions,
      timeRange,
      startDate,
      endDate,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
      expenseByCategory,
      incomeByCategory,
      totalIncome,
      totalExpense,
      balance,
      transactions,
      timeRange,
      startDate,
      endDate,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        expenseByCategory,
        incomeByCategory,
        totalIncome,
        totalExpense,
        balance,
        transactions,
        timeRange,
        startDate,
        endDate,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AnalyticsInitial value) initial,
    required TResult Function(AnalyticsLoading value) loading,
    required TResult Function(AnalyticsLoaded value) loaded,
    required TResult Function(AnalyticsError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AnalyticsInitial value)? initial,
    TResult? Function(AnalyticsLoading value)? loading,
    TResult? Function(AnalyticsLoaded value)? loaded,
    TResult? Function(AnalyticsError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AnalyticsInitial value)? initial,
    TResult Function(AnalyticsLoading value)? loading,
    TResult Function(AnalyticsLoaded value)? loaded,
    TResult Function(AnalyticsError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AnalyticsLoaded implements AnalyticsState {
  const factory AnalyticsLoaded({
    required final Map<String, double> expenseByCategory,
    required final Map<String, double> incomeByCategory,
    required final double totalIncome,
    required final double totalExpense,
    required final double balance,
    required final List<Transaction> transactions,
    final TimeRange timeRange,
    final DateTime? startDate,
    final DateTime? endDate,
  }) = _$AnalyticsLoadedImpl;

  Map<String, double> get expenseByCategory;
  Map<String, double> get incomeByCategory;
  double get totalIncome;
  double get totalExpense;
  double get balance;
  List<Transaction> get transactions;
  TimeRange get timeRange;
  DateTime? get startDate;
  DateTime? get endDate;

  /// Create a copy of AnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsLoadedImplCopyWith<_$AnalyticsLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AnalyticsErrorImplCopyWith<$Res> {
  factory _$$AnalyticsErrorImplCopyWith(
    _$AnalyticsErrorImpl value,
    $Res Function(_$AnalyticsErrorImpl) then,
  ) = __$$AnalyticsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AnalyticsErrorImplCopyWithImpl<$Res>
    extends _$AnalyticsStateCopyWithImpl<$Res, _$AnalyticsErrorImpl>
    implements _$$AnalyticsErrorImplCopyWith<$Res> {
  __$$AnalyticsErrorImplCopyWithImpl(
    _$AnalyticsErrorImpl _value,
    $Res Function(_$AnalyticsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AnalyticsErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AnalyticsErrorImpl implements AnalyticsError {
  const _$AnalyticsErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AnalyticsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalyticsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalyticsErrorImplCopyWith<_$AnalyticsErrorImpl> get copyWith =>
      __$$AnalyticsErrorImplCopyWithImpl<_$AnalyticsErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
      Map<String, double> expenseByCategory,
      Map<String, double> incomeByCategory,
      double totalIncome,
      double totalExpense,
      double balance,
      List<Transaction> transactions,
      TimeRange timeRange,
      DateTime? startDate,
      DateTime? endDate,
    )?
    loaded,
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
    required TResult Function(AnalyticsInitial value) initial,
    required TResult Function(AnalyticsLoading value) loading,
    required TResult Function(AnalyticsLoaded value) loaded,
    required TResult Function(AnalyticsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AnalyticsInitial value)? initial,
    TResult? Function(AnalyticsLoading value)? loading,
    TResult? Function(AnalyticsLoaded value)? loaded,
    TResult? Function(AnalyticsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AnalyticsInitial value)? initial,
    TResult Function(AnalyticsLoading value)? loading,
    TResult Function(AnalyticsLoaded value)? loaded,
    TResult Function(AnalyticsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AnalyticsError implements AnalyticsState {
  const factory AnalyticsError(final String message) = _$AnalyticsErrorImpl;

  String get message;

  /// Create a copy of AnalyticsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalyticsErrorImplCopyWith<_$AnalyticsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
