import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evento/data/example_data.dart';
import 'package:evento/widgets/home/hotel.dart';
import 'package:unicons/unicons.dart';

import '../../models/Hotels.dart';
import '../../services/firestore.dart';

Column buildHotelSearch(Color defaultColor, Size size, List<Hotel> hotels) {
  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hotels Found (${hotels.length})',
          style: GoogleFonts.lato(
            color: defaultColor,
            fontSize: size.height * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: size.height * 0.04,
          width: size.width * 0.1,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                10,
              ),
            ),
            color: Color(0xff3b22a1), //filters bg color
          ),
          child: Icon(
            UniconsLine.sliders_v,
            color: Colors.white,
            size: size.height * 0.025,
          ),
        ),
      ],
    ),
    Padding(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.025,
      ),
      child: SizedBox(
          width: size.width * 0.85,
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
