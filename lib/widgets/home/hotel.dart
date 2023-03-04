import 'dart:convert';

import 'package:evento/services/AuthService.dart';
import 'package:evento/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:evento/pages/details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



import '../../models/Hotels.dart';
import '../../services/sharedPref.dart';

class HotelCard extends StatefulWidget {
  Size size;
  Hotel hotel;
  Color defaultColor;

  HotelCard({Key? key,required this.size,required this.hotel,required this.defaultColor}) : super(key: key);

  @override
  State<HotelCard> createState() => _HotelState();
}

class _HotelState extends State<HotelCard> {
  List favorites=[];
  bool isFavorite=false;


  @override
  void initState() {
    // favorites= SharedPrefs().getFavorites();
    // SharedPrefs.clear();
  }


  Future<void> addFavorite(Map<String,dynamic> hotel) async {
    String currentUserId=AuthService().user?.uid??"";
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList(currentUserId)?? [];

    var encoded_hotel=jsonEncode(hotel);
    if(favorites.contains(encoded_hotel)){
    favorites.remove(encoded_hotel);
    isFavorite=false;
    }else{
      isFavorite=true;
      favorites.add(encoded_hotel);
    }
    print(favorites);
    await prefs.setStringList(currentUserId, favorites);
    setState(() {
      isFavorite=isFavorite;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size=widget.size;
    Hotel hotel = widget.hotel;
    Color defaultColor=widget.defaultColor;

    SharedPrefs().getFavorites().then((fav_hotels) {
             bool isFav= isFavorite=favorites.contains(jsonEncode(hotel.toJson()))?true :false;
      setState(() {
        favorites = [...fav_hotels];
        isFavorite=isFav;

      });
    });


    return Container(

      decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(15)),
      child: SizedBox(

        height: size.height * 0.59,
        width: size.width * 0.85,
        child: InkWell(

          onTap: () => Get.to(
                () => DetailsPage(
              hotel: hotel,
              size: size,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        hotel.img??"default.img",
                        fit: BoxFit.fill,
                        height: size.height * 0.3,
                        width: size.width * 0.85,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Container(
                            height: size.height * 0.3,
                            width: size.width * 0.85,
                            decoration: BoxDecoration(
                              color: defaultColor.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: SizedBox(
                              width: size.width * 0.7,
                              height: size.height * 0.3,
                              child: Align(
                                child: CircularProgressIndicator(
                                  color: defaultColor,
                                ),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: size.height * 0.3,
                            width: size.width * 0.85,
                            decoration: BoxDecoration(
                              color: defaultColor.withOpacity(0.1),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: SizedBox(
                              width: size.width * 0.7,
                              height: size.height * 0.3,
                              child: Align(
                                child: CircularProgressIndicator(
                                  color: defaultColor,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.01,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: size.width * 0.5,
                            child: Text(
                              hotel.name??"",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: GoogleFonts.lato(
                                color: defaultColor,
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.3,
                            child: Text(
                              hotel.location!.toUpperCase(),
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              style: GoogleFonts.lato(
                                color: defaultColor,
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: defaultColor,
                      height: size.height * 0.02,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${hotel.price} \Rs",
                          style: GoogleFonts.questrial(
                            color: Colors.indigo,
                            fontSize: size.height * 0.025,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          " per head",
                          style: GoogleFonts.questrial(
                            color: defaultColor,
                            fontSize: size.height * 0.022,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.star,
                          color: defaultColor,
                          size: size.height * 0.025,
                        ),
                        Text(
                          hotel.rating.toString(),
                          style: GoogleFonts.lato(
                            color: defaultColor,
                            fontSize: size.height * 0.022,
                          ),
                        ),
                      ],
                    )
                    ,
                    Divider(),
                    SizedBox(height: 2,),
                    Row(
                      children:[
                        Text("Capacity",style:TextStyle(fontWeight: FontWeight.w500),),
                        Spacer(),
                        Text("${hotel.capacity} Maximum"),
                      ],
                    ),
                    SizedBox(height: 3,),
                    Row(
                      children: [
                        Text("Services",style:TextStyle(fontWeight: FontWeight.w500),),
                        Spacer(),
                        Text(hotel.services!.join("|")),
                      ],
                    )
                    ,
                    SizedBox(height: 3,),
                    Divider(),
                    InkWell(
                      splashColor: Colors.grey,
                      splashFactory: InkRipple.splashFactory,
                      onTap: ()async{ await addFavorite(hotel.toJson());},
                      child: Row(

                        children: [
                          Text("Add to Favourites",
                            style: TextStyle(fontWeight: FontWeight.w500) ,),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : null,
                            ),
                            onPressed: () {},
                          )

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


HotelCard buildHotel(
  Hotel hotel,
  Color defaultColor,
  Size size,
) {
  return HotelCard(
    size: size,
    hotel: hotel,
    defaultColor: defaultColor,
  );

}
