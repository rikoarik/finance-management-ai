import 'package:firebase_database/firebase_database.dart';
import '../utils/constants.dart';

class FirebaseConfigService {
  static final FirebaseConfigService _instance = FirebaseConfigService._internal();
  factory FirebaseConfigService() => _instance;
  FirebaseConfigService._internal();

  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  String? _cachedApiKey;
  String? _cachedUserId;

  /// Get Gemini API key for a specific user from Firebase Realtime Database
  /// Path: /users/{userId}/gemini_api_key
  /// Falls back to default hardcoded API key if Firebase error or null
  Future<String> getGeminiApiKey(String userId) async {
    // Return cached API key if same user
    if (_cachedApiKey != null && _cachedUserId == userId) {
      return _cachedApiKey!;
    }

    try {
      final snapshot = await _database
          .child('users')
          .child(userId)
          .child('gemini_api_key')
          .get();

      if (snapshot.exists && snapshot.value != null) {
        final apiKey = snapshot.value as String;
        if (apiKey.isNotEmpty) {
          _cachedApiKey = apiKey;
          _cachedUserId = userId;
          return apiKey;
        }
      }
    } catch (e) {
      print('Error fetching API key from Firebase: $e');
      // Fall through to default
    }

    // Fallback to default hardcoded API key
    return AppConstants.defaultGeminiApiKey.isNotEmpty
        ? AppConstants.defaultGeminiApiKey
        : throw Exception('No API key available. Please configure in Firebase or set defaultGeminiApiKey in constants.');
  }

  /// Set Gemini API key for a specific user (for admin use)
  Future<void> setGeminiApiKey(String userId, String apiKey) async {
    try {
      await _database
          .child('users')
          .child(userId)
          .child('gemini_api_key')
          .set(apiKey);
      
      // Update cache
      _cachedApiKey = apiKey;
      _cachedUserId = userId;
    } catch (e) {
      throw Exception('Failed to set API key: $e');
    }
  }

  /// Clear cache (useful when switching users)
  void clearCache() {
    _cachedApiKey = null;
    _cachedUserId = null;
  }
}

