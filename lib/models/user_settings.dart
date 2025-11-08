class UserSettings {
  final String aiProvider;
  final String? apiKey;
  final String serverUrl;
  final String themeMode;
  final String language;
  final bool dailyNotification;
  final bool budgetAlert;
  final bool weeklySummary;
  
  UserSettings({
    required this.aiProvider,
    this.apiKey,
    required this.serverUrl,
    required this.themeMode,
    required this.language,
    required this.dailyNotification,
    required this.budgetAlert,
    required this.weeklySummary,
  });
  
  UserSettings copyWith({
    String? aiProvider,
    String? apiKey,
    String? serverUrl,
    String? themeMode,
    String? language,
    bool? dailyNotification,
    bool? budgetAlert,
    bool? weeklySummary,
  }) {
    return UserSettings(
      aiProvider: aiProvider ?? this.aiProvider,
      apiKey: apiKey ?? this.apiKey,
      serverUrl: serverUrl ?? this.serverUrl,
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      dailyNotification: dailyNotification ?? this.dailyNotification,
      budgetAlert: budgetAlert ?? this.budgetAlert,
      weeklySummary: weeklySummary ?? this.weeklySummary,
    );
  }
}

