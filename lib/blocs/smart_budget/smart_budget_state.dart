import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/budget.dart';

part 'smart_budget_state.freezed.dart';

@freezed
class SmartBudgetState with _$SmartBudgetState {
  const factory SmartBudgetState.initial() = SmartBudgetInitial;
  const factory SmartBudgetState.analyzing() = SmartBudgetAnalyzing;
  const factory SmartBudgetState.generating() = SmartBudgetGenerating;
  const factory SmartBudgetState.generated({
    required Budget budget,
    required Map<String, double> breakdown,
    String? analysis,
    List<String>? tips,
  }) = SmartBudgetGenerated;
  const factory SmartBudgetState.tips({
    required String welcomeMessage,
    required List<String> tips,
    required Budget suggestedBudget,
  }) = SmartBudgetTips;
  const factory SmartBudgetState.applying() = SmartBudgetApplying;
  const factory SmartBudgetState.applied() = SmartBudgetApplied;
  const factory SmartBudgetState.error(String message) = SmartBudgetError;
}

