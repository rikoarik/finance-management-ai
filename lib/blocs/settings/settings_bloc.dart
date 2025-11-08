import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../services/secure_storage_service.dart';
import 'settings_event.dart';
import 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  final SecureStorageService _storage;

  SettingsBloc({SecureStorageService? storage})
      : _storage = storage ?? SecureStorageService(),
        super(const SettingsState()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateLanguage>(_onUpdateLanguage);
    on<UpdateDailyNotification>(_onUpdateDailyNotification);
    on<UpdateBudgetAlert>(_onUpdateBudgetAlert);
    on<UpdateWeeklySummary>(_onUpdateWeeklySummary);
  }

  Future<void> _onLoadSettings(
    LoadSettings event,
    Emitter<SettingsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    
    try {
      final language = await _storage.getLanguage();
      final dailyNotification = await _storage.getDailyNotification();
      final budgetAlert = await _storage.getBudgetAlert();
      final weeklySummary = await _storage.getWeeklySummary();

      emit(state.copyWith(
        language: language,
        dailyNotification: dailyNotification,
        budgetAlert: budgetAlert,
        weeklySummary: weeklySummary,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onUpdateLanguage(
    UpdateLanguage event,
    Emitter<SettingsState> emit,
  ) async {
    await _storage.saveLanguage(event.language);
    emit(state.copyWith(language: event.language));
  }

  Future<void> _onUpdateDailyNotification(
    UpdateDailyNotification event,
    Emitter<SettingsState> emit,
  ) async {
    await _storage.saveDailyNotification(event.enabled);
    emit(state.copyWith(dailyNotification: event.enabled));
  }

  Future<void> _onUpdateBudgetAlert(
    UpdateBudgetAlert event,
    Emitter<SettingsState> emit,
  ) async {
    await _storage.saveBudgetAlert(event.enabled);
    emit(state.copyWith(budgetAlert: event.enabled));
  }

  Future<void> _onUpdateWeeklySummary(
    UpdateWeeklySummary event,
    Emitter<SettingsState> emit,
  ) async {
    await _storage.saveWeeklySummary(event.enabled);
    emit(state.copyWith(weeklySummary: event.enabled));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    try {
      return SettingsState.fromJson(json);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    try {
      return state.toJson();
    } catch (_) {
      return null;
    }
  }
}

