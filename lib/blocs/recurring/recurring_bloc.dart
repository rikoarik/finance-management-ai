import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/recurring_transaction.dart';
import '../../services/recurring_transaction_service.dart';
import 'recurring_event.dart';
import 'recurring_state.dart';

class RecurringBloc extends Bloc<RecurringEvent, RecurringState> {
  final RecurringTransactionService _recurringService;
  StreamSubscription<List<RecurringTransaction>>? _recurringSubscription;

  RecurringBloc({RecurringTransactionService? recurringService})
      : _recurringService = recurringService ?? RecurringTransactionService(),
        super(const RecurringState.initial()) {
    on<LoadRecurring>(_onLoadRecurring);
    on<AddRecurring>(_onAddRecurring);
    on<UpdateRecurring>(_onUpdateRecurring);
    on<DeleteRecurring>(_onDeleteRecurring);
    on<ToggleActive>(_onToggleActive);
    on<ProcessRecurring>(_onProcessRecurring);
  }

  Future<void> _onLoadRecurring(
    LoadRecurring event,
    Emitter<RecurringState> emit,
  ) async {
    emit(const RecurringState.loading());

    try {
      await _recurringSubscription?.cancel();

      _recurringSubscription = _recurringService.getRecurringTransactions().listen(
        (recurring) {
          emit(RecurringState.loaded(recurringTransactions: recurring));
        },
        onError: (error) {
          emit(RecurringState.error(error.toString()));
        },
      );
    } catch (e) {
      emit(RecurringState.error(e.toString()));
    }
  }

  Future<void> _onAddRecurring(
    AddRecurring event,
    Emitter<RecurringState> emit,
  ) async {
    try {
      await _recurringService.addRecurringTransaction(event.recurring);
    } catch (e) {
      emit(RecurringState.error(e.toString()));
    }
  }

  Future<void> _onUpdateRecurring(
    UpdateRecurring event,
    Emitter<RecurringState> emit,
  ) async {
    try {
      await _recurringService.updateRecurringTransaction(event.recurring);
    } catch (e) {
      emit(RecurringState.error(e.toString()));
    }
  }

  Future<void> _onDeleteRecurring(
    DeleteRecurring event,
    Emitter<RecurringState> emit,
  ) async {
    try {
      await _recurringService.deleteRecurringTransaction(event.id);
    } catch (e) {
      emit(RecurringState.error(e.toString()));
    }
  }

  Future<void> _onToggleActive(
    ToggleActive event,
    Emitter<RecurringState> emit,
  ) async {
    try {
      await _recurringService.toggleActive(event.id, event.isActive);
    } catch (e) {
      emit(RecurringState.error(e.toString()));
    }
  }

  Future<void> _onProcessRecurring(
    ProcessRecurring event,
    Emitter<RecurringState> emit,
  ) async {
    emit(const RecurringState.processing());

    try {
      final count = await _recurringService.processRecurringTransactions();
      emit(RecurringState.processed(count));
      add(const LoadRecurring());
    } catch (e) {
      emit(RecurringState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _recurringSubscription?.cancel();
    return super.close();
  }
}

