import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_state.freezed.dart';

@freezed
class SettingsState with _$SettingsState {
  const SettingsState._();
  
  const factory SettingsState({
    @Default(false) bool isLoading,
    @Default('id') String language,
    @Default(true) bool dailyNotification,
    @Default(true) bool budgetAlert,
    @Default(true) bool weeklySummary,
  }) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) {
    return SettingsState(
      isLoading: json['isLoading'] as bool? ?? false,
      language: json['language'] as String? ?? 'id',
      dailyNotification: json['dailyNotification'] as bool? ?? true,
      budgetAlert: json['budgetAlert'] as bool? ?? true,
      weeklySummary: json['weeklySummary'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isLoading': isLoading,
      'language': language,
      'dailyNotification': dailyNotification,
      'budgetAlert': budgetAlert,
      'weeklySummary': weeklySummary,
    };
  }
}

