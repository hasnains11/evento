import 'dart:async';

import 'package:evento/pages/cities_options.dart';
import 'package:evento/pages/events_screen.dart';
import 'package:evento/pages/home_page.dart';
import 'package:evento/pages/welcome_screen.dart';
import 'package:evento/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool emailSent = false;
  bool isEmailVerified = false;
  Timer? timer;

  void initState() {
    super.initState();
    isEmailVerified = AuthService().user!.emailVerified;
    if (!isEmailVerified) {
      try {
        AuthService().sendVerificationEmail();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.black,
          content: SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height * 0.028,
            child: Center(
              child: Text((e.toString()),
              ),
            ),
          ),));
      }

      timer = Timer.periodic(Duration(seconds: 3), (timer){checkEmailVerified();print(timer.tick);});
    }
  }

  checkEmailVerified() async {
    print("Testingemailverified");
    await AuthService().user!.reload();
    setState(() {
      isEmailVerified = AuthService().user!.emailVerified;
    });
    if (isEmailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Email Verified Successfully")));
      timer!.cancel();
    }
  }

  void dispose()
  {
    timer?.cancel();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return isEmailVerified && AuthService().user!=null ? const WelcomeScreen(): Scaffold(
      appBar: AppBar(
        title: Text("Email Verification"),
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.only(left: 10, top: 20),
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    emailSent = true;
                  });
                },
                child: Text("Send Verification Email")),
            SizedBox(
              height: 20,
            ),
            if (emailSent)
              const Text(
                  "An Email Verfication Link has been sent to your Email address."
                      "Please open it verify your email.",
                  style: TextStyle(fontSize: 18)),

            ElevatedButton(
                onPressed: () {
                  AuthService().SignOutUser();
                },
                child: Text("SignOut")),
          ],
        ),
      ),
    );
  }



}







