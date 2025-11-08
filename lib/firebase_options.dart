import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static final FirebaseOptions web = FirebaseOptions(
    apiKey: _EnvConfig.webApiKey,
    appId: '1:1234567890:web:0a9ef0cdfabef0ab1abcdef',
    messagingSenderId: '123456789',
    projectId: 'flutterfinance',
    authDomain: 'flutterfinance.firebaseapp.com',
    storageBucket: 'flutterfinance.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: _EnvConfig.androidApiKey,
    appId: '1:681248130575:android:2df56a91862acb0de8457a',
    messagingSenderId: '681248130575',
    projectId: 'finance-chat-e9d61',
    storageBucket: 'finance-chat-e9d61.firebasestorage.app',
  );

  static final FirebaseOptions ios = FirebaseOptions(
    apiKey: _EnvConfig.iosApiKey,
    appId: '1:1234567890:ios:0a9ef0cdfabef0ab1abcdef',
    messagingSenderId: '123456789',
    projectId: 'flutterfinance',
  );

  static final FirebaseOptions macos = FirebaseOptions(
    apiKey: _EnvConfig.macosApiKey,
    appId: '1:1234567890:macos:0a9ef0cdfabef0ab1abcdef',
    messagingSenderId: '123456789',
    projectId: 'flutterfinance',
  );
}

class _EnvConfig {
  static const String _webApiKey =
      String.fromEnvironment('FIREBASE_WEB_API_KEY');
  static const String _androidApiKey =
      String.fromEnvironment('FIREBASE_ANDROID_API_KEY');
  static const String _iosApiKey =
      String.fromEnvironment('FIREBASE_IOS_API_KEY');
  static const String _macosApiKey =
      String.fromEnvironment('FIREBASE_MACOS_API_KEY');

  static String get webApiKey =>
      _require(_webApiKey, 'FIREBASE_WEB_API_KEY');
  static String get androidApiKey =>
      _require(_androidApiKey, 'FIREBASE_ANDROID_API_KEY');
  static String get iosApiKey =>
      _require(_iosApiKey, 'FIREBASE_IOS_API_KEY');
  static String get macosApiKey =>
      _require(_macosApiKey, 'FIREBASE_MACOS_API_KEY');

  static String _require(String value, String name) {
    if (value.isEmpty) {
      throw StateError(
        'Environment variable $name belum diset. Tambahkan dengan --dart-define saat build/run.',
      );
    }
    return value;
  }
}
