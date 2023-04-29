import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evento/data/example_data.dart';
import 'package:evento/widgets/home/hotel.dart';

Column buildCarousal(Color defaultColor, Size size) {
  final List<Map<String, String>> carousalData = [
    {
      'img': 'Cbirthday',
      'tagline': 'Host your next birthday party in style with us.'
    },
    {
      'img': 'Cconcert',
      'tagline': 'Book our event venues for concerts and performances'
    },
    {
      'img': 'Cwedding',
      'tagline': 'Plan your dream wedding at our picturesque event spaces.'
    },
  ];
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'We offer', //category name
            style: GoogleFonts.lato(
              color: defaultColor,
              fontSize: size.height * 0.025,
              fontWeight: FontWeight.bold,
            ),
          ),
          // InkWell(
          //   //TODO: add view all action
          //   onTap: () => print('view all'),
          //   child: Text(
          //     'View all',
          //     style: GoogleFonts.lato(
          //       color: defaultColor.withOpacity(0.4),
          //       fontSize: size.height * 0.02,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * 0.025,
        ),
        child: CarouselSlider.builder(
          itemCount: 3,
          itemBuilder: (context, i, ri) {
            return Container(
              height: 0,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "assets/carousalImages/${carousalData[i]['img']}.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.75,
                    colorFilter:
                        ColorFilter.mode(Colors.black, BlendMode.difference)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2),
                  BlendMode.colorBurn,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      carousalData[i]['tagline'] ?? '',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height * 0.04,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            );
            // hotel = forYou[i];
            // return buildHotel(hotel, defaultColor, size);
          },
          options: CarouselOptions(
            viewportFraction: 1,
            height: (size.width > 550) ? size.height * 0.43 : size.height * 0.3,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 8),
          ),
        ),
      ),
    ],
  );
}
