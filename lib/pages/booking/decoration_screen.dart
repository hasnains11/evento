import 'package:evento/controllers/booking_controller.dart';
import 'package:evento/pages/booking/final_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// void main() {
//   runApp(DecorationScreen());
// }

class Option {
  final String title;
  final String description;
  final double price;
  bool isSelected;
  List<SubOption>? subOptions;

  Option({
    required this.title,
    required this.description,
    required this.price,
    this.isSelected = false,
    this.subOptions,
  });
}

class SubOption {
  final String title;
  final double price;
  bool isSelected;

  SubOption({
    required this.title,
    required this.price,
    this.isSelected = false,
  });
}

class DecorationScreen extends StatefulWidget {
  @override
  DecorationScreenState createState() => DecorationScreenState();
}

class DecorationScreenState extends State<DecorationScreen> {
  final bookingController = Get.find<BookingController>();
  List<Option> optionsWithSelectedSubOptions = [];
  int totalPrice = 0;
  static List<Option> getOptions(String eventType){

    switch(eventType){
      case 'Birthday':
        return [
          Option(
            title: 'Balloons',
            description: 'Add some festive balloon decorations to your party!',
            price: 500.0,
            subOptions: [
              SubOption(
                title: 'Balloon arch',
                price: 1000.0,
              ),
              SubOption(
                title: 'Balloon centerpieces',
                price: 750.0,
              ),
              SubOption(
                title: 'Balloon animals',
                price: 500.0,
              ),
            ],
          ),
          Option(
            title: 'Streamers and banners',
            description: 'Add some colorful streamers and banners to your party.',
            price: 250.0,
            subOptions: [
              SubOption(
                title: 'Happy Birthday banner',
                price: 500.0,
              ),
              SubOption(
                title: 'Personalized banner',
                price: 750.0,
              ),
              SubOption(
                title: 'Streamer backdrop',
                price: 250.0,
              ),
            ],
          ),
          Option(
            title: 'Tableware',
            description: 'Get some fun and festive tableware for your party.',
            price: 100.0,
            subOptions: [
              SubOption(
                title: 'Themed plates and cups',
                price: 250.0,
              ),
              SubOption(
                title: 'Paper napkins and straws',
                price: 100.0,
              ),
              SubOption(
                title: 'Tablecloth',
                price: 50.0,
              ),
            ],
          ),
          Option(
            title: 'Centerpieces',
            description: 'Add some beautiful centerpieces to your party tables.',
            price: 500.0,
            subOptions: [
              SubOption(
                title: 'Floral arrangement',
                price: 1000.0,
              ),
              SubOption(
                title: 'Candle centerpiece',
                price: 750.0,
              ),
              SubOption(
                title: 'Personalized photo centerpiece',
                price: 500.0,
              ),
            ],
          ),
          Option(
            title: 'Photo booth',
            description: 'Create some fun photo opportunities with a photo booth!',
            price: 1000.0,
            subOptions: [
              SubOption(
                title: 'Backdrop and props',
                price: 1500.0,
              ),
              SubOption(
                title: 'Instant photo printing',
                price: 1000.0,
              ),
              SubOption(
                title: 'Social media sharing',
                price: 500.0,
              ),
            ],
          ),
          Option(
            title: 'Party favors',
            description: 'Give your guests a special thank you with party favors.',
            price: 250.0,
            subOptions: [
              SubOption(
                title: 'Themed favors',
                price: 500.0,
              ),
              SubOption(
                title: 'Customized favors',
                price: 750.0,
              ),
              SubOption(
                title: 'DIY favor station',
                price: 250.0,
              ),
            ],
          ),
        ];
      case 'Wedding':
        return [Option(
          title: 'Floral Arrangements',
          description: 'Beautiful floral arrangements for the wedding ceremony and reception.',
          price: 5000.0,
          subOptions: [
            SubOption(
              title: 'Bridal Bouquet and Boutonnieres',
              price: 1500.0,
            ),
            SubOption(
              title: 'Ceremony Flowers',
              price: 2500.0,
            ),
            SubOption(
              title: 'Reception Centerpieces',
              price: 3500.0,
            ),
          ],
        ),
          Option(
            title: 'Photography and Videography',
            description: 'Capture all the special moments of your big day.',
            price: 8000.0,
            subOptions: [
              SubOption(
                title: 'Full-day Photography Coverage',
                price: 5000.0,
              ),
              SubOption(
                title: 'Full-day Videography Coverage',
                price: 5000.0,
              ),
              SubOption(
                title: 'Engagement Photoshoot',
                price: 1500.0,
              ),
            ],
          ),
          Option(
            title: 'Wedding Planning',
            description: 'Get help planning and coordinating your wedding.',
            price: 10000.0,
            subOptions: [
              SubOption(
                title: 'Full-Service Wedding Planning',
                price: 8000.0,
              ),
              SubOption(
                title: 'Day-of Coordination',
                price: 3000.0,
              ),
            ],
          ),
          Option(
            title: 'Catering',
            description: 'Delicious food and beverages for your wedding guests.',
            price: 12000.0,
            subOptions: [
              SubOption(
                title: 'Sit-Down Dinner',
                price: 8000.0,
              ),
              SubOption(
                title: 'Buffet Style Dinner',
                price: 5000.0,
              ),
              SubOption(
                title: 'Open Bar',
                price: 3000.0,
              ),
            ],
          ),
          Option(
            title: 'Wedding Cake',
            description: 'A beautiful and delicious wedding cake.',
            price: 2000.0,
            subOptions: [
              SubOption(
                title: '3-Tier Cake',
                price: 1500.0,
              ),
              SubOption(
                title: '4-Tier Cake',
                price: 2500.0,
              ),
              SubOption(
                title: 'Cake Topper',
                price: 500.0,
              ),
            ],
          ),
          Option(
            title: 'Transportation',
            description: 'Transportation for the wedding party and guests.',
            price: 5000.0,
            subOptions: [
              SubOption(
                title: 'Limousine Rental',
                price: 3000.0,
              ),
              SubOption(
                title: 'Vintage Car Rental',
                price: 2500.0,
              ),
              SubOption(
                title: 'Shuttle Bus Rental',
                price: 2000.0,
              ),
            ],
          )];
      case 'Seminars':
        return [
          Option(
            title: 'Backdrop',
            description:
            'Create a custom backdrop with your logo or event branding.',
            price: 1500.0,
            subOptions: [
              SubOption(
                title: 'Custom printed backdrop',
                price: 2500.0,
              ),
              SubOption(
                title: 'Pipe and drape backdrop',
                price: 1500.0,
              ),
              SubOption(
                title: 'Floral backdrop',
                price: 3500.0,
              ),
            ],
          ),
          Option(
            title: 'Stage design',
            description:
            'Design a stage to fit the theme of your seminar and enhance your speakers’ presentations.',
            price: 2000.0,
            subOptions: [
              SubOption(
                title: 'Podium and lectern',
                price: 1000.0,
              ),
              SubOption(
                title: 'Screen and projector',
                price: 3000.0,
              ),
              SubOption(
                title: 'Lighting',
                price: 2500.0,
              ),
            ],
          ),
          Option(
            title: 'Table centerpieces',
            description:
            'Add beautiful centerpieces to your tables to create a more inviting atmosphere.',
            price: 500.0,
            subOptions: [
              SubOption(
                title: 'Floral centerpieces',
                price: 1000.0,
              ),
              SubOption(
                title: 'Candle centerpieces',
                price: 750.0,
              ),
              SubOption(
                title: 'Custom table runners',
                price: 500.0,
              ),
            ],
          ),
          Option(
            title: 'Entryway decor',
            description:
            'Make a statement with entryway decor to welcome attendees to your seminar.',
            price: 1000.0,
            subOptions: [
              SubOption(
                title: 'Custom signage',
                price: 750.0,
              ),
              SubOption(
                title: 'Floral arrangements',
                price: 1500.0,
              ),
              SubOption(
                title: 'Balloon decor',
                price: 1000.0,
              ),
            ],
          ),
          Option(
            title: 'Table linens and chair covers',
            description:
            'Dress up your tables and chairs with elegant linens and covers.',
            price: 750.0,
            subOptions: [
              SubOption(
                title: 'Table linens',
                price: 500.0,
              ),
              SubOption(
                title: 'Chair covers',
                price: 500.0,
              ),
            ],
          ),



        ];
      case 'Concert':
        return [
          Option(
            title: 'Stage Decoration',
            description: 'Add decorations to the stage to enhance the concert experience.',
            price: 5000.0,
            subOptions: [
              SubOption(
                title: 'Backdrop',
                price: 2000.0,
              ),
              SubOption(
                title: 'Lighting',
                price: 3000.0,
              ),
              SubOption(
                title: 'Flowers',
                price: 4000.0,
              ),
            ],
          ),
          Option(
            title: 'Venue Decoration',
            description: 'Decorate the venue with appropriate decor to suit the concert theme.',
            price: 8000.0,
            subOptions: [
              SubOption(
                title: 'Balloon decorations',
                price: 3000.0,
              ),
              SubOption(
                title: 'Streamers and confetti',
                price: 2000.0,
              ),
              SubOption(
                title: 'Lighting',
                price: 5000.0,
              ),
              SubOption(
                title: 'Flowers',
                price: 6000.0,
              ),
            ],
          ),
          Option(
            title: 'Sound and Lighting',
            description: 'Set the right atmosphere with the perfect sound and lighting setup.',
            price: 10000.0,
            subOptions: [
              SubOption(
                title: 'Sound system rental',
                price: 5000.0,
              ),
              SubOption(
                title: 'Stage lighting',
                price: 5000.0,
              ),
            ],
          ),
          Option(
            title: 'Centerpiece Decoration',
            description: 'Create a focal point for the concert with a stunning centerpiece.',
            price: 3000.0,
            subOptions: [
              SubOption(
                title: 'Floral centerpieces',
                price: 2000.0,
              ),
              SubOption(
                title: 'Balloon centerpieces',
                price: 1500.0,
              ),
            ],
          ),
          Option(
            title: 'Entrance Decoration',
            description: 'Make a statement from the moment attendees arrive with a stunning entrance decoration.',
            price: 4000.0,
            subOptions: [
              SubOption(
                title: 'Red carpet',
                price: 1500.0,
              ),
              SubOption(
                title: 'Balloon arches',
                price: 2500.0,
              ),
              SubOption(
                title: 'Flower arrangements',
                price: 3500.0,
              ),
            ],
          ),
          Option(
            title: 'Table Decoration',
            description: 'Create an inviting atmosphere with beautiful table decor.',
            price: 2000.0,
            subOptions: [
              SubOption(
                title: 'Tablecloths and napkins',
                price: 1000.0,
              ),
              SubOption(
                title: 'Centerpieces',
                price: 1500.0,
              ),
            ],
          ),
          Option(
            title: 'Backdrop',
            description: 'Create a beautiful backdrop to set the scene for the concert.',
            price: 5000.0,
            subOptions: [
              SubOption(
                title: 'Flower wall',
                price: 3000.0,
              ),
              SubOption(
                title: 'Custom backdrop',
                price: 4000.0,
              ),
              SubOption(
                title: 'Themed backdrop',
                price: 4500.0,
              ),
            ],
          )


        ];
      default :
        return [];
    }


  }

   List<Option> options =[];

   // [
    // Option(
    //   title: 'Decoration of hall',
    //   description:
    //       'Add beautiful decorations to the hall to create an elegant atmosphere.',
    //   price: 2000.0,
    //   subOptions: [
    //     SubOption(
    //       title: 'Balloon arches and columns',
    //       price: 5000.0,
    //     ),
    //     SubOption(
    //       title: 'Paper lanterns or string lights',
    //       price: 2500.0,
    //     ),
    //     SubOption(
    //       title: 'Floral arrangements and centerpieces',
    //       price: 8000.0,
    //     ),
    //   ],
    // ),
    // Option(
    //   title: 'Decoration of stage',
    //   description: 'Decorate the stage with flowers, curtains, and lighting.',
    //   price: 1500.0,
    //   subOptions: [
    //     SubOption(
    //       title: 'Flowers',
    //       price: 5000.0,
    //     ),
    //     SubOption(
    //       title: 'Curtains',
    //       price: 7500.0,
    //     ),
    //     SubOption(
    //       title: 'Lighting',
    //       price: 2500.0,
    //     ),
    //   ],
    // ),
    // Option(
    //   title: 'Table and chairs',
    //   description:
    //       'Choose the perfect tables and chairs to match your event theme.',
    //   price: 1000.0,
    //   subOptions: [
    //     SubOption(
    //       title: 'Round tables and chairs',
    //       price: 5000.0,
    //     ),
    //     SubOption(
    //       title: 'Rectangular tables and chairs',
    //       price: 7500.0,
    //     ),
    //   ],
    // ),
    // Option(
    //   title: 'Lighting',
    //   description:
    //       'Create a warm and inviting ambiance with the right lighting.',
    //   price: 5000.0,
    //   subOptions: [
    //     SubOption(
    //       title: 'Spotlight',
    //       price: 5000.0,
    //     ),
    //     SubOption(
    //       title: 'Chandelier',
    //       price: 7500.0,
    //     ),
    //     SubOption(
    //       title: 'Fairy lights',
    //       price: 2500.0,
    //     ),
    //   ],
    // ),
    // Option(
    //   title: 'Music system',
    //   description: 'Set the mood with the right music system and playlist.',
    //   price: 1000.0,
    //   subOptions: [
    //     SubOption(
    //       title: 'DJ',
    //       price: 5000.0,
    //     ),
    //     SubOption(
    //       title: 'Live band',
    //       price: 7500.0,
    //     ),
    //     SubOption(
    //       title: 'Karaoke',
    //       price: 2500.0,
    //     ),
    //   ],
    // ),
    // Option(
    //   title: 'Lighting',
    //   description:
    //       'Create a warm and inviting ambiance with the right lighting.',
    //   price: 5000.0,
    //   subOptions: [
    //     SubOption(
    //       title: 'Uplighting',
    //       price: 2500.0,
    //     ),
    //     SubOption(
    //       title: 'String lights',
    //       price: 3000.0,
    //     ),
    //     SubOption(
    //       title: 'Chandeliers',
    //       price: 4000.0,
    //     ),
    //   ],
    // ),
    // Option(
    //   title: 'Music System',
    //   description: 'Set the mood with the right music system and playlist.',
    //   price: 10000.0,
    //   subOptions: [
    //     SubOption(
    //       title: 'DJ services',
    //       price: 7500.0,
    //     ),
    //     SubOption(
    //       title: 'Live band',
    //       price: 1500.0,
    //     ),
    //     SubOption(
    //       title: 'Sound system rental',
    //       price: 5000.0,
    //     ),
    //   ],
    // ),
  // ];

  @override
  void initState() {
    super.initState();
    totalPrice = bookingController.calculateTotalPrice();
    options=getOptions(bookingController.bookingDetails['event']);
    // options=getOptions("Concert");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Decorations"),
      ),
      bottomNavigationBar: Container(
        height: Get.height * 0.12,
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(children: [
              Text("Bill"),
              Spacer(),
              Text("Rs. ${totalPrice.toString()}"),
            ]),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // int total = 0;
                  // options.forEach((option) {
                  //   if (option.subOptions != null) {
                  //     List<SubOption> selectedSubOptions = option.subOptions!
                  //         .where((subOption) => subOption.isSelected)
                  //         .toList();
                  //     if (selectedSubOptions.isNotEmpty) {
                  //       selectedSubOptions.forEach((subOption) {
                  //         total += subOption.price.toInt();
                  //       });
                  //       optionsWithSelectedSubOptions.add(Option(
                  //         title: option.title,
                  //         description: option.description,
                  //         price: option.price,
                  //         isSelected: true,
                  //         subOptions: selectedSubOptions,
                  //       ));
                  //     }
                  //   }
                  // });
                  // // print(optionsWithSelectedSubOptions[0].subOptions![0].title);
                  // bookingController.setDecorationBill(total);
                  // bookingController.addDecorationOptions(options);

                  Get.to(() => FinalSummaryPage(
                      numberOfGuests: bookingController.numberofguests,
                      menuSelections: [...bookingController.menu.items],
                      decorationOptions: options,
                      reservationDate: bookingController.bookingDate,
                      shift: bookingController.shift,
                      totalBill: bookingController.calculateTotalPrice()));
                },
                child: Text(
                  'Next',
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Note: Decoration services are provided by third party vendors',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    '${bookingController.bookingDetails['event']} decorations',
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: options.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        options[index].title,
                        style: GoogleFonts.openSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      subtitle: Text(
                        options[index].description,
                        style: GoogleFonts.openSans(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    if (options[index].subOptions != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: options[index].subOptions!.length,
                          itemBuilder: (BuildContext context, int subIndex) {
                            return CheckboxListTile(
                              title: Text(
                                options[index].subOptions![subIndex].title,
                                style: GoogleFonts.openSans(
                                  fontSize: 16.0,
                                ),
                              ),
                              subtitle: Text(
                                'Rs. ${options[index].subOptions![subIndex].price}',
                                style: GoogleFonts.openSans(
                                  fontSize: 16.0,
                                  color: Colors.grey,
                                ),
                              ),
                              value: options[index]
                                  .subOptions![subIndex]
                                  .isSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  options[index]
                                      .subOptions![subIndex]
                                      .isSelected = value!;

                                  // totalPrice = calculateTotalPrice() + t;
                                  // int v = calculateTotalPrice();
                                });
                                int total = 0;
                                List<String> decorations = [];
                                options.forEach((option) {
                                  if (option.subOptions != null) {
                                    List<SubOption> selectedSubOptions = option
                                        .subOptions!
                                        .where(
                                            (subOption) => subOption.isSelected)
                                        .toList();
                                    if (selectedSubOptions.isNotEmpty) {
                                      selectedSubOptions.forEach((subOption) {
                                        decorations.add(subOption.title);
                                        total += subOption.price.toInt();
                                      });
                                      optionsWithSelectedSubOptions.add(Option(
                                        title: option.title,
                                        description: option.description,
                                        price: option.price,
                                        isSelected: true,
                                        subOptions: selectedSubOptions,
                                      ));
                                    }
                                  }
                                });
                                // print(optionsWithSelectedSubOptions[0].subOptions![0].title);
                                bookingController.setDecorationBill(total);
                                bookingController.addDecorationOptions(options);
                                bookingController.decorationList = decorations;
                                int t = bookingController.calculateTotalPrice();
                                setState(() {
                                  totalPrice = t;
                                });
                                print(
                                    "total price is $t,  decoration price is $total ");
                                // if (value == true) {
                                //   setState(() {
                                //     priceMap.add(Map.from({
                                //       options[index]
                                //               .subOptions![subIndex]
                                //               .title:
                                //           options[index]
                                //               .subOptions![subIndex]
                                //               .price
                                //               .toInt()
                                //     }));
                                //   });
                                // } else {
                                //   setState(() {
                                //     priceMap.removeWhere((element) =>
                                //         element.containsKey(options[index]
                                //             .subOptions![subIndex]
                                //             .title));
                                //   });
                                // }
                              },
                            );
                          },
                        ),
                      ),
                    SizedBox(height: 16.0),
                  ],
                );
              },
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

// import 'package:evento/pages/booking/final_summary.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
//
// class Option {
//   final String title;
//   final String description;
//   final int price;
//   bool isSelected;
//
//   Option({required this.title, required this.description,required this.price, this.isSelected = false});
// }
//
//
// class DecorationScreen extends StatefulWidget {
//   @override
//   State<DecorationScreen> createState() => _DecorationScreenState();
// }
//
// class _DecorationScreenState extends State<DecorationScreen> {
//   List<Option> options = [
//     Option(
//       title: 'Decoration of stage',
//       description: 'Decorate the stage with flowers, curtains, and lighting.',
//       price: 1000,
//     ),
//     Option(
//       title: 'Decoration of hall',
//       description: 'Add beautiful decorations to the hall to create an elegant atmosphere.',
//       price: 1000,
//
//     ),
//     Option(
//       title: 'Table and chairs',
//       description: 'Choose the perfect tables and chairs to match your event theme.',
//       price: 1000,
//
//     ),
//     Option(
//       title: 'Lighting',
//       description: 'Create a warm and inviting ambiance with the right lighting.',
//       price: 1000,
//     ),
//
//     Option(
//       title: 'Music system',
//       description: 'Set the mood with the right music system and playlist.',
//       price: 1000,)
//   ];
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event Options'),
//         centerTitle: true,
//       ),
//
//       bottomNavigationBar: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: ElevatedButton(
//           onPressed: () {
//             // Navigate to next screen
//             Get.to(()=> FinalSummaryPage(numberOfGuests: 123,menuSelections:["menu1","menu2"],decorationOptions:["Decoration1","Decoration2"],reservationDate: "12-oct-2023",shift: "Day",totalBill: 123123,));
//           },
//           child: Text('Next'),
//         ),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.deepPurple.shade700, Colors.deepPurpleAccent.shade400],
//           ),
//         ),
//         child: ListView.builder(
//           itemCount: options.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Card(
//               elevation: 8,
//               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//               child: Column(
//                 children: [
//                   ListTile(
//                     contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     title: Text(
//                       options[index].title,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Padding(
//                       padding: const EdgeInsets.only(top: 3.0),
//                       child: Text(options[index].description),
//                     ),
//                     trailing: Checkbox(
//                       value:options[index].isSelected,
//                       onChanged:(bool? value) {
//                         setState(() {
//                           options[index].isSelected = value ?? false;
//                         });
//                       },
//
//                     ),
//                   ),
//                   Divider(height: 1,),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 18.0, right: 18,top: 8,bottom: 10),
//                     child: Row(
//
//                       children: [
//                         Text("Charges:",
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black,
//                           ),),
//                         Spacer(),
//                         Text(options[index].price.toString(),style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),),
//                       ],
//                     ),
//                   ),
//
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//       );
//   }
// }
