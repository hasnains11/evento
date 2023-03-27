import 'package:evento/pages/welcome_screen.dart';
import 'package:evento/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:evento/widgets/bottom_nav_bar.dart';
import 'package:evento/widgets/home/for_you.dart';
import 'package:evento/widgets/home/hotel_search.dart';
import 'package:evento/widgets/home/top_bar.dart';
import 'package:get/get.dart';

import '../controllers/booking_controller.dart';
import '../models/Hotels.dart';
import '../services/firestore.dart';
import '../widgets/side_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var hotels=FirestoreService().getHotelList().then((value) => value.map((e){print(e.name);}));

  final bookingController = Get.find<BookingController>();
  String? _location = "";
  String? _event = "";

  @override
  void initState() {
    super.initState();
    _location = bookingController.bookingDetails['location'];
    _event = bookingController.bookingDetails['event'];
  }

  _setLocation(String location) {
    setState(() {
      _location = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(bookingController.bookingDetails);

    Size size = MediaQuery.of(context).size; //check the size of device
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness ==
        Brightness.dark; //check if device is in dark or light mode
    Color defaultColor = isDarkMode ? Colors.white : Colors.black;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text("Venues List"),
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.off(() => const WelcomeScreen());
              },
              child: Text("Go Back"))
        ],
      ),
      drawer: SideDrawer(
        index: 0,
      ),
      extendBodyBehindAppBar: false,
      bottomNavigationBar: buildBottomNavBar(0, size, !isDarkMode),
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xff06090d)
                : const Color(0xfff8f8f8), //background color
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.02,
                left: size.width * 0.05,
                right: size.width * 0.05,
              ),
              child: ListView(
                children: [
                  Divider(
                    color: defaultColor,
                    thickness: 0.25,
                    height: size.height * 0.035,
                  ),
                  buildCarousal(defaultColor, size),
                  Divider(
                    color: defaultColor,
                    thickness: 0.25,
                    height: size.height * 0.035,
                  ),
                  buildTopBar(defaultColor, size, _setLocation),
                  bookingController.hotelList.isNotEmpty &&
                          bookingController.hotelList[0].location ==
                              bookingController.bookingDetails['location']
                      ? buildHotelSearch(
                          defaultColor, size, bookingController.hotelList)
                      : FutureBuilder<List<Hotel>>(
                          future: FirestoreService().getHotelbyLocation(
                              _location ?? '', _event ?? ''),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              print(snapshot.error);
                              return const Center(
                                child: Text("Something Went Wrong"),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                  child: const CircularProgressIndicator());
                            } else if (snapshot.hasData) {
                              var hotels =
                                  snapshot.data!.map((e) => e).toList();
                              // print(hotels[0]);
                              // print("snapshot Data:${snapshot.data}");
                              // print("hotels.element ${hotels.elementAt(0).name}");
                              // print(hotels.length);
                              bookingController.setHotelList(hotels);
                              return buildHotelSearch(
                                  defaultColor, size, hotels);

                              // hotels?.map((e) => print(e.name));
                              // hotels?.map((e) => print(e));
                              // return Text("Data Received");
                            } else {
                              return const Text("Unknown Error");
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
