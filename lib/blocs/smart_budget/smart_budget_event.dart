import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/budget.dart';

part 'smart_budget_event.freezed.dart';

@freezed
class SmartBudgetEvent with _$SmartBudgetEvent {
  const factory SmartBudgetEvent.generateSmartBudget(double monthlyIncome) = GenerateSmartBudget;
  const factory SmartBudgetEvent.applySmartBudget(Budget budget) = ApplySmartBudget;
  const factory SmartBudgetEvent.recalculateBudget(double newIncome) = RecalculateBudget;
}

