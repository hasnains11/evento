import 'package:evento/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    return Scaffold(
       backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Select City'),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SizedBox(
          height: Get.height*0.8,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Expanded(
                child: Card(
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  margin: EdgeInsets.all(16.0),
                  elevation: 8.0,
                  child: InkWell(
                    onTap: () {
                      // Add action when card is tapped
                      Get.to(()=>HomePage(),arguments:{"location":"Islamabad",...Get.arguments});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                          image: AssetImage('assets/Islamabad.jpeg'),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.9),BlendMode.difference),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'View Hotels in Islamabad',
                              style: TextStyle(
                                fontSize: Get.height*0.03,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                backgroundColor: Colors.black.withOpacity(0.16),
                              ),

                            ),
                            SizedBox(height: Get.height*0.01,),
                            Text("click here to view hotels",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: Get.height*0.014,
                              backgroundColor: Colors.black.withOpacity(0.16),
                            ),

                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  margin: EdgeInsets.all(16.0),
                  elevation: 8.0,
                  child: InkWell(
                    onTap: () {
                      // Add action when card is tapped
                      Get.to(()=>HomePage(),arguments:{"location":"Rawalpindi",...Get.arguments});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                          image: AssetImage('assets/rawalpindi.jpg'),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.9), BlendMode.difference),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'View Hotels in Rawalpindi',
                              style: TextStyle(
                                fontSize: Get.height*0.03,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                backgroundColor: Colors.black.withOpacity(0.16),
                              ),

                            ),
                            SizedBox(height: Get.height*0.01,),
                            Text("click here to view hotels",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: Get.height*0.014,
                              backgroundColor: Colors.black.withOpacity(0.16),
                            ),

                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Card(
              //     margin: EdgeInsets.all(16.0),
              //     elevation: 8.0,
              //     child: InkWell(
              //       onTap: () {
              //         // Add action when card is tapped
              //       },
              //       child: Container(
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(14),
              //           image: DecorationImage(
              //             image: AssetImage('assets/rawalpindi.jpg'),
              //             fit: BoxFit.cover,
              //           ),
              //         ),
              //         child: Center(
              //           child: Text(
              //             'Rawalpindi',
              //             style: TextStyle(
              //               fontSize: 24.0,
              //               fontWeight: FontWeight.bold,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
