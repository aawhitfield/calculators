// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD60flaZZs5lNOKU0uzCOiJ4uhYwmwHtuo',
    appId: '1:106474774733:web:d959e646aacf8f5c448984',
    messagingSenderId: '106474774733',
    projectId: 'vereifiapp',
    authDomain: 'vereifiapp.firebaseapp.com',
    storageBucket: 'vereifiapp.appspot.com',
    measurementId: 'G-3NKWWKWK35',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnD7JUQ_czAY0YaWTmwVPI-dDJZYkTi3A',
    appId: '1:106474774733:android:fa557a6c2d4a3f69448984',
    messagingSenderId: '106474774733',
    projectId: 'vereifiapp',
    storageBucket: 'vereifiapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUW6-4f42t-09BZuaJlL5NnwBpN-wggYc',
    appId: '1:106474774733:ios:bfc97c8987930c63448984',
    messagingSenderId: '106474774733',
    projectId: 'vereifiapp',
    storageBucket: 'vereifiapp.appspot.com',
    iosClientId: '106474774733-sg964jbasj7jt35rlia82rmpm5ertrj7.apps.googleusercontent.com',
    iosBundleId: 'com.vereifi.calculator',
  );
}
