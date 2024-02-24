// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBdwW1BEptKrUBBKGeDwt601Ie7oUA_Eqs',
    appId: '1:766826318733:web:5c3b331a55a1afc9ec8bc4',
    messagingSenderId: '766826318733',
    projectId: 'reddit-clone-f62df',
    authDomain: 'reddit-clone-f62df.firebaseapp.com',
    storageBucket: 'reddit-clone-f62df.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmWRLmUhFvF4BMfUhB_8Sd_2COU9w_3Gg',
    appId: '1:766826318733:android:d307dea90cd1aa13ec8bc4',
    messagingSenderId: '766826318733',
    projectId: 'reddit-clone-f62df',
    storageBucket: 'reddit-clone-f62df.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDfDbMadqzuYDbf4NHAPTgU2xwh15KXQPQ',
    appId: '1:766826318733:ios:090da979fa8d8cf9ec8bc4',
    messagingSenderId: '766826318733',
    projectId: 'reddit-clone-f62df',
    storageBucket: 'reddit-clone-f62df.appspot.com',
    iosBundleId: 'com.example.redditClone',
  );
}
