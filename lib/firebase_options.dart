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
    apiKey: 'AIzaSyDN9DeGb4X82_ZP1PHaJ7GBuY1VS4MOzNs',
    appId: '1:1010196470821:web:9382d6cf838f2d3164b3cc',
    messagingSenderId: '1010196470821',
    projectId: 'fb-auth-provider-a052b',
    authDomain: 'fb-auth-provider-a052b.firebaseapp.com',
    storageBucket: 'fb-auth-provider-a052b.appspot.com',
    measurementId: 'G-VFYKB9QDD7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0iXPiYbt8DxHAl8vHBQ2iU1h72gsO8_k',
    appId: '1:1010196470821:android:cdc062e52ed3d10464b3cc',
    messagingSenderId: '1010196470821',
    projectId: 'fb-auth-provider-a052b',
    storageBucket: 'fb-auth-provider-a052b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNfyeM_5HzpCljrGs9b46y4HPRCfbB3W4',
    appId: '1:1010196470821:ios:4302b0bb73b2bb4b64b3cc',
    messagingSenderId: '1010196470821',
    projectId: 'fb-auth-provider-a052b',
    storageBucket: 'fb-auth-provider-a052b.appspot.com',
    iosClientId: '1010196470821-r31q9mu0lf6an6ggt8pka44suomq6k95.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseEx1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNfyeM_5HzpCljrGs9b46y4HPRCfbB3W4',
    appId: '1:1010196470821:ios:4302b0bb73b2bb4b64b3cc',
    messagingSenderId: '1010196470821',
    projectId: 'fb-auth-provider-a052b',
    storageBucket: 'fb-auth-provider-a052b.appspot.com',
    iosClientId: '1010196470821-r31q9mu0lf6an6ggt8pka44suomq6k95.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseEx1',
  );
}