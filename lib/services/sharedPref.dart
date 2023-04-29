import 'package:shared_preferences/shared_preferences.dart';

import 'AuthService.dart';

class SharedPrefs{

  static clear(){
    SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
    });
  }

   getFavorites() async{
    String currentUserId=AuthService().user?.uid??"";
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(currentUserId)?? [];
  }

}