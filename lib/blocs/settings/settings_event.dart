import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_event.freezed.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.loadSettings() = LoadSettings;
  const factory SettingsEvent.updateAiProvider(String provider) = UpdateAiProvider;
  const factory SettingsEvent.updateApiKey(String apiKey) = UpdateApiKey;
  const factory SettingsEvent.updateServerUrl(String url) = UpdateServerUrl;
  const factory SettingsEvent.updateLanguage(String language) = UpdateLanguage;
  const factory SettingsEvent.updateDailyNotification(bool enabled) = UpdateDailyNotification;
  const factory SettingsEvent.updateBudgetAlert(bool enabled) = UpdateBudgetAlert;
  const factory SettingsEvent.updateWeeklySummary(bool enabled) = UpdateWeeklySummary;
}

