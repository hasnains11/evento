import 'package:evento/data/test.dart';
import 'package:evento/services/AuthService.dart';
import 'package:evento/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/bottom_nav_bar.dart';
import '../widgets/side_drawer.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  State<UserInformationScreen> createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {

  String? _gender;
  String? _name;
  String? _email;
  int? _age;


  @override
  void initState() {
    super.initState();
      get();
  }

  void get() async{
    var user=await FirestoreService().getUserData();
    print('current user id --------${AuthService().user?.uid}');
    print('current user  --------$user');
    setState(() {
    _gender=user?['gender'];
     _age=user?['age'];
    _email=user?['email'];
     _name=user?['name'];
     });

  }



  // Future<void> _showDeleteConfirmationDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Log Out!'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Are you sure you want to log out?'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('Confirm'),
  //             onPressed: () async {
  //               try {
  //                 await AuthService().SignOutUser();
  //                 Navigator.of(context).pop();
  //               } on FirebaseAuthException catch (e) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Text(e.message ?? 'An error occurred.'),
  //                   ),
  //                 );
  //               }
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),

      ),
      backgroundColor: Colors.white,
      drawer: SideDrawer(index: 3),
      bottomNavigationBar:  buildBottomNavBar(3,Get.size,true),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.arrow_back_ios,
            //           color: Colors.black,
            //         ),
            //       ),
            //       IconButton(
            //         onPressed: () {},
            //         icon: Icon(
            //           Icons.edit,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
SizedBox(height: Get.height*0.03),
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://media.istockphoto.com/id/1018999828/vector/default-'
                    'avatar-profile-icon-grey-photo-placeholder.jpg?s=170667a&w=0&k=20&c=7upvB0BLpwGo9SBabOx4jge8v-N4TSTMR_jxDJgWi_o='),
                radius: 80,
              ),
            ),
            SizedBox(height: Get.height*0.03),
            Center(
              child: Text(
                _name??"",
                style: TextStyle(
                  fontSize: Get.height *0.03,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: Get.height*0.03),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Email:',
                style: TextStyle(
                  fontSize: Get.height*0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: Get.height*0.008,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _email??"",
                style: TextStyle(
                  fontSize: Get.height*0.025,
                ),
              ),
            ),
            SizedBox(height: Get.height*0.02,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Gender:',
                style: TextStyle(
                  fontSize: Get.height*0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: Get.height*0.008,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _gender.toString().camelCase??"",
                style: TextStyle(
                  fontSize: Get.height*0.025,
                ),
              ),
            ),
            SizedBox(height: Get.height *0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Age:',
                style: TextStyle(
                  fontSize: Get.height*0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: Get.height *0.008),



            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _age.toString(),
                style: TextStyle(
                  fontSize: Get.height*0.025,
                ),
              ),
            ),
            // SizedBox(height: Get.height*0.1),
            Expanded(
              child: Container(),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     onPressed: () {
            //
            //       // _showDeleteConfirmationDialog();
            //     },
            //     child: Text(
            //       'Log Out',
            //       style: TextStyle(
            //         fontSize: 18,
            //       ),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       primary: Colors.redAccent,
            //       padding: EdgeInsets.symmetric(vertical: 16),
            //     ),
            //   ),
            // ),




          ],
        ),
      ),
    );
  }
}
