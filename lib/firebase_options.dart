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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCZSgkc8vKuaiTgKG0SKi9RN2qjx0YrYPE',
    appId: '1:651335019731:web:6ce07fe04ffe5c6ab43826',
    messagingSenderId: '651335019731',
    projectId: 'evento-abbc1',
    authDomain: 'evento-abbc1.firebaseapp.com',
    storageBucket: 'evento-abbc1.appspot.com',
    measurementId: 'G-NJZPP2D0ZR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-_z5I-3oXrhEw4wiz5PiyRuafVeww8KA',
    appId: '1:651335019731:android:86309369e0802bf9b43826',
    messagingSenderId: '651335019731',
    projectId: 'evento-abbc1',
    storageBucket: 'evento-abbc1.appspot.com',
  );
}
