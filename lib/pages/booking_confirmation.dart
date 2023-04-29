import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evento/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/Hotels.dart';
import 'bookings_list.dart';

class BookingConfirmationPage extends StatefulWidget {
  Booking booking;

  BookingConfirmationPage({Key? key, required this.booking}) : super(key: key);

  @override
  State<BookingConfirmationPage> createState() =>
      _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Booking Confirmation',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Hotel Name:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text('${widget.booking.hotel?.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              SizedBox(height: 12),
              Text(
                'Event Type:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text('${widget.booking.eventType}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              SizedBox(height: 12),
              Text(
                'Date:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text('${widget.booking.date}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              SizedBox(height: 12),
              Text(
                'Number of Persons:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text('${widget.booking.numberOfPersons}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              SizedBox(height: 12),
              Text(
                'Decoration Type:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text('${widget.booking.decorationType}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              SizedBox(height: 12),
              Text(
                'Menu:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text('${widget.booking.menu.items.join(', ')}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              SizedBox(height: 16),
              Text(
                'Total Bill:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text('${widget.booking.totalBill}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              SizedBox(height: 24),
              Text(
                'Payment Method:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Text('Payment on Arrival',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              SizedBox(height: 24),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });

                          try {
                            // await FirestoreService().createBooking(widget.booking);
                            Get.off(() => BookingsList());
                            Get.snackbar("Booking Confirmed",
                                "Your booking has been confirmed");
                          } catch (e) {
                            Get.snackbar('Error', 'Something went wrong');
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text(
                          'Confirm Booking',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
