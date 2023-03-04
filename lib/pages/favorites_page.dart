import 'dart:async';
import 'dart:convert';
import 'package:evento/pages/details_page.dart';
import 'package:evento/services/AuthService.dart';
import 'package:evento/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Hotels.dart';

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
   List _myData =[];


  @override
  void initState() {
    super.initState();
    _loadDataFromPrefs(); // Load data from shared preferences on init
  }


  Future<void> _loadDataFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(AuthService().user!.uid) ?? [];
    var hotelList=favorites.map((e) => Hotel.fromJson(jsonDecode(e))).toList();
    print(hotelList);
    if(mounted) {
      setState(() {
        _myData = [...hotelList];
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    print(_myData);
    return Scaffold(
      appBar: AppBar(title: Text("Favourites")),
      bottomNavigationBar: buildBottomNavBar(1, Get.size, true),
      body:  _myData.isNotEmpty ?ListView.builder(
        itemCount: _myData.length,
        itemBuilder: (context, index) {
          return FavoriteHotelCard(hotel: _myData.elementAt(index));
        },
      ):Center(child: Text("No Favorites Yet"),),
    ); // Render the widget with the loaded data
  }
}

class FavoriteHotelCard extends StatelessWidget {
  Hotel hotel;

  FavoriteHotelCard({
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    String hotelName=hotel.name??"";
    String imageUrl=hotel.img??"";
    String location=hotel.location??"";
    num price=hotel.price??0.00;

    return
      InkWell(
        onTap: (){
          Get.to(DetailsPage(hotel: hotel, size: Get.size));
        },
        child: Container(
          height: Get.height*0.17,
          margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        hotelName,
                        style: TextStyle(
                          fontSize: Get.height * 0.026,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Divider(),
                      // SizedBox(height: 4.0),
                      Row(
                        children: [
                          Icon(Icons.location_on,color: Colors.black,),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: Get.height * 0.019,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      Row(
                        children: [
                          Icon(
                            Icons.attach_money,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            'Starting from ${price.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: Get.height * 0.019,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w500
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Icon(Icons.favorite_outlined,color: Colors.red,)),
                  ],
                ),
              ),

            ]
            ,
          ),
        ),
      );


  }
}
