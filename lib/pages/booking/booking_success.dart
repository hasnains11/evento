import 'package:evento/controllers/booking_controller.dart';
import 'package:evento/pages/home_page.dart';
import 'package:evento/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingSuccess extends StatelessWidget {
  const BookingSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Booking Successful',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Thank you for booking with us',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.offAll(() => WelcomeScreen());
            },
            child: Text("Create Another Booking"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.offAll(() => HomePage());
            },
            child: Text("Go to Home Page"),
          ),
        ],
      )),
    );
  }
}
