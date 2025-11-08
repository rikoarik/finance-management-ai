// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TransactionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loadingMore,
    required TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
    )
    loaded,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loadingMore,
    TResult? Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loadingMore,
    TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionInitial value) initial,
    required TResult Function(TransactionLoading value) loading,
    required TResult Function(TransactionLoadingMore value) loadingMore,
    required TResult Function(TransactionLoaded value) loaded,
    required TResult Function(TransactionError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionInitial value)? initial,
    TResult? Function(TransactionLoading value)? loading,
    TResult? Function(TransactionLoadingMore value)? loadingMore,
    TResult? Function(TransactionLoaded value)? loaded,
    TResult? Function(TransactionError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionInitial value)? initial,
    TResult Function(TransactionLoading value)? loading,
    TResult Function(TransactionLoadingMore value)? loadingMore,
    TResult Function(TransactionLoaded value)? loaded,
    TResult Function(TransactionError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionStateCopyWith<$Res> {
  factory $TransactionStateCopyWith(
    TransactionState value,
    $Res Function(TransactionState) then,
  ) = _$TransactionStateCopyWithImpl<$Res, TransactionState>;
}

/// @nodoc
class _$TransactionStateCopyWithImpl<$Res, $Val extends TransactionState>
    implements $TransactionStateCopyWith<$Res> {
  _$TransactionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TransactionInitialImplCopyWith<$Res> {
  factory _$$TransactionInitialImplCopyWith(
    _$TransactionInitialImpl value,
    $Res Function(_$TransactionInitialImpl) then,
  ) = __$$TransactionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionInitialImplCopyWithImpl<$Res>
    extends _$TransactionStateCopyWithImpl<$Res, _$TransactionInitialImpl>
    implements _$$TransactionInitialImplCopyWith<$Res> {
  __$$TransactionInitialImplCopyWithImpl(
    _$TransactionInitialImpl _value,
    $Res Function(_$TransactionInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionInitialImpl implements TransactionInitial {
  const _$TransactionInitialImpl();

  @override
  String toString() {
    return 'TransactionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TransactionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loadingMore,
    required TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
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
    TResult? Function()? loadingMore,
    TResult? Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
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
    TResult Function()? loadingMore,
    TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
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
    required TResult Function(TransactionInitial value) initial,
    required TResult Function(TransactionLoading value) loading,
    required TResult Function(TransactionLoadingMore value) loadingMore,
    required TResult Function(TransactionLoaded value) loaded,
    required TResult Function(TransactionError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionInitial value)? initial,
    TResult? Function(TransactionLoading value)? loading,
    TResult? Function(TransactionLoadingMore value)? loadingMore,
    TResult? Function(TransactionLoaded value)? loaded,
    TResult? Function(TransactionError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionInitial value)? initial,
    TResult Function(TransactionLoading value)? loading,
    TResult Function(TransactionLoadingMore value)? loadingMore,
    TResult Function(TransactionLoaded value)? loaded,
    TResult Function(TransactionError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TransactionInitial implements TransactionState {
  const factory TransactionInitial() = _$TransactionInitialImpl;
}

/// @nodoc
abstract class _$$TransactionLoadingImplCopyWith<$Res> {
  factory _$$TransactionLoadingImplCopyWith(
    _$TransactionLoadingImpl value,
    $Res Function(_$TransactionLoadingImpl) then,
  ) = __$$TransactionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionLoadingImplCopyWithImpl<$Res>
    extends _$TransactionStateCopyWithImpl<$Res, _$TransactionLoadingImpl>
    implements _$$TransactionLoadingImplCopyWith<$Res> {
  __$$TransactionLoadingImplCopyWithImpl(
    _$TransactionLoadingImpl _value,
    $Res Function(_$TransactionLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionLoadingImpl implements TransactionLoading {
  const _$TransactionLoadingImpl();

  @override
  String toString() {
    return 'TransactionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$TransactionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loadingMore,
    required TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
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
    TResult? Function()? loadingMore,
    TResult? Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
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
    TResult Function()? loadingMore,
    TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
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
    required TResult Function(TransactionInitial value) initial,
    required TResult Function(TransactionLoading value) loading,
    required TResult Function(TransactionLoadingMore value) loadingMore,
    required TResult Function(TransactionLoaded value) loaded,
    required TResult Function(TransactionError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionInitial value)? initial,
    TResult? Function(TransactionLoading value)? loading,
    TResult? Function(TransactionLoadingMore value)? loadingMore,
    TResult? Function(TransactionLoaded value)? loaded,
    TResult? Function(TransactionError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionInitial value)? initial,
    TResult Function(TransactionLoading value)? loading,
    TResult Function(TransactionLoadingMore value)? loadingMore,
    TResult Function(TransactionLoaded value)? loaded,
    TResult Function(TransactionError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TransactionLoading implements TransactionState {
  const factory TransactionLoading() = _$TransactionLoadingImpl;
}

/// @nodoc
abstract class _$$TransactionLoadingMoreImplCopyWith<$Res> {
  factory _$$TransactionLoadingMoreImplCopyWith(
    _$TransactionLoadingMoreImpl value,
    $Res Function(_$TransactionLoadingMoreImpl) then,
  ) = __$$TransactionLoadingMoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TransactionLoadingMoreImplCopyWithImpl<$Res>
    extends _$TransactionStateCopyWithImpl<$Res, _$TransactionLoadingMoreImpl>
    implements _$$TransactionLoadingMoreImplCopyWith<$Res> {
  __$$TransactionLoadingMoreImplCopyWithImpl(
    _$TransactionLoadingMoreImpl _value,
    $Res Function(_$TransactionLoadingMoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TransactionLoadingMoreImpl implements TransactionLoadingMore {
  const _$TransactionLoadingMoreImpl();

  @override
  String toString() {
    return 'TransactionState.loadingMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionLoadingMoreImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loadingMore,
    required TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loadingMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loadingMore,
    TResult? Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loadingMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loadingMore,
    TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionInitial value) initial,
    required TResult Function(TransactionLoading value) loading,
    required TResult Function(TransactionLoadingMore value) loadingMore,
    required TResult Function(TransactionLoaded value) loaded,
    required TResult Function(TransactionError value) error,
  }) {
    return loadingMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionInitial value)? initial,
    TResult? Function(TransactionLoading value)? loading,
    TResult? Function(TransactionLoadingMore value)? loadingMore,
    TResult? Function(TransactionLoaded value)? loaded,
    TResult? Function(TransactionError value)? error,
  }) {
    return loadingMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionInitial value)? initial,
    TResult Function(TransactionLoading value)? loading,
    TResult Function(TransactionLoadingMore value)? loadingMore,
    TResult Function(TransactionLoaded value)? loaded,
    TResult Function(TransactionError value)? error,
    required TResult orElse(),
  }) {
    if (loadingMore != null) {
      return loadingMore(this);
    }
    return orElse();
  }
}

abstract class TransactionLoadingMore implements TransactionState {
  const factory TransactionLoadingMore() = _$TransactionLoadingMoreImpl;
}

/// @nodoc
abstract class _$$TransactionLoadedImplCopyWith<$Res> {
  factory _$$TransactionLoadedImplCopyWith(
    _$TransactionLoadedImpl value,
    $Res Function(_$TransactionLoadedImpl) then,
  ) = __$$TransactionLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    List<Transaction> transactions,
    List<Transaction> filteredTransactions,
    bool hasMore,
    int currentPage,
    DateTime? startDate,
    DateTime? endDate,
    String? typeFilter,
    String? categoryFilter,
    String searchQuery,
  });
}

/// @nodoc
class __$$TransactionLoadedImplCopyWithImpl<$Res>
    extends _$TransactionStateCopyWithImpl<$Res, _$TransactionLoadedImpl>
    implements _$$TransactionLoadedImplCopyWith<$Res> {
  __$$TransactionLoadedImplCopyWithImpl(
    _$TransactionLoadedImpl _value,
    $Res Function(_$TransactionLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactions = null,
    Object? filteredTransactions = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? startDate = freezed,
    Object? endDate = freezed,
    Object? typeFilter = freezed,
    Object? categoryFilter = freezed,
    Object? searchQuery = null,
  }) {
    return _then(
      _$TransactionLoadedImpl(
        transactions: null == transactions
            ? _value._transactions
            : transactions // ignore: cast_nullable_to_non_nullable
                  as List<Transaction>,
        filteredTransactions: null == filteredTransactions
            ? _value._filteredTransactions
            : filteredTransactions // ignore: cast_nullable_to_non_nullable
                  as List<Transaction>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        endDate: freezed == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        typeFilter: freezed == typeFilter
            ? _value.typeFilter
            : typeFilter // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryFilter: freezed == categoryFilter
            ? _value.categoryFilter
            : categoryFilter // ignore: cast_nullable_to_non_nullable
                  as String?,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TransactionLoadedImpl implements TransactionLoaded {
  const _$TransactionLoadedImpl({
    required final List<Transaction> transactions,
    required final List<Transaction> filteredTransactions,
    required this.hasMore,
    required this.currentPage,
    this.startDate,
    this.endDate,
    this.typeFilter,
    this.categoryFilter,
    this.searchQuery = '',
  }) : _transactions = transactions,
       _filteredTransactions = filteredTransactions;

  final List<Transaction> _transactions;
  @override
  List<Transaction> get transactions {
    if (_transactions is EqualUnmodifiableListView) return _transactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactions);
  }

  final List<Transaction> _filteredTransactions;
  @override
  List<Transaction> get filteredTransactions {
    if (_filteredTransactions is EqualUnmodifiableListView)
      return _filteredTransactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredTransactions);
  }

  @override
  final bool hasMore;
  @override
  final int currentPage;
  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;
  @override
  final String? typeFilter;
  @override
  final String? categoryFilter;
  @override
  @JsonKey()
  final String searchQuery;

  @override
  String toString() {
    return 'TransactionState.loaded(transactions: $transactions, filteredTransactions: $filteredTransactions, hasMore: $hasMore, currentPage: $currentPage, startDate: $startDate, endDate: $endDate, typeFilter: $typeFilter, categoryFilter: $categoryFilter, searchQuery: $searchQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionLoadedImpl &&
            const DeepCollectionEquality().equals(
              other._transactions,
              _transactions,
            ) &&
            const DeepCollectionEquality().equals(
              other._filteredTransactions,
              _filteredTransactions,
            ) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.typeFilter, typeFilter) ||
                other.typeFilter == typeFilter) &&
            (identical(other.categoryFilter, categoryFilter) ||
                other.categoryFilter == categoryFilter) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_transactions),
    const DeepCollectionEquality().hash(_filteredTransactions),
    hasMore,
    currentPage,
    startDate,
    endDate,
    typeFilter,
    categoryFilter,
    searchQuery,
  );

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionLoadedImplCopyWith<_$TransactionLoadedImpl> get copyWith =>
      __$$TransactionLoadedImplCopyWithImpl<_$TransactionLoadedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loadingMore,
    required TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
    )
    loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(
      transactions,
      filteredTransactions,
      hasMore,
      currentPage,
      startDate,
      endDate,
      typeFilter,
      categoryFilter,
      searchQuery,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? loadingMore,
    TResult? Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
    )?
    loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(
      transactions,
      filteredTransactions,
      hasMore,
      currentPage,
      startDate,
      endDate,
      typeFilter,
      categoryFilter,
      searchQuery,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? loadingMore,
    TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
    )?
    loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(
        transactions,
        filteredTransactions,
        hasMore,
        currentPage,
        startDate,
        endDate,
        typeFilter,
        categoryFilter,
        searchQuery,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TransactionInitial value) initial,
    required TResult Function(TransactionLoading value) loading,
    required TResult Function(TransactionLoadingMore value) loadingMore,
    required TResult Function(TransactionLoaded value) loaded,
    required TResult Function(TransactionError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionInitial value)? initial,
    TResult? Function(TransactionLoading value)? loading,
    TResult? Function(TransactionLoadingMore value)? loadingMore,
    TResult? Function(TransactionLoaded value)? loaded,
    TResult? Function(TransactionError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionInitial value)? initial,
    TResult Function(TransactionLoading value)? loading,
    TResult Function(TransactionLoadingMore value)? loadingMore,
    TResult Function(TransactionLoaded value)? loaded,
    TResult Function(TransactionError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class TransactionLoaded implements TransactionState {
  const factory TransactionLoaded({
    required final List<Transaction> transactions,
    required final List<Transaction> filteredTransactions,
    required final bool hasMore,
    required final int currentPage,
    final DateTime? startDate,
    final DateTime? endDate,
    final String? typeFilter,
    final String? categoryFilter,
    final String searchQuery,
  }) = _$TransactionLoadedImpl;

  List<Transaction> get transactions;
  List<Transaction> get filteredTransactions;
  bool get hasMore;
  int get currentPage;
  DateTime? get startDate;
  DateTime? get endDate;
  String? get typeFilter;
  String? get categoryFilter;
  String get searchQuery;

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionLoadedImplCopyWith<_$TransactionLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionErrorImplCopyWith<$Res> {
  factory _$$TransactionErrorImplCopyWith(
    _$TransactionErrorImpl value,
    $Res Function(_$TransactionErrorImpl) then,
  ) = __$$TransactionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$TransactionErrorImplCopyWithImpl<$Res>
    extends _$TransactionStateCopyWithImpl<$Res, _$TransactionErrorImpl>
    implements _$$TransactionErrorImplCopyWith<$Res> {
  __$$TransactionErrorImplCopyWithImpl(
    _$TransactionErrorImpl _value,
    $Res Function(_$TransactionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$TransactionErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TransactionErrorImpl implements TransactionError {
  const _$TransactionErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'TransactionState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionErrorImplCopyWith<_$TransactionErrorImpl> get copyWith =>
      __$$TransactionErrorImplCopyWithImpl<_$TransactionErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() loadingMore,
    required TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
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
    TResult? Function()? loadingMore,
    TResult? Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
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
    TResult Function()? loadingMore,
    TResult Function(
      List<Transaction> transactions,
      List<Transaction> filteredTransactions,
      bool hasMore,
      int currentPage,
      DateTime? startDate,
      DateTime? endDate,
      String? typeFilter,
      String? categoryFilter,
      String searchQuery,
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
    required TResult Function(TransactionInitial value) initial,
    required TResult Function(TransactionLoading value) loading,
    required TResult Function(TransactionLoadingMore value) loadingMore,
    required TResult Function(TransactionLoaded value) loaded,
    required TResult Function(TransactionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TransactionInitial value)? initial,
    TResult? Function(TransactionLoading value)? loading,
    TResult? Function(TransactionLoadingMore value)? loadingMore,
    TResult? Function(TransactionLoaded value)? loaded,
    TResult? Function(TransactionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TransactionInitial value)? initial,
    TResult Function(TransactionLoading value)? loading,
    TResult Function(TransactionLoadingMore value)? loadingMore,
    TResult Function(TransactionLoaded value)? loaded,
    TResult Function(TransactionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TransactionError implements TransactionState {
  const factory TransactionError(final String message) = _$TransactionErrorImpl;

  String get message;

  /// Create a copy of TransactionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionErrorImplCopyWith<_$TransactionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
