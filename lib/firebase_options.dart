import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      case TargetPlatform.windows:
        return windows;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions web = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_API_KEY_WEB'),
    appId: dotenv.get('FIREBASE_APP_ID_WEB'),
    messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('FIREBASE_PROJECT_ID'),
    authDomain: 'your_project.firebaseapp.com',
    storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
    measurementId: 'your_measurement_id_for_web',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_API_KEY_ANDROID'),
    appId: dotenv.get('FIREBASE_APP_ID_ANDROID'),
    messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('FIREBASE_PROJECT_ID'),
    storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_API_KEY_IOS'),
    appId: dotenv.get('FIREBASE_APP_ID_IOS'),
    messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('FIREBASE_PROJECT_ID'),
    storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_API_KEY_IOS'),
    appId: dotenv.get('FIREBASE_APP_ID_IOS'),
    messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('FIREBASE_PROJECT_ID'),
    storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
  );

  static FirebaseOptions windows = FirebaseOptions(
    apiKey: dotenv.get('FIREBASE_API_KEY_WEB'),
    appId: dotenv.get('FIREBASE_APP_ID_WEB'),
    messagingSenderId: dotenv.get('FIREBASE_MESSAGING_SENDER_ID'),
    projectId: dotenv.get('FIREBASE_PROJECT_ID'),
    authDomain: 'your_project.firebaseapp.com',
    storageBucket: dotenv.get('FIREBASE_STORAGE_BUCKET'),
    measurementId: 'your_measurement_id_for_web',
  );
}
