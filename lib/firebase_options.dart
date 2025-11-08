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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzVdERI',
    appId: '1:1234567890:web:0a9ef0cdfabef0ab1abcdef',
    messagingSenderId: '123456789',
    projectId: 'flutterfinance',
    authDomain: 'flutterfinance.firebaseapp.com',
    storageBucket: 'flutterfinance.appspot.com',
    measurementId: 'G-XXXXXXXXXX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmu4UlGtQGfThO0H-Uqh1E2Lg6ORy3k80',
    appId: '1:681248130575:android:2df56a91862acb0de8457a',
    messagingSenderId: '681248130575',
    projectId: 'finance-chat-e9d61',
    storageBucket: 'finance-chat-e9d61.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzVdERI',
    appId: '1:1234567890:ios:0a9ef0cdfabef0ab1abcdef',
    messagingSenderId: '123456789',
    projectId: 'flutterfinance',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgUhHU8wSJgO5MVNy95tMT07NEjzVdERI',
    appId: '1:1234567890:macos:0a9ef0cdfabef0ab1abcdef',
    messagingSenderId: '123456789',
    projectId: 'flutterfinance',
  );
}
