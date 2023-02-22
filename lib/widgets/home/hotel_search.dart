import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evento/data/example_data.dart';
import 'package:evento/widgets/home/hotel.dart';
import 'package:unicons/unicons.dart';

import '../../models/Hotels.dart';
import '../../services/firestore.dart';

Column buildHotelSearch(Color defaultColor, Size size) {


  return Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Search results (${katowiceHotels.length + forYou.length})',
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
        child: FutureBuilder<List<Hotel>>(
          future: FirestoreService().getHotelList(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
                print(snapshot.error);
                return const Center(child: Text("Something Went Wrong"),);
            }
            else if(snapshot.connectionState==ConnectionState.waiting){
              return const CircularProgressIndicator();
            }
            else if(snapshot.hasData){
                var hotels= snapshot.data!.map((e) => e).toList();
                // print(hotels[0]);
                // print("snapshot Data:${snapshot.data}");
                // print("hotels.element ${hotels.elementAt(0).name}");
                // print(hotels.length);
                return ListView.builder(
                  itemCount: hotels.length,
                  primary: false,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    Hotel? hotel;
                    hotel=hotels.elementAt(i);
                     // return Text(i.toString());
                    return buildHotel(hotel, defaultColor, size);
                  },
                );

                // hotels?.map((e) => print(e.name));
                // hotels?.map((e) => print(e));
                // return Text("Data Received");
            }else{
              return const Text("Unknown Error");
            }
          },


        ),
      ),
    ),
  ]);
}
