import 'package:evento/controllers/booking_controller.dart';
import 'package:evento/pages/booking/booking_success.dart';
import 'package:evento/pages/booking/decoration_screen.dart';
import 'package:evento/pages/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinalSummaryPage extends StatefulWidget {
  final int numberOfGuests;
  final List menuSelections;
  final List<Option> decorationOptions;
  final String reservationDate;
  final String shift;
  final int totalBill;

  FinalSummaryPage({
    required this.numberOfGuests,
    required this.menuSelections,
    required this.decorationOptions,
    required this.reservationDate,
    required this.shift,
    required this.totalBill,
  });

  @override
  State<FinalSummaryPage> createState() => _FinalSummaryPageState();
}

class _FinalSummaryPageState extends State<FinalSummaryPage> {
  final bookingController = Get.find<BookingController>();

  var _processing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservation Summary'),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Reservation Details:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: Get.height * 0.005),
              _buildDetailsRow('Number of guests', '${widget.numberOfGuests}'),
              SizedBox(height: Get.height * 0.005),
              // _buildDetailsRow('Menu selections',),
              Text(
                "Menu Selections:",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Get.height * 0.024),
              ),
              SizedBox(height: Get.height * 0.005),
              SizedBox(
                height: Get.height * 0.13,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...widget.menuSelections.map((menu) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Text('- $menu'),
                          );
                        }).toList(),
                      ]),
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                'Menu Total: Rs. ${bookingController.menu.price.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.height * 0.017,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),
              Text(
                "Decoration Options:",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: Get.height * 0.024),
              ),
              SizedBox(height: 5),
              SizedBox(
                height: Get.height * 0.16,
                width: Get.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.decorationOptions.map((option) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          option.subOptions != null
                              ? Text(
                                  option.title,
                                  style: TextStyle(
                                      fontSize: Get.height * 0.02,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(""),
                          SizedBox(height: 5),
                          if (option.subOptions != null)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: option.subOptions!.length,
                              itemBuilder: (BuildContext context, int index) {
                                SubOption subOption = option.subOptions![index];
                                if (subOption.isSelected) {
                                  return Text(
                                    '- ${subOption.title}: Rs. ${subOption.price.toStringAsFixed(2)}',
                                    style:
                                        TextStyle(fontSize: Get.height * 0.017),
                                  );
                                } else {
                                  return SizedBox.shrink();
                                }
                              },
                            ),
                          SizedBox(height: 8.0),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
              Text(
                'Decoration Total: Rs. ${bookingController.decorationBill.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Get.height * 0.017,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10),
              _buildDetailsRow('Reservation date', widget.reservationDate),
              SizedBox(height: 10),
              _buildDetailsRow('Shift', widget.shift),
              Spacer(),
              Divider(
                height: 2,
              ),
              Text(
                'Total Bill:',
                style: TextStyle(
                  fontSize: Get.height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Rs. ${widget.totalBill.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: Get.height * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Payment Method:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: 'payment_on_arrival',
                        groupValue: 'payment_on_arrival',
                        onChanged: (value) {},
                        activeColor: Colors.blue[800],
                      ),
                      Text(
                        'Payment on Arrival',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_processing)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ]),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          // Add your confirmation logic here
          setState(() {
            _processing = true;
          });
          await bookingController.createBooking();
          Get.showSnackbar(GetBar(
            message: 'Reservation Confirmed',
            duration: Duration(seconds: 2),
          ));
          Get.offAll(() => BookingSuccess());
          setState(() {
            _processing = false;
          });
        },
        child: Text('Confirm Reservation'),
      ),
    );
  }

  Widget _buildDetailsRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
