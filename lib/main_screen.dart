import 'package:evento/pages/auth_page.dart';
import 'package:evento/pages/email_verification.dart';
import 'package:evento/services/AuthService.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}
//function to check if user is logged in or not


class _MainScreenState extends State<MainScreen> {
  @override



  Widget build(BuildContext context) {

    return Scaffold(
      body: StreamBuilder(
        stream: AuthService().userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading..."));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          } else if (snapshot.hasData) {
              return EmailVerification();
          } else {
            return AuthPage();
          }
        },
      ),
    );
  }
}
