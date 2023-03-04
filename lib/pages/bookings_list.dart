import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/bottom_nav_bar.dart';

class BookingsList extends StatefulWidget {
  const BookingsList({Key? key}) : super(key: key);

  @override
  State<BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {
    bool _isLoading = false;

  List<Bookings> _bookings = [
    Bookings(
      id: 1,
      date: DateTime.now(),
      numberOfPersons: 10,
      decorationType: 'Flowers',
      eventType: 'Wedding',
      menu: 'Vegetarian',
    ),
    Bookings(
      id: 2,
      date: DateTime.now().add(Duration(days: 7)),
      numberOfPersons: 20,
      decorationType: 'Balloons',
      eventType: 'Birthday',
      menu: 'Non-vegetarian',
    ),
    Bookings(
      id: 3,
      date: DateTime.now().add(Duration(days: 14)),
      numberOfPersons: 30,
      decorationType: 'Candles',
      eventType: 'Anniversary',
      menu: 'Mixed',
    ),
  ];

  void _cancelBooking(int bookingId) {
    setState(() {
      _bookings.removeWhere((booking) => booking.id == bookingId);
    });
    // Show snackbar to indicate successful cancellation
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Booking cancelled'),
      duration: Duration(seconds: 2),
    ));
  }

    void _fetchBookings() async {
      setState(() {
        _isLoading = true;
      });

      // Simulate fetching bookings from Firestore
      await Future.delayed(Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });

    }


  @override
  Widget build(BuildContext context) {




    return Scaffold(
      bottomNavigationBar: buildBottomNavBar(3,Get.size,true),

        appBar: AppBar(
          title: Text('Bookings List'),
          centerTitle: true,
        ),
        body:_isLoading?CircularProgressIndicator():ListView.builder(
          itemCount: _bookings.length,
          itemBuilder: (BuildContext context, int index) {
            Bookings booking = _bookings[index];
            return Card(
              elevation: 4.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                leading: CircleAvatar(
                  child: Text('${booking.id}'),
                  backgroundColor: Colors.orange,
                ),
                title: Text('${booking.eventType} - ${booking.date.day}/${booking.date.month}/${booking.date.year}'),
                subtitle: Text('${booking.numberOfPersons} persons, ${booking.decorationType}, ${booking.menu}'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                      child: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          // Cancel booking
                          _cancelBooking(booking.id);
                        },
                      ),
                    ),
                    Text(
                      'Cancel',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                onTap: () {
                  // Naviga
                  // te to booking details page
                  //
                 _showBookingDetailsDialog(context,booking);
                },
              ),
            );
          },
        ),

    );
  }



}
_showBookingDetailsDialog(BuildContext context ,Bookings booking) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Booking Details',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Booking ID: ${booking.id}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'Date: ${booking.date}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'Number of Persons: ${booking.numberOfPersons}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'Decoration Type: ${booking.decorationType}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'Event Type: ${booking.eventType}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 10.0),
              Text(
                'Menu: ${booking.menu}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

}

class Bookings{
  final int id;
  final DateTime date;
  final int numberOfPersons;
  final String decorationType;
  final String eventType;
  final String menu;

  Bookings({
    required this.id,
    required this.date,
    required this.numberOfPersons,
    required this.decorationType,
    required this.eventType,
    required this.menu,
  });
}
