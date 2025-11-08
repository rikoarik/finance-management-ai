import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/budget.dart';

part 'budget_event.freezed.dart';

@freezed
class BudgetEvent with _$BudgetEvent {
  const factory BudgetEvent.loadBudget() = LoadBudget;
  const factory BudgetEvent.saveBudget(Budget budget) = SaveBudget;
  const factory BudgetEvent.updateBudget(Budget budget) = UpdateBudget;
  const factory BudgetEvent.deleteBudget() = DeleteBudget;
  const factory BudgetEvent.checkAlerts() = CheckBudgetAlerts;
  const factory BudgetEvent.autoUpdateBudget() = AutoUpdateBudget;
  const factory BudgetEvent.autoAdjustBudget() = AutoAdjustBudget;
}

