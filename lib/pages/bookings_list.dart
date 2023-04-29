import 'package:evento/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// import '../models/Hotels.dart';
import '../services/firestore.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/side_drawer.dart';

class BookingsList extends StatefulWidget {
  const BookingsList({Key? key}) : super(key: key);

  @override
  State<BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
  bool _isLoading = false;

  late var _bookings;

  _cancelBooking(String bookingId, String hotelId, String date) async {
    await FirestoreService().deleteBooking(bookingId, hotelId, date);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Booking cancelled'),
      duration: Duration(seconds: 2),
    ));
    _fetchBookings();
  }

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  void _fetchBookings() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate fetching bookings from Firestore
    var bookings = await FirestoreService().getBookings();
    print(bookings);
    setState(() {
      _isLoading = false;
      _bookings = bookings;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: buildBottomNavBar(2, Get.size, true),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.off(() => WelcomeScreen());
          },
          child: Icon(Icons.add),
        ),
        drawer: SideDrawer(
          index: 2,
        ),
        appBar: AppBar(
          title: Text('Bookings List'),
          centerTitle: true,
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : _bookings?.isEmpty ?? true
                ? Center(child: Text('No Bookings Yet'))
                : Container(
                    margin: Get.width > 600
                        ? EdgeInsets.symmetric(horizontal: 100.0)
                        : null,
                    width: Get.width > 600 ? Get.width * 0.8 : Get.width * 0.95,
                    child: ListView.builder(
                      itemCount: _bookings?.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map booking = _bookings?.elementAt(index) ?? {};
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 4.0,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Column(children: [
                            Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0)),
                                      child: Image.network(
                                        '${booking['hotelImg']}',
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Text('booking id:${booking['id']}'),
                                  ],
                                )),
                            ListTile(
                              // contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),

                              title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${booking['hotelName']}',
                                      style: TextStyle(
                                          fontSize: Get.height * 0.023,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        '${booking['eventType'].toString().toUpperCase()}',
                                        style: TextStyle(
                                            fontSize: Get.height * 0.016)),
                                    Text('${booking['bookingDate']}',
                                        style: TextStyle(
                                            fontSize: Get.height * 0.018)),
                                    SizedBox(height: Get.height * 0.01),
                                  ]),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${booking['numberofPerson']} persons'),
                                  Text('Shift ${booking['shift']}'),
                                  Text(
                                      "Total Bill: Rs.${booking['totalBill']}"),
                                  DateFormat('dd-MM-yyyy').parse(booking['bookingDate']).isBefore(DateTime.now())?
                                  const Text("Booking Expired",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900
                                  ),):
                                  const Text('Upcoming',
                                      style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900
                                      )
                                  ),

                          ],
                              ),
                              trailing: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.05,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        // Show the dialog box
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Confirm Cancel"),
                                              content: Text(
                                                  "Are you sure you want to cancel this booking?"),
                                              actions: [
                                                TextButton(
                                                  child: Text("back"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text("confirm"),
                                                  onPressed: () async {
                                                    // Perform some action here
                                                    await _cancelBooking(
                                                        booking['id'],
                                                        booking['hotelId'],
                                                        booking['bookingDate']);
                                                    print('booking cancelled');
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      color: Colors.red,
                                      textColor: Colors.white,
                                      child: Icon(Icons.cancel_outlined),
                                      padding: EdgeInsets.all(0),
                                      shape: CircleBorder(),
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.01),
                                  Text(
                                    'Cancel Booking',
                                    style:
                                        TextStyle(fontSize: Get.height * 0.014),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
                  ));
  }
}

// _showBookingDetailsDialog(BuildContext context ,Booking booking) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20.0),
//         ),
//         child: Container(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Booking Details',
//                 style: TextStyle(
//                   fontSize: 24.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 20.0),
//               Text(
//                 'Booking ID: ${booking.id}',
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               SizedBox(height: 10.0),
//               Text(
//                 'Date: ${booking.date}',
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               SizedBox(height: 10.0),
//               Text(
//                 'Number of Persons: ${booking.numberOfPersons}',
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               SizedBox(height: 10.0),
//               Text(
//                 'Decoration Type: ${booking.decorationType}',
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               SizedBox(height: 10.0),
//               Text(
//                 'Event Type: ${booking.eventType}',
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               SizedBox(height: 10.0),
//               Text(
//                 'Menu: ${booking.menu}',
//                 style: TextStyle(fontSize: 18.0),
//               ),
//               SizedBox(height: 20.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   TextButton(
//                     onPressed: () => Navigator.pop(context),
//                     child: Text(
//                       'Close',
//                       style: TextStyle(
//                         color: Colors.black87,
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
//
// }
//
// class Bookings{
//   final int id;
//   final DateTime date;
//   final int numberOfPersons;
//   final String decorationType;
//   final String eventType;
//   final String menu;
//
//   Bookings({
//     required this.id,
//     required this.date,
//     required this.numberOfPersons,
//     required this.decorationType,
//     required this.eventType,
//     required this.menu,
//   });
// }
