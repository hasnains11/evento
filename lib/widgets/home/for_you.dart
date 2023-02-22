import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evento/data/example_data.dart';
import 'package:evento/widgets/home/hotel.dart';

Column buildForYou(Color defaultColor, Size size) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'For You', //category name
            style: GoogleFonts.lato(
              color: defaultColor,
              fontSize: size.height * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            //TODO: add view all action
            onTap: () => print('view all'),
            child: Text(
              'View all',
              style: GoogleFonts.lato(
                color: defaultColor.withOpacity(0.4),
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.025,
        ),
        child: CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, i, ri) {
                return Text(i.toString());
             // hotel = forYou[i];
            // return buildHotel(hotel, defaultColor, size);
          },
          options: CarouselOptions(
            viewportFraction: 1,
            height: size.height * 0.5,
            enableInfiniteScroll: true,
            autoPlay: forYou.length > 1 ? true : false,
            autoPlayInterval: const Duration(seconds: 8),
          ),
        ),
      ),
    ],
  );
}
