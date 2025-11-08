import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/budget.dart';

part 'budget_state.freezed.dart';

@freezed
class BudgetState with _$BudgetState {
  const factory BudgetState.initial() = BudgetInitial;
  const factory BudgetState.loading() = BudgetLoading;
  const factory BudgetState.loaded({
    required Budget? budget,
    @Default([]) List<String> alerts,
  }) = BudgetLoaded;
  const factory BudgetState.error(String message) = BudgetError;
}

