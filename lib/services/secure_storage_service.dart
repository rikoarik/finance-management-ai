import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class SecureStorageService {
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  // Secure Storage (for sensitive data like API keys)
  
  /// Save API key securely
  Future<void> saveApiKey(String apiKey) async {
    await _secureStorage.write(key: AppConstants.keyApiKey, value: apiKey);
  }

  /// Get API key
  Future<String?> getApiKey() async {
    return await _secureStorage.read(key: AppConstants.keyApiKey);
  }

  /// Delete API key
  Future<void> deleteApiKey() async {
    await _secureStorage.delete(key: AppConstants.keyApiKey);
  }

  /// Check if API key exists
  Future<bool> hasApiKey() async {
    final apiKey = await getApiKey();
    return apiKey != null && apiKey.isNotEmpty;
  }

  // Regular Storage (for non-sensitive data)

  /// Save theme mode
  Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyThemeMode, mode);
  }

  /// Get theme mode
  Future<String> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.keyThemeMode) ?? 'system';
  }

  /// Save language
  Future<void> saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyLanguage, language);
  }

  /// Get language
  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.keyLanguage) ?? 'id';
  }

  /// Check if first time
  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.keyFirstTime) ?? true;
  }

  /// Set not first time
  Future<void> setNotFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyFirstTime, false);
  }

  /// Save notification settings
  Future<void> saveDailyNotification(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyDailyNotification, enabled);
  }

  Future<bool> getDailyNotification() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.keyDailyNotification) ?? true;
  }

  Future<void> saveBudgetAlert(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyBudgetAlert, enabled);
  }

  Future<bool> getBudgetAlert() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.keyBudgetAlert) ?? true;
  }

  Future<void> saveWeeklySummary(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyWeeklySummary, enabled);
  }

  Future<bool> getWeeklySummary() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.keyWeeklySummary) ?? true;
  }

  /// Save device ID (optional, for local backup)
  Future<void> saveDeviceId(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.keyDeviceId, deviceId);
  }

  /// Get device ID
  Future<String?> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.keyDeviceId);
  }

  /// Check if device ID exists
  Future<bool> hasDeviceId() async {
    final deviceId = await getDeviceId();
    return deviceId != null && deviceId.isNotEmpty;
  }

  /// Check if trial welcome dialog has been shown for user
  Future<bool> hasTrialWelcomeShown(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('${AppConstants.keyTrialWelcomeShown}_$userId') ?? false;
  }

  /// Set that trial welcome dialog has been shown for user
  Future<void> setTrialWelcomeShown(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${AppConstants.keyTrialWelcomeShown}_$userId', true);
  }

  /// Clear all data
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

