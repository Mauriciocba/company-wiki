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
    apiKey: 'AIzaSyCsPHm8qdnQ4FZj17vD3wteaurWL3oRq_A',
    appId: '1:675140290374:web:77f53235ebfc1a6eb68747',
    messagingSenderId: '675140290374',
    projectId: 'empresasarg-6405b',
    authDomain: 'empresasarg-6405b.firebaseapp.com',
    storageBucket: 'empresasarg-6405b.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTGewBSB1IP4JO9YpDohmKVsYTSEJ4nV4',
    appId: '1:675140290374:android:f91afce97e3c2296b68747',
    messagingSenderId: '675140290374',
    projectId: 'empresasarg-6405b',
    storageBucket: 'empresasarg-6405b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-DsGd8TfFiiYP0JPZ4YnxVDDsfsxBdIg',
    appId: '1:675140290374:ios:4f61a58ccd040e27b68747',
    messagingSenderId: '675140290374',
    projectId: 'empresasarg-6405b',
    storageBucket: 'empresasarg-6405b.firebasestorage.app',
    iosBundleId: 'com.example.companyWiki',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-DsGd8TfFiiYP0JPZ4YnxVDDsfsxBdIg',
    appId: '1:675140290374:ios:4f61a58ccd040e27b68747',
    messagingSenderId: '675140290374',
    projectId: 'empresasarg-6405b',
    storageBucket: 'empresasarg-6405b.firebasestorage.app',
    iosBundleId: 'com.example.companyWiki',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCsPHm8qdnQ4FZj17vD3wteaurWL3oRq_A',
    appId: '1:675140290374:web:560ed31f8c9d6b1cb68747',
    messagingSenderId: '675140290374',
    projectId: 'empresasarg-6405b',
    authDomain: 'empresasarg-6405b.firebaseapp.com',
    storageBucket: 'empresasarg-6405b.firebasestorage.app',
  );
}
