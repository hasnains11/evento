import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evento/widgets/details/hotel_details_bottom.dart';

import '../../models/Hotels.dart';

AnimatedPadding buildHotelDetails(Hotel hotel, Color defaultColor,
    Color secondColor, bool extendDetails, Size size) {
  return AnimatedPadding(
    padding: EdgeInsets.only(
      top: extendDetails ? size.height * 0.3 : size.height * 0.35,
    ),
    duration: const Duration(milliseconds: 300),
    child: Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              color: secondColor,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(
                40,
              )),
            ),
            width: size.width,
            height: extendDetails ? size.height * 0.57 : size.height * 0.53,
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.03,
                left: size.width * 0.08,
                right: size.width * 0.08,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.65,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                hotel.name??"default name",
                                maxLines: 1,
                                style: GoogleFonts.lato(
                                  color: defaultColor,
                                  fontSize: size.height * 0.035,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.lightBlue[800],
                                size: size.height * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: size.width * 0.015,
                                ),
                                child: Text(
                                  "${hotel.location}, Pakistan",
                                  style: GoogleFonts.lato(
                                    color: defaultColor,
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: defaultColor.withOpacity(0.5),
                            size: size.height * 0.025,
                          ),
                          Text(
                            hotel.rating.toString(),
                            style: GoogleFonts.lato(
                              color: defaultColor.withOpacity(0.5),
                              fontSize: size.height * 0.025,
                              fontWeight: FontWeight.w600,
                              wordSpacing: -3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: defaultColor,
                    thickness: 0.5,
                    height: size.height * 0.02,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    height:
                        extendDetails ? size.height * 0.44: size.height * 0.40,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.zero,
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          SizedBox(height: 4,),
                          Text('Hotel Description',style: TextStyle(fontSize: size.height*0.025 ,fontWeight: FontWeight.w700),),
                          SizedBox(height: 4,),
                          Text(
                          //TODO: change description
                            hotel.description??"hotel description",
                          style: GoogleFonts.poppins(
                            color: defaultColor.withOpacity(0.8),
                            fontSize: size.height * 0.016,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                          SizedBox(height: size.height*0.02,),
                          Text("Events Entertained",style: TextStyle(fontSize:size.height*0.02,fontWeight: FontWeight.w700),),
                          SizedBox(height: 4,),
                          ...getServices(hotel),
                          SizedBox(height: size.height*0.02,),
                          Text("Capacity",style: TextStyle(fontSize:size.height*0.02,fontWeight: FontWeight.w700),),
                          Text("${hotel.capacity} person maximum"),
                          SizedBox(height: 5,)
                          // Container(child:getServices(hotel),
                          // height:  size.height*0.2,
                          // width: size.width*0.8,)
                        ]
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          color: defaultColor,
          height: size.height * 0.01,
        ),
        buildDetailsBottomBar(hotel, defaultColor, secondColor, size),
      ],
    ),
  );
}


Iterable<Text> getServices(Hotel hotel){
    var values=hotel.services?.map((e) => Text(e));
    return values??[];
}