import 'package:freezed_annotation/freezed_annotation.dart';
import '../../models/recurring_transaction.dart';

part 'recurring_event.freezed.dart';

@freezed
class RecurringEvent with _$RecurringEvent {
  const factory RecurringEvent.loadRecurring() = LoadRecurring;
  const factory RecurringEvent.addRecurring(RecurringTransaction recurring) = AddRecurring;
  const factory RecurringEvent.updateRecurring(RecurringTransaction recurring) = UpdateRecurring;
  const factory RecurringEvent.deleteRecurring(String id) = DeleteRecurring;
  const factory RecurringEvent.toggleActive(String id, bool isActive) = ToggleActive;
  const factory RecurringEvent.processRecurring() = ProcessRecurring;
}

