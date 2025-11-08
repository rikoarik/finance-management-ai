// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TransactionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionEventCopyWith<$Res> {
  factory $TransactionEventCopyWith(
    TransactionEvent value,
    $Res Function(TransactionEvent) then,
  ) = _$TransactionEventCopyWithImpl<$Res, TransactionEvent>;
}

/// @nodoc
class _$TransactionEventCopyWithImpl<$Res, $Val extends TransactionEvent>
    implements $TransactionEventCopyWith<$Res> {
  _$TransactionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadTransactionsImplCopyWith<$Res> {
  factory _$$LoadTransactionsImplCopyWith(
    _$LoadTransactionsImpl value,
    $Res Function(_$LoadTransactionsImpl) then,
  ) = __$$LoadTransactionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadTransactionsImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$LoadTransactionsImpl>
    implements _$$LoadTransactionsImplCopyWith<$Res> {
  __$$LoadTransactionsImplCopyWithImpl(
    _$LoadTransactionsImpl _value,
    $Res Function(_$LoadTransactionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadTransactionsImpl implements LoadTransactions {
  const _$LoadTransactionsImpl();

  @override
  String toString() {
    return 'TransactionEvent.loadTransactions()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadTransactionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) {
    return loadTransactions();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) {
    return loadTransactions?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) {
    if (loadTransactions != null) {
      return loadTransactions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) {
    return loadTransactions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) {
    return loadTransactions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) {
    if (loadTransactions != null) {
      return loadTransactions(this);
    }
    return orElse();
  }
}

abstract class LoadTransactions implements TransactionEvent {
  const factory LoadTransactions() = _$LoadTransactionsImpl;
}

/// @nodoc
abstract class _$$LoadMoreImplCopyWith<$Res> {
  factory _$$LoadMoreImplCopyWith(
    _$LoadMoreImpl value,
    $Res Function(_$LoadMoreImpl) then,
  ) = __$$LoadMoreImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMoreImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$LoadMoreImpl>
    implements _$$LoadMoreImplCopyWith<$Res> {
  __$$LoadMoreImplCopyWithImpl(
    _$LoadMoreImpl _value,
    $Res Function(_$LoadMoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMoreImpl implements LoadMore {
  const _$LoadMoreImpl();

  @override
  String toString() {
    return 'TransactionEvent.loadMore()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMoreImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) {
    return loadMore();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) {
    return loadMore?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) {
    return loadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) {
    return loadMore?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) {
    if (loadMore != null) {
      return loadMore(this);
    }
    return orElse();
  }
}

abstract class LoadMore implements TransactionEvent {
  const factory LoadMore() = _$LoadMoreImpl;
}

/// @nodoc
abstract class _$$RefreshTransactionsImplCopyWith<$Res> {
  factory _$$RefreshTransactionsImplCopyWith(
    _$RefreshTransactionsImpl value,
    $Res Function(_$RefreshTransactionsImpl) then,
  ) = __$$RefreshTransactionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshTransactionsImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$RefreshTransactionsImpl>
    implements _$$RefreshTransactionsImplCopyWith<$Res> {
  __$$RefreshTransactionsImplCopyWithImpl(
    _$RefreshTransactionsImpl _value,
    $Res Function(_$RefreshTransactionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RefreshTransactionsImpl implements RefreshTransactions {
  const _$RefreshTransactionsImpl();

  @override
  String toString() {
    return 'TransactionEvent.refresh()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RefreshTransactionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) {
    return refresh();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) {
    return refresh?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) {
    return refresh?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class RefreshTransactions implements TransactionEvent {
  const factory RefreshTransactions() = _$RefreshTransactionsImpl;
}

/// @nodoc
abstract class _$$AddTransactionImplCopyWith<$Res> {
  factory _$$AddTransactionImplCopyWith(
    _$AddTransactionImpl value,
    $Res Function(_$AddTransactionImpl) then,
  ) = __$$AddTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Transaction transaction});
}

/// @nodoc
class __$$AddTransactionImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$AddTransactionImpl>
    implements _$$AddTransactionImplCopyWith<$Res> {
  __$$AddTransactionImplCopyWithImpl(
    _$AddTransactionImpl _value,
    $Res Function(_$AddTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null}) {
    return _then(
      _$AddTransactionImpl(
        null == transaction
            ? _value.transaction
            : transaction // ignore: cast_nullable_to_non_nullable
                  as Transaction,
      ),
    );
  }
}

/// @nodoc

class _$AddTransactionImpl implements AddTransaction {
  const _$AddTransactionImpl(this.transaction);

  @override
  final Transaction transaction;

  @override
  String toString() {
    return 'TransactionEvent.addTransaction(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTransactionImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTransactionImplCopyWith<_$AddTransactionImpl> get copyWith =>
      __$$AddTransactionImplCopyWithImpl<_$AddTransactionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) {
    return addTransaction(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) {
    return addTransaction?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) {
    if (addTransaction != null) {
      return addTransaction(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) {
    return addTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) {
    return addTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) {
    if (addTransaction != null) {
      return addTransaction(this);
    }
    return orElse();
  }
}

abstract class AddTransaction implements TransactionEvent {
  const factory AddTransaction(final Transaction transaction) =
      _$AddTransactionImpl;

  Transaction get transaction;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTransactionImplCopyWith<_$AddTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTransactionImplCopyWith<$Res> {
  factory _$$UpdateTransactionImplCopyWith(
    _$UpdateTransactionImpl value,
    $Res Function(_$UpdateTransactionImpl) then,
  ) = __$$UpdateTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Transaction transaction});
}

/// @nodoc
class __$$UpdateTransactionImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$UpdateTransactionImpl>
    implements _$$UpdateTransactionImplCopyWith<$Res> {
  __$$UpdateTransactionImplCopyWithImpl(
    _$UpdateTransactionImpl _value,
    $Res Function(_$UpdateTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transaction = null}) {
    return _then(
      _$UpdateTransactionImpl(
        null == transaction
            ? _value.transaction
            : transaction // ignore: cast_nullable_to_non_nullable
                  as Transaction,
      ),
    );
  }
}

/// @nodoc

class _$UpdateTransactionImpl implements UpdateTransaction {
  const _$UpdateTransactionImpl(this.transaction);

  @override
  final Transaction transaction;

  @override
  String toString() {
    return 'TransactionEvent.updateTransaction(transaction: $transaction)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTransactionImpl &&
            (identical(other.transaction, transaction) ||
                other.transaction == transaction));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transaction);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTransactionImplCopyWith<_$UpdateTransactionImpl> get copyWith =>
      __$$UpdateTransactionImplCopyWithImpl<_$UpdateTransactionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) {
    return updateTransaction(transaction);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) {
    return updateTransaction?.call(transaction);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) {
    if (updateTransaction != null) {
      return updateTransaction(transaction);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) {
    return updateTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) {
    return updateTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) {
    if (updateTransaction != null) {
      return updateTransaction(this);
    }
    return orElse();
  }
}

abstract class UpdateTransaction implements TransactionEvent {
  const factory UpdateTransaction(final Transaction transaction) =
      _$UpdateTransactionImpl;

  Transaction get transaction;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTransactionImplCopyWith<_$UpdateTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTransactionImplCopyWith<$Res> {
  factory _$$DeleteTransactionImplCopyWith(
    _$DeleteTransactionImpl value,
    $Res Function(_$DeleteTransactionImpl) then,
  ) = __$$DeleteTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteTransactionImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$DeleteTransactionImpl>
    implements _$$DeleteTransactionImplCopyWith<$Res> {
  __$$DeleteTransactionImplCopyWithImpl(
    _$DeleteTransactionImpl _value,
    $Res Function(_$DeleteTransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$DeleteTransactionImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteTransactionImpl implements DeleteTransaction {
  const _$DeleteTransactionImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'TransactionEvent.deleteTransaction(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTransactionImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTransactionImplCopyWith<_$DeleteTransactionImpl> get copyWith =>
      __$$DeleteTransactionImplCopyWithImpl<_$DeleteTransactionImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) {
    return deleteTransaction(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) {
    return deleteTransaction?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) {
    if (deleteTransaction != null) {
      return deleteTransaction(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) {
    return deleteTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) {
    return deleteTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) {
    if (deleteTransaction != null) {
      return deleteTransaction(this);
    }
    return orElse();
  }
}

abstract class DeleteTransaction implements TransactionEvent {
  const factory DeleteTransaction(final String id) = _$DeleteTransactionImpl;

  String get id;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteTransactionImplCopyWith<_$DeleteTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterByDateRangeImplCopyWith<$Res> {
  factory _$$FilterByDateRangeImplCopyWith(
    _$FilterByDateRangeImpl value,
    $Res Function(_$FilterByDateRangeImpl) then,
  ) = __$$FilterByDateRangeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime? startDate, DateTime? endDate});
}

/// @nodoc
class __$$FilterByDateRangeImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$FilterByDateRangeImpl>
    implements _$$FilterByDateRangeImplCopyWith<$Res> {
  __$$FilterByDateRangeImplCopyWithImpl(
    _$FilterByDateRangeImpl _value,
    $Res Function(_$FilterByDateRangeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? startDate = freezed, Object? endDate = freezed}) {
    return _then(
      _$FilterByDateRangeImpl(
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

class _$FilterByDateRangeImpl implements FilterByDateRange {
  const _$FilterByDateRangeImpl({
    required this.startDate,
    required this.endDate,
  });

  @override
  final DateTime? startDate;
  @override
  final DateTime? endDate;

  @override
  String toString() {
    return 'TransactionEvent.filterByDateRange(startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterByDateRangeImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @override
  int get hashCode => Object.hash(runtimeType, startDate, endDate);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterByDateRangeImplCopyWith<_$FilterByDateRangeImpl> get copyWith =>
      __$$FilterByDateRangeImplCopyWithImpl<_$FilterByDateRangeImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) {
    return filterByDateRange(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) {
    return filterByDateRange?.call(startDate, endDate);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) {
    if (filterByDateRange != null) {
      return filterByDateRange(startDate, endDate);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) {
    return filterByDateRange(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) {
    return filterByDateRange?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) {
    if (filterByDateRange != null) {
      return filterByDateRange(this);
    }
    return orElse();
  }
}

abstract class FilterByDateRange implements TransactionEvent {
  const factory FilterByDateRange({
    required final DateTime? startDate,
    required final DateTime? endDate,
  }) = _$FilterByDateRangeImpl;

  DateTime? get startDate;
  DateTime? get endDate;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterByDateRangeImplCopyWith<_$FilterByDateRangeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterByTypeImplCopyWith<$Res> {
  factory _$$FilterByTypeImplCopyWith(
    _$FilterByTypeImpl value,
    $Res Function(_$FilterByTypeImpl) then,
  ) = __$$FilterByTypeImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? type});
}

/// @nodoc
class __$$FilterByTypeImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$FilterByTypeImpl>
    implements _$$FilterByTypeImplCopyWith<$Res> {
  __$$FilterByTypeImplCopyWithImpl(
    _$FilterByTypeImpl _value,
    $Res Function(_$FilterByTypeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = freezed}) {
    return _then(
      _$FilterByTypeImpl(
        freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FilterByTypeImpl implements FilterByType {
  const _$FilterByTypeImpl(this.type);

  @override
  final String? type;

  @override
  String toString() {
    return 'TransactionEvent.filterByType(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterByTypeImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, type);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterByTypeImplCopyWith<_$FilterByTypeImpl> get copyWith =>
      __$$FilterByTypeImplCopyWithImpl<_$FilterByTypeImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) {
    return filterByType(type);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) {
    return filterByType?.call(type);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) {
    if (filterByType != null) {
      return filterByType(type);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) {
    return filterByType(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) {
    return filterByType?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) {
    if (filterByType != null) {
      return filterByType(this);
    }
    return orElse();
  }
}

abstract class FilterByType implements TransactionEvent {
  const factory FilterByType(final String? type) = _$FilterByTypeImpl;

  String? get type;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterByTypeImplCopyWith<_$FilterByTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FilterByCategoryImplCopyWith<$Res> {
  factory _$$FilterByCategoryImplCopyWith(
    _$FilterByCategoryImpl value,
    $Res Function(_$FilterByCategoryImpl) then,
  ) = __$$FilterByCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? category});
}

/// @nodoc
class __$$FilterByCategoryImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$FilterByCategoryImpl>
    implements _$$FilterByCategoryImplCopyWith<$Res> {
  __$$FilterByCategoryImplCopyWithImpl(
    _$FilterByCategoryImpl _value,
    $Res Function(_$FilterByCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? category = freezed}) {
    return _then(
      _$FilterByCategoryImpl(
        freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$FilterByCategoryImpl implements FilterByCategory {
  const _$FilterByCategoryImpl(this.category);

  @override
  final String? category;

  @override
  String toString() {
    return 'TransactionEvent.filterByCategory(category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FilterByCategoryImpl &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @override
  int get hashCode => Object.hash(runtimeType, category);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FilterByCategoryImplCopyWith<_$FilterByCategoryImpl> get copyWith =>
      __$$FilterByCategoryImplCopyWithImpl<_$FilterByCategoryImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) {
    return filterByCategory(category);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) {
    return filterByCategory?.call(category);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) {
    if (filterByCategory != null) {
      return filterByCategory(category);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) {
    return filterByCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) {
    return filterByCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) {
    if (filterByCategory != null) {
      return filterByCategory(this);
    }
    return orElse();
  }
}

abstract class FilterByCategory implements TransactionEvent {
  const factory FilterByCategory(final String? category) =
      _$FilterByCategoryImpl;

  String? get category;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FilterByCategoryImplCopyWith<_$FilterByCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SearchTransactionsImplCopyWith<$Res> {
  factory _$$SearchTransactionsImplCopyWith(
    _$SearchTransactionsImpl value,
    $Res Function(_$SearchTransactionsImpl) then,
  ) = __$$SearchTransactionsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$$SearchTransactionsImplCopyWithImpl<$Res>
    extends _$TransactionEventCopyWithImpl<$Res, _$SearchTransactionsImpl>
    implements _$$SearchTransactionsImplCopyWith<$Res> {
  __$$SearchTransactionsImplCopyWithImpl(
    _$SearchTransactionsImpl _value,
    $Res Function(_$SearchTransactionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? query = null}) {
    return _then(
      _$SearchTransactionsImpl(
        null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SearchTransactionsImpl implements SearchTransactions {
  const _$SearchTransactionsImpl(this.query);

  @override
  final String query;

  @override
  String toString() {
    return 'TransactionEvent.search(query: $query)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchTransactionsImpl &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchTransactionsImplCopyWith<_$SearchTransactionsImpl> get copyWith =>
      __$$SearchTransactionsImplCopyWithImpl<_$SearchTransactionsImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadTransactions,
    required TResult Function() loadMore,
    required TResult Function() refresh,
    required TResult Function(Transaction transaction) addTransaction,
    required TResult Function(Transaction transaction) updateTransaction,
    required TResult Function(String id) deleteTransaction,
    required TResult Function(DateTime? startDate, DateTime? endDate)
    filterByDateRange,
    required TResult Function(String? type) filterByType,
    required TResult Function(String? category) filterByCategory,
    required TResult Function(String query) search,
  }) {
    return search(query);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadTransactions,
    TResult? Function()? loadMore,
    TResult? Function()? refresh,
    TResult? Function(Transaction transaction)? addTransaction,
    TResult? Function(Transaction transaction)? updateTransaction,
    TResult? Function(String id)? deleteTransaction,
    TResult? Function(DateTime? startDate, DateTime? endDate)?
    filterByDateRange,
    TResult? Function(String? type)? filterByType,
    TResult? Function(String? category)? filterByCategory,
    TResult? Function(String query)? search,
  }) {
    return search?.call(query);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadTransactions,
    TResult Function()? loadMore,
    TResult Function()? refresh,
    TResult Function(Transaction transaction)? addTransaction,
    TResult Function(Transaction transaction)? updateTransaction,
    TResult Function(String id)? deleteTransaction,
    TResult Function(DateTime? startDate, DateTime? endDate)? filterByDateRange,
    TResult Function(String? type)? filterByType,
    TResult Function(String? category)? filterByCategory,
    TResult Function(String query)? search,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(query);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadTransactions value) loadTransactions,
    required TResult Function(LoadMore value) loadMore,
    required TResult Function(RefreshTransactions value) refresh,
    required TResult Function(AddTransaction value) addTransaction,
    required TResult Function(UpdateTransaction value) updateTransaction,
    required TResult Function(DeleteTransaction value) deleteTransaction,
    required TResult Function(FilterByDateRange value) filterByDateRange,
    required TResult Function(FilterByType value) filterByType,
    required TResult Function(FilterByCategory value) filterByCategory,
    required TResult Function(SearchTransactions value) search,
  }) {
    return search(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadTransactions value)? loadTransactions,
    TResult? Function(LoadMore value)? loadMore,
    TResult? Function(RefreshTransactions value)? refresh,
    TResult? Function(AddTransaction value)? addTransaction,
    TResult? Function(UpdateTransaction value)? updateTransaction,
    TResult? Function(DeleteTransaction value)? deleteTransaction,
    TResult? Function(FilterByDateRange value)? filterByDateRange,
    TResult? Function(FilterByType value)? filterByType,
    TResult? Function(FilterByCategory value)? filterByCategory,
    TResult? Function(SearchTransactions value)? search,
  }) {
    return search?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadTransactions value)? loadTransactions,
    TResult Function(LoadMore value)? loadMore,
    TResult Function(RefreshTransactions value)? refresh,
    TResult Function(AddTransaction value)? addTransaction,
    TResult Function(UpdateTransaction value)? updateTransaction,
    TResult Function(DeleteTransaction value)? deleteTransaction,
    TResult Function(FilterByDateRange value)? filterByDateRange,
    TResult Function(FilterByType value)? filterByType,
    TResult Function(FilterByCategory value)? filterByCategory,
    TResult Function(SearchTransactions value)? search,
    required TResult orElse(),
  }) {
    if (search != null) {
      return search(this);
    }
    return orElse();
  }
}

abstract class SearchTransactions implements TransactionEvent {
  const factory SearchTransactions(final String query) =
      _$SearchTransactionsImpl;

  String get query;

  /// Create a copy of TransactionEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchTransactionsImplCopyWith<_$SearchTransactionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
