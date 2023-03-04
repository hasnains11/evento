import 'package:flutter/material.dart';
import 'package:evento/widgets/bottom_nav_bar.dart';
import 'package:evento/widgets/home/for_you.dart';
import 'package:evento/widgets/home/hotel_search.dart';
import 'package:evento/widgets/home/top_bar.dart';

import '../models/Hotels.dart';
import '../services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // var hotels=FirestoreService().getHotelList().then((value) => value.map((e){print(e.name);}));

  String? _location='Islamabad';

  _setLocation(String location){
    setState(() {
      _location=location;
    });
  }
  @override
  Widget build(BuildContext context) {



    Size size = MediaQuery.of(context).size; //check the size of device
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness ==
        Brightness.dark; //check if device is in dark or light mode
    Color defaultColor = isDarkMode ? Colors.white : Colors.black;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(title: Text("Home Screen"),),
      drawer: Drawer(child: Container(
              padding: EdgeInsets.only(top: 30),
          child: Column(children: [Text("Item 1")],))),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: buildBottomNavBar(0, size, !isDarkMode),
      body: Center(
        child: Container(
          height: size.height,
          width: size.height,
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xff06090d)
                : const Color(0xfff8f8f8), //background color
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.02,
                left: size.width * 0.05,
                right: size.width * 0.05,
              ),
              child: ListView(
                children: [

                  Divider(
                    color: defaultColor,
                    thickness: 0.25,
                    height: size.height * 0.035,
                  ),
                  buildCarousal(defaultColor, size),

                  Divider(
                    color: defaultColor,
                    thickness: 0.25,
                    height: size.height * 0.035,
                  ),
                  buildTopBar(defaultColor, size, _setLocation),
                  FutureBuilder<List<Hotel>>(
                      future: FirestoreService().getHotelbyLocation(_location??''),
                    builder: (context, snapshot) {
                      if(snapshot.hasError){
                        print(snapshot.error);
                        return const Center(child: Text("Something Went Wrong"),);
                      }
                      else if(snapshot.connectionState==ConnectionState.waiting){
                        return Center(child: const CircularProgressIndicator());
                      }
                      else if(snapshot.hasData){
                        var hotels= snapshot.data!.map((e) => e).toList();
                        // print(hotels[0]);
                        // print("snapshot Data:${snapshot.data}");
                        // print("hotels.element ${hotels.elementAt(0).name}");
                        // print(hotels.length);
                        return buildHotelSearch(defaultColor, size,hotels);

                        // hotels?.map((e) => print(e.name));
                        // hotels?.map((e) => print(e));
                        // return Text("Data Received");
                      }else{
                        return const Text("Unknown Error");
                      }
                    },


                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
