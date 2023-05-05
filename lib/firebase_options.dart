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
        return macos;
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
    apiKey: 'AIzaSyBWmCUK0U3kCFAOTdoW673fKHq4cI4w2Do',
    appId: '1:667435208416:web:23a3be5682e26da1480a85',
    messagingSenderId: '667435208416',
    projectId: 'login-dc331',
    authDomain: 'login-dc331.firebaseapp.com',
    storageBucket: 'login-dc331.appspot.com',
    measurementId: 'G-8NXV0FD7XP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXqQeBwBewgfxqu_wXu8LvO7KZZhFZwZk',
    appId: '1:667435208416:android:c09cd8e5cdcf5425480a85',
    messagingSenderId: '667435208416',
    projectId: 'login-dc331',
    storageBucket: 'login-dc331.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDRRQwyshTyTDNqYPW6dWFl-G0GaCJcZcs',
    appId: '1:667435208416:ios:7862392678f7e6db480a85',
    messagingSenderId: '667435208416',
    projectId: 'login-dc331',
    storageBucket: 'login-dc331.appspot.com',
    iosClientId:
        '667435208416-dvkjolu7ctndddosvr8fvhhltckbcrst.apps.googleusercontent.com',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDRRQwyshTyTDNqYPW6dWFl-G0GaCJcZcs',
    appId: '1:667435208416:ios:3c9b12bc028e4249480a85',
    messagingSenderId: '667435208416',
    projectId: 'login-dc331',
    storageBucket: 'login-dc331.appspot.com',
    iosClientId:
        '667435208416-duvhlccmblghh3lj4uagd65uf5u0tcak.apps.googleusercontent.com',
    iosBundleId: 'com.example.login.RunnerTests',
  );
}
