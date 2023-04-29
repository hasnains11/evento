import 'package:evento/controllers/booking_controller.dart';
import 'package:evento/pages/booking/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CheckAvailabilityPage extends StatefulWidget {
  @override
  _CheckAvailabilityPageState createState() => _CheckAvailabilityPageState();
}

class _CheckAvailabilityPageState extends State<CheckAvailabilityPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  String? _selectedShift;
  String? _availabilityStatus;
  final bookingController = Get.find<BookingController>();
  final TextEditingController _guestsController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<bool> isShiftBooked(String date, String shift) async {
    // Initialize Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Get the document reference for the specified date
    DocumentReference docRef = firestore.collection('bookings').doc();
    // Get the document snapshot
    DocumentSnapshot doc = await docRef.get();
    // If the document doesn't exist, the shift is not booked
    if (!doc.exists) {
      return false;
    }
    print(doc.data());
    // Get the value of the specified shift
    bool? shiftValue = (doc.data() as Map<String, dynamic>)[shift];
    // If the shift value is null or false, the shift is not booked
    if (shiftValue == null || shiftValue == false) {
      return false;
    }

    // If the shift value is true, the shift is booked
    return true;
  }

  _checkAvailability() async {
    if (_formKey.currentState!.validate() &&
        _selectedDate != null &&
        _selectedShift != null) {}
    // bool isBooked = await isShiftBooked(
    CollectionReference docsRef =
        FirebaseFirestore.instance.collection('bookings');
    var date = DateFormat('dd-MM-yyyy').format(_selectedDate!);
    print(date);
    print(_selectedShift);
    // Construct a query to get all documents that match the date and shift criteria
    QuerySnapshot docsSnap = await docsRef
        .where('bookingDate', isEqualTo: date)
        .where('shift', isEqualTo: _selectedShift)
        .where('hotelId', isEqualTo: bookingController.selectedHotel!.uid)
        .get();

    // If any documents were found, display them in the console and return true
    if (docsSnap.docs.isNotEmpty) {
      docsSnap.docs.forEach((doc) {
        print(doc.data());
        setState(() {
          _availabilityStatus = "Not Available";
        });
      });

      return false;
    }
    print("The shift is not booked");

    setState(() {
      _availabilityStatus = "Available";
    });
    // Otherwise, return false
    return true;

    //     DateFormat('yyyy-MM-dd').format(_selectedDate!), _selectedShift!);
    // print(isBooked);
    //   final result = await FirebaseFirestore.instance
    //       .collection('bookings')
    //       .doc(DateFormat('yyyy-MM-dd').format(_selectedDate!))
    //       .get()
    //       .then((value) => {
    //   if (value.exists && value.get(FieldPath([_selectedShift])).isNull) {
    //       print('The field is null');
    // } else {
    //   print('The field is not null');
    // }

    // doc(DateFormat('yyyy-MM-dd').format(_selectedDate!)).
    //       then((value) => value.collection('shifts').doc(_selectedShift!.toLowerCase()).get());
    // where('shifts.${_selectedShift?.toLowerCase()}', isEqualTo: true)
    // get();
    //   if (result.docs.isNotEmpty) {
    //     setState(() {
    //       _availabilityStatus = 'Not Available';
    //     });
    //   } else {
    //     setState(() {
    //       _availabilityStatus = 'Available';
    //     });
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    int hotelCapacity = bookingController.selectedHotel!.capacity!.toInt();

    return Scaffold(
      appBar: AppBar(
        title: Text('Check Availability'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Expected Number of guests($hotelCapacity max)',
                style: GoogleFonts.openSans(
                  fontWeight: FontWeight.bold,
                  fontSize: Get.height * 0.024,
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _guestsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter number of guests',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Select Date',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Get.height * 0.024),
              ),
              SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Text(
                  _selectedDate == null
                      ? 'Select a date'
                      : 'Selected date: ${_selectedDate.toString()}',
                ),
              ),
              SizedBox(height: 16.0),
              Text('Select Shift'),
              SizedBox(height: 8.0),
              DropdownButtonFormField(
                value: _selectedShift,
                onChanged: (value) {
                  setState(() {
                    _selectedShift = value as String?;
                  });
                },
                items: ['Day', 'Night']
                    .map((shift) => DropdownMenuItem(
                          value: shift,
                          child: Text(shift),
                        ))
                    .toList(),
                decoration: InputDecoration(
                  labelText: 'Select a Shift',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              ElevatedButton(
                onPressed: _checkAvailability,
                child: Text('Check Availability'),
              ),
              SizedBox(height: 16.0),
              _availabilityStatus != null && _selectedDate != null
                  ? Text(
                      'Availability Status: $_availabilityStatus',
                      style: TextStyle(
                        color: _availabilityStatus == 'Available'
                            ? Colors.green
                            : Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : SizedBox(),
              _availabilityStatus == 'Available'
                  ? ElevatedButton(
                      onPressed: () {
                        if (_guestsController.text.isNotEmpty &&
                            int.parse(_guestsController.text) <=
                                hotelCapacity &&
                            _selectedShift != "" &&
                            _selectedDate != null) {
                          bookingController.addNumberOfGuests(
                              int.parse(_guestsController.text));
                          bookingController.addShift(_selectedShift.toString());
                          bookingController.bookingDate =
                              DateFormat('dd-MM-yyyy').format(_selectedDate!);
                          Get.to(() => MenuScreen());
                        } else {
                          Get.snackbar(
                              "Error", "Please enter correct number of guests");
                        }
                      },
                      child: Text("Continue Registration!"))
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
