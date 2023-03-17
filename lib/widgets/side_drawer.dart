import 'package:evento/pages/userInfo.dart';
import 'package:evento/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../pages/bookings_list.dart';
import '../pages/favorites_page.dart';
import '../pages/home_page.dart';

class SideDrawer extends StatefulWidget {
  int index;
   SideDrawer({Key? key,required this.index}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: Get.width * 0.7,
      child: Drawer(
        child: Container(
          color: Colors.blueGrey[800],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: Get.height * 0.08),
              Text('Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Get.height * 0.03,
                    fontWeight: FontWeight.bold,
                  )),
              Divider(
                color: Colors.white,
                thickness: 1,
              ),
              SizedBox(height: Get.height * 0.03),
              Material(
                color: widget.index==0?Colors.blueGrey[400]:Colors.blueGrey[800],
                child: InkWell(
                  onTap: () {
                      // Navigate to the favorites screen
                    Get.off(() => HomePage());
                    },
                    splashColor: Colors.white,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.height * 0.019,
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                color:  widget.index==1?Colors.blueGrey[400]:Colors.blueGrey[800],
                child: InkWell(
                  onTap: () {
                      // Navigate to the favorites screen
                    Get.off(()=>FavoritesPage());
                    },
                    splashColor: Colors.white,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: Icon(
                      Icons.favorite,
                      color: Colors.red[400],
                    ),
                    title: Text(
                      "Favorites",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.height * 0.019,
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                color: widget.index==2?Colors.blueGrey[400]:Colors.blueGrey[800],
                child: InkWell(
                  onTap: () {
                      // Navigate to the favorites screen
                    Get.off(()=> BookingsList());
                    },
                    splashColor: Colors.white,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: Icon(
                      Icons.book,
                      color: Colors.blueAccent[200],
                    ),
                    title: Text(
                      "Bookings",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.height * 0.022,
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                color: widget.index==3?Colors.blueGrey[400]:Colors.blueGrey[800],
                child: InkWell(
                  onTap: () {
                    Get.off(()=> UserInformationScreen());
                      },
                    splashColor: Colors.white,
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: Icon(
                      Icons.person,
                      color: Colors.deepPurple[300],
                    ),
                    title: Text(
                      "User Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Get.height * 0.022,
                      ),
                    ),
                  ),
                ),
              ),



              const Spacer(),

              // SizedBox(height: Get.height * 0.02),
              Material(
                color: Colors.blueGrey[800],

                child: InkWell(
                  onTap: () async{
                    // Perform logout
                    await AuthService().SignOutUser();
                    await Future.delayed(Duration(seconds: 1));
                  Get.offAllNamed('/');
                  },
                  splashColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: Get.height * 0.02 ),
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        SizedBox(width: Get.height * 0.02 ),
                        Text(
                          "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Get.height * 0.018,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
