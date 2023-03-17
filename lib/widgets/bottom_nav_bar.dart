import 'package:evento/pages/bookings_list.dart';
import 'package:evento/pages/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:evento/pages/home_page.dart';
import 'package:evento/widgets/bottom_nav_item.dart';
import 'package:unicons/unicons.dart';

import '../pages/userInfo.dart';


Widget buildBottomNavBar(int currIndex, Size size, bool isDarkMode) {
  return BottomNavigationBar(
    iconSize: size.width * 0.08,
    elevation: 0,
    selectedLabelStyle: const TextStyle(fontSize: 8),
    unselectedLabelStyle: const TextStyle(fontSize: 0),
    currentIndex: currIndex,
    backgroundColor: const Color(0x00ffffff),
    type: BottomNavigationBarType.fixed,
    selectedItemColor: isDarkMode ? Colors.indigoAccent : Colors.black,
    unselectedItemColor: const Color(0xff3b22a1),
    onTap: (value) {
      if (value != currIndex) {
        if (value == 0) {
          Get.off(()=>HomePage());
        }
        if(value==1){
          Get.off(()=>FavoritesPage());
        }
        if(value==2){
          Get.off(()=> const BookingsList());
        }
        if(value==3){
          Get.off(()=>const UserInformationScreen());
        }
      }
    },
    items: [
      buildBottomNavItem(
        UniconsLine.home,
        isDarkMode,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.heart,
        isDarkMode,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.receipt,
        isDarkMode,
        size,
      ),
      buildBottomNavItem(
        UniconsLine.user,
        isDarkMode,
        size,
      ),
    ],
  );
}
