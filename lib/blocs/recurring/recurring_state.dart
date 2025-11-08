import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/recurring_transaction.dart';

part 'recurring_state.freezed.dart';

@freezed
class RecurringState with _$RecurringState {
  const factory RecurringState.initial() = RecurringInitial;
  const factory RecurringState.loading() = RecurringLoading;
  const factory RecurringState.loaded({
    required List<RecurringTransaction> recurringTransactions,
  }) = RecurringLoaded;
  const factory RecurringState.processing() = RecurringProcessing;
  const factory RecurringState.processed(int count) = RecurringProcessed;
  const factory RecurringState.error(String message) = RecurringError;
}

