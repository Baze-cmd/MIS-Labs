// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDoQv11-PWYm12dLYn1li_7EdF100Bb6kA',
    appId: '1:723176115529:web:c0b2a0511d8b0144fc9e98',
    messagingSenderId: '723176115529',
    projectId: 'mis-labs-86f60',
    authDomain: 'mis-labs-86f60.firebaseapp.com',
    storageBucket: 'mis-labs-86f60.firebasestorage.app',
    measurementId: 'G-Z2E89QR67H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEPfCwftoE3uoWYAL7ft-XGIGp74CSwdw',
    appId: '1:723176115529:android:58bf493ccc9c58b1fc9e98',
    messagingSenderId: '723176115529',
    projectId: 'mis-labs-86f60',
    storageBucket: 'mis-labs-86f60.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRh9DBI8ftI-_aigv6MrQ4MWfFmpsFmbM',
    appId: '1:723176115529:ios:65085a82bfaf9df8fc9e98',
    messagingSenderId: '723176115529',
    projectId: 'mis-labs-86f60',
    storageBucket: 'mis-labs-86f60.firebasestorage.app',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRh9DBI8ftI-_aigv6MrQ4MWfFmpsFmbM',
    appId: '1:723176115529:ios:65085a82bfaf9df8fc9e98',
    messagingSenderId: '723176115529',
    projectId: 'mis-labs-86f60',
    storageBucket: 'mis-labs-86f60.firebasestorage.app',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDoQv11-PWYm12dLYn1li_7EdF100Bb6kA',
    appId: '1:723176115529:web:5dcf9863fedbaed0fc9e98',
    messagingSenderId: '723176115529',
    projectId: 'mis-labs-86f60',
    authDomain: 'mis-labs-86f60.firebaseapp.com',
    storageBucket: 'mis-labs-86f60.firebasestorage.app',
    measurementId: 'G-QHN8BWD8FN',
  );

}