import 'package:evento/pages/booking_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/Hotels.dart';
import '../../pages/booking/check_availability.dart';

Widget buildDetailsBottomBar(
  Hotel hotel,
  Color defaultColor,
  Color secondColor,
  Size size,
) {
  return Padding(
    padding: EdgeInsets.only(
      top: size.height * 0.01,
      left: size.width * 0.08,
      right: size.width * 0.08,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Starting from',
              style: GoogleFonts.poppins(
                color: defaultColor,
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              children: [
                Text(
                  "Pkr ${hotel.price}",
                  style: GoogleFonts.poppins(
                    color: defaultColor,
                    fontSize: size.height * 0.027,
                    fontWeight: FontWeight.w600,
                    wordSpacing: 1,
                  ),
                ),
                // Text(
                //   ' /day',
                //   style: GoogleFonts.poppins(
                //     color: defaultColor.withOpacity(0.8),
                //     fontSize: size.height * 0.02,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
              ],
            ),
          ],
        ),
        InkWell(
          child: Container(
            width: size.width * 0.4,
            height: size.height * 0.08,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              child: Text(
                'Book Now',
                style: GoogleFonts.lato(
                  color: secondColor,
                  fontSize: size.height * 0.02,
                ),
              ),
            ),
          ), //TODO: add book now action
          onTap: () => Get.to(()=>CheckAvailabilityPage()
          ),
        )
      ],
    ),
  );
}
