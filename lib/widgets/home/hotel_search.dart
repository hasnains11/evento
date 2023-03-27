import 'package:evento/controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evento/data/example_data.dart';
import 'package:evento/widgets/home/hotel.dart';
import 'package:unicons/unicons.dart';

import '../../models/Hotels.dart';
import '../../services/firestore.dart';

Column buildHotelSearch(Color defaultColor, Size size, List<Hotel> hotels) {
  String location = Get.find<BookingController>().bookingDetails['location'];
  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hotels Found in $location  (${hotels.length})',
          style: GoogleFonts.lato(
            color: defaultColor,
            fontSize: size.height * 0.025,
            fontWeight: FontWeight.bold,
          ),
          textAlign: size.width > 550 ? TextAlign.center : TextAlign.left,
        ),
      ],
    ),
    Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.025,
      ),
      child: SizedBox(
          width: size.width > 550 ? size.width * .50 : size.width * 0.85,
          child: ListView.builder(
            itemCount: hotels.length,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, i) {
              Hotel? hotel;
              hotel = hotels.elementAt(i);
              // return Text(i.toString());
              return buildHotel(hotel, defaultColor, size);
            },
          )),
    ),
  ]);
}
