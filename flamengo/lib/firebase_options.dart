// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
final apiKey = dotenv.get("FIREBASE_API_KEY");

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions web = FirebaseOptions(
    apiKey: apiKey,
    appId: '1:65309275314:web:a320b92a5be80b1a1bc5ab',
    messagingSenderId: '65309275314',
    projectId: 'flamengocarllee',
    authDomain: 'flamengocarllee.firebaseapp.com',
    storageBucket: 'flamengocarllee.appspot.com',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: apiKey,
    appId: '1:65309275314:android:6b52248aa6eafdaa1bc5ab',
    messagingSenderId: '65309275314',
    projectId: 'flamengocarllee',
    storageBucket: 'flamengocarllee.appspot.com',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: apiKey,
    appId: '1:65309275314:ios:dc6ffc3f2d1bf6371bc5ab',
    messagingSenderId: '65309275314',
    projectId: 'flamengocarllee',
    storageBucket: 'flamengocarllee.appspot.com',
    iosClientId:
        '65309275314-tmlfeoo20dsbr85hvmqcov5m31sh1vup.apps.googleusercontent.com',
    iosBundleId: 'com.example.flamengo',
  );
}
