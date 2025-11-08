import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/transaction.dart';

part 'transaction_event.freezed.dart';

@freezed
class TransactionEvent with _$TransactionEvent {
  const factory TransactionEvent.loadTransactions() = LoadTransactions;
  const factory TransactionEvent.loadMore() = LoadMore;
  const factory TransactionEvent.refresh() = RefreshTransactions;
  const factory TransactionEvent.addTransaction(Transaction transaction) = AddTransaction;
  const factory TransactionEvent.updateTransaction(Transaction transaction) = UpdateTransaction;
  const factory TransactionEvent.deleteTransaction(String id) = DeleteTransaction;
  const factory TransactionEvent.filterByDateRange({
    required DateTime? startDate,
    required DateTime? endDate,
  }) = FilterByDateRange;
  const factory TransactionEvent.filterByType(String? type) = FilterByType;
  const factory TransactionEvent.filterByCategory(String? category) = FilterByCategory;
  const factory TransactionEvent.search(String query) = SearchTransactions;
}

