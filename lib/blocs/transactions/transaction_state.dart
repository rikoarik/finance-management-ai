import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/transaction.dart';

part 'transaction_state.freezed.dart';

@freezed
class TransactionState with _$TransactionState {
  const factory TransactionState.initial() = TransactionInitial;
  const factory TransactionState.loading() = TransactionLoading;
  const factory TransactionState.loadingMore() = TransactionLoadingMore;
  const factory TransactionState.loaded({
    required List<Transaction> transactions,
    required List<Transaction> filteredTransactions,
    required bool hasMore,
    required int currentPage,
    DateTime? startDate,
    DateTime? endDate,
    String? typeFilter,
    String? categoryFilter,
    @Default('') String searchQuery,
  }) = TransactionLoaded;
  const factory TransactionState.error(String message) = TransactionError;
}

