import 'package:evento/pages/booking_page.dart';
import 'package:evento/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/booking_controller.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
// import 'package:intl/date_symbol_data_local.dart';

import 'main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => runApp(const App()));
  // initializeDateFormatting()
  //     .then((_) => runApp(const App()));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

List<GetPage> routes = [
  GetPage(name: '/', page: () => MainScreen()),
];

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    //final _app = GetMaterialApp(home: MainScreen())

    CacheAssetImages(context);

    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // Error screen
          return const Text('Something went wrong!');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(getPages: routes, home: MainScreen());
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const MaterialApp(
          home: Scaffold(body: SplashScreen()),
        );
      },
    );
  }

  void CacheAssetImages(BuildContext context) {
    precacheImage(AssetImage('assets/wedding.jpg'), context);
    precacheImage(AssetImage('assets/birthday.jpg'), context);
    precacheImage(AssetImage('assets/concert.jpg'), context);
    precacheImage(AssetImage('assets/menu_background.jpg'), context);
    precacheImage(AssetImage('assets/seminar.jpg'), context);
  }
}
