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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD25DrzXsR4flKr6TYaBDBqlaacPntxmr8',
    appId: '1:1090730333265:android:783d205aa85f5eaf8a5470',
    messagingSenderId: '1090730333265',
    projectId: 'omahdilit',
    databaseURL: 'https://omahdilit.firebaseio.com',
    storageBucket: 'omahdilit.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCP6fd_1l1P9z8TvjiiGgZcDcdtpCsjx2g',
    appId: '1:1090730333265:ios:864755d05ea22e848a5470',
    messagingSenderId: '1090730333265',
    projectId: 'omahdilit',
    databaseURL: 'https://omahdilit.firebaseio.com',
    storageBucket: 'omahdilit.appspot.com',
    androidClientId: '1090730333265-0nritdn0ltcf1rngt57fkqavda4bqd59.apps.googleusercontent.com',
    iosClientId: '1090730333265-3fn9ojolg11dov3rikcgdebs7er0mn97.apps.googleusercontent.com',
    iosBundleId: 'com.devert.hairdo',
  );
}
