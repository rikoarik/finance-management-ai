import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/budget.dart';
import '../../services/budget_service.dart';
import '../../services/database_service.dart';
import '../../utils/constants.dart';
import 'budget_event.dart';
import 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetService _budgetService;
  final DatabaseService _databaseService;
  final FirebaseAuth _firebaseAuth;
  StreamSubscription? _budgetSubscription;
  StreamSubscription? _transactionSubscription;
  DateTime? _lastUpdateTime;
  static const Duration _debounceDuration = Duration(seconds: 2);

  BudgetBloc({
    BudgetService? budgetService,
    DatabaseService? databaseService,
    FirebaseAuth? firebaseAuth,
  })  : _budgetService = budgetService ?? BudgetService(),
        _databaseService = databaseService ?? DatabaseService(),
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        super(const BudgetState.initial()) {
    on<LoadBudget>(_onLoadBudget);
    on<SaveBudget>(_onSaveBudget);
    on<UpdateBudget>(_onUpdateBudget);
    on<DeleteBudget>(_onDeleteBudget);
    on<CheckBudgetAlerts>(_onCheckAlerts);
    on<AutoUpdateBudget>(_onAutoUpdateBudget);
    on<AutoAdjustBudget>(_onAutoAdjustBudget);
  }

  Future<void> _onLoadBudget(LoadBudget event, Emitter<BudgetState> emit) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      emit(const BudgetState.error('User not authenticated'));
      return;
    }

    emit(const BudgetState.loading());

    try {
      // Cancel previous subscriptions
      await _budgetSubscription?.cancel();
      await _transactionSubscription?.cancel();

      // Load budget with calculated spending (real-time listener with debouncing)
      _transactionSubscription = _databaseService.getTransactions(user.uid).listen(
        (transactions) async {
          // Debounce check
          final now = DateTime.now();
          if (_lastUpdateTime != null && 
              now.difference(_lastUpdateTime!) < _debounceDuration) {
            return;
          }
          _lastUpdateTime = now;

          final budget = await _budgetService.getBudgetWithCalculatedSpending(
            user.uid,
            transactions,
          );
          
          if (budget != null) {
            final alerts = _calculateAlerts(budget);
            emit(BudgetState.loaded(budget: budget, alerts: alerts));
          } else {
            emit(const BudgetState.loaded(budget: null, alerts: []));
          }
        },
      );
    } catch (e) {
      emit(BudgetState.error(e.toString()));
    }
  }

  Future<void> _onSaveBudget(SaveBudget event, Emitter<BudgetState> emit) async {
    try {
      await _budgetService.saveBudget(event.budget);
      add(const LoadBudget());
    } catch (e) {
      emit(BudgetState.error(e.toString()));
    }
  }

  Future<void> _onUpdateBudget(UpdateBudget event, Emitter<BudgetState> emit) async {
    try {
      await _budgetService.updateBudget(event.budget);
      add(const LoadBudget());
    } catch (e) {
      emit(BudgetState.error(e.toString()));
    }
  }

  Future<void> _onDeleteBudget(DeleteBudget event, Emitter<BudgetState> emit) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    try {
      await _budgetService.deleteBudget(user.uid);
      emit(const BudgetState.loaded(budget: null, alerts: []));
    } catch (e) {
      emit(BudgetState.error(e.toString()));
    }
  }

  Future<void> _onCheckAlerts(CheckBudgetAlerts event, Emitter<BudgetState> emit) async {
    if (state is BudgetLoaded) {
      final currentState = state as BudgetLoaded;
      if (currentState.budget != null) {
        final alerts = _calculateAlerts(currentState.budget!);
        emit(currentState.copyWith(alerts: alerts));
      }
    }
  }

  Future<void> _onAutoUpdateBudget(
    AutoUpdateBudget event,
    Emitter<BudgetState> emit,
  ) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return;

    // Debounce check
    final now = DateTime.now();
    if (_lastUpdateTime != null && 
        now.difference(_lastUpdateTime!) < _debounceDuration) {
      return;
    }
    _lastUpdateTime = now;

    try {
      // Get current transactions
      final transactionsStream = _databaseService.getTransactions(user.uid);
      final transactions = await transactionsStream.first;
      
      // Auto-update budget
      final updatedBudget = await _budgetService.autoUpdateBudgetFromTransactions(
        user.uid,
        transactions,
      );

      if (updatedBudget != null) {
        final alerts = _calculateAlerts(updatedBudget);
        emit(BudgetState.loaded(budget: updatedBudget, alerts: alerts));
      }
    } catch (e) {
      // Silent fail untuk auto-update (don't emit error state)
      print('Auto-update budget error: $e');
    }
  }

  Future<void> _onAutoAdjustBudget(
    AutoAdjustBudget event,
    Emitter<BudgetState> emit,
  ) async {
    // TODO: Implement auto-adjustment logic
    // This will be handled by BudgetAdjustmentService
    // For now, just trigger auto-update
    add(const BudgetEvent.autoUpdateBudget());
  }

  List<String> _calculateAlerts(Budget budget) {
    final alerts = <String>[];

    for (final category in budget.categories) {
      if (category.allocatedAmount <= 0) continue;
      
      final percentage = category.spentAmount / category.allocatedAmount;
      
      if (percentage >= AppConstants.budgetDangerThreshold) {
        alerts.add(
          '${category.name}: ${(percentage * 100).toStringAsFixed(0)}% terpakai (Bahaya!)',
        );
      } else if (percentage >= AppConstants.budgetWarningThreshold) {
        alerts.add(
          '${category.name}: ${(percentage * 100).toStringAsFixed(0)}% terpakai (Peringatan)',
        );
      }
    }

    return alerts;
  }

  @override
  Future<void> close() {
    _budgetSubscription?.cancel();
    _transactionSubscription?.cancel();
    return super.close();
  }
}

