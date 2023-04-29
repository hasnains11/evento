import 'package:evento/controllers/booking_controller.dart';
import 'package:evento/pages/events_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        bottomOpacity: 0.0,
        centerTitle: true,
        title: Text(
          'Welcome',
          style: TextStyle(fontSize: Get.height * 0.03),
        ),
      ),
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/heroimage.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.06,
            ),
            Text(
              'Evento',
              style: TextStyle(
                fontSize: Get.height * 0.03,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            Hero(
              tag: "title",
              child: Material(
                color: Colors.transparent,
                child: Text(
                  "Event Management System",
                  style: TextStyle(
                    fontSize: Get.height * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.02),
            Text(
              "Every Event Should be perfected",
              style: TextStyle(
                fontSize: Get.height * 0.023,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                backgroundColor: Colors.black.withOpacity(0.2),
              ),
            ),
            SizedBox(
              height: Get.height * 0.12,
            ),
            ElevatedButton(
              onPressed: () {
                Get.off(() => EventScreen());
              },
              child: Text(
                "Explore Events",
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink[200],
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.14,
                  vertical: Get.height * 0.02,
                ),
                textStyle: TextStyle(
                  fontSize: Get.height * 0.03,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Get.put(BookingController());
  }
}
