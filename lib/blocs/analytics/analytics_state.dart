import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/transaction.dart';
import 'analytics_event.dart';

part 'analytics_state.freezed.dart';

@freezed
class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState.initial() = AnalyticsInitial;
  const factory AnalyticsState.loading() = AnalyticsLoading;
  const factory AnalyticsState.loaded({
    required Map<String, double> expenseByCategory,
    required Map<String, double> incomeByCategory,
    required double totalIncome,
    required double totalExpense,
    required double balance,
    required List<Transaction> transactions,
    @Default(TimeRange.month) TimeRange timeRange,
    DateTime? startDate,
    DateTime? endDate,
  }) = AnalyticsLoaded;
  const factory AnalyticsState.error(String message) = AnalyticsError;
}

