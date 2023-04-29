import 'package:evento/controllers/booking_controller.dart';
import 'package:evento/pages/cities_options.dart';
import 'package:evento/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Event {
  final String name;
  final String description;
  final String imageUrl;

  Event(
      {required this.name, required this.description, required this.imageUrl});
}

List<Event> events = [
  Event(
      name: "Birthday",
      description: "Celebrate your special day",
      imageUrl: "assets/birthday.jpg"),
  Event(
      name: "Wedding",
      description: "The beginning of your forever",
      imageUrl: "assets/w.jpg"),
  Event(
      name: "Seminars",
      description: "Music and good vibes",
      imageUrl: "assets/seminar.jpg"),
  Event(
      name: "Concert",
      description: "Music and good vibes",
      imageUrl: "assets/concert.jpg"),
];

class EventScreen extends StatelessWidget {
  EventScreen({Key? key}) : super(key: key);
  final bookingController = Get.find<BookingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Event Type"),
      ),
      body: Container(
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          itemCount: events.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: Get.height * 0.4,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: Get.height * 0.4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: InkWell(
                  onTap: () {
                    // Navigate to the details screen
                    Get.to(() => OptionsScreen(),
                        arguments: {"event": events[index].name});
                    bookingController.addItem({"event": events[index].name});
                  },
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: Get.height * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15.0),
                          ),
                          image: DecorationImage(
                            image: AssetImage(events[index].imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              events[index].name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Get.height * 0.024,
                              ),
                            ),
                            SizedBox(height: 5),
                            Divider(
                              height: 2,
                            ),
                            SizedBox(height: 5),
                            Text(events[index].description,
                                style: TextStyle(fontSize: Get.height * 0.02)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
    ;
  }
}
