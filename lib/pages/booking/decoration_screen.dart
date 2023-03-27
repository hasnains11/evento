import 'package:evento/controllers/booking_controller.dart';
import 'package:evento/pages/booking/final_summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(DecorationScreen());
}

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
  List<Option> options = [
    Option(
      title: 'Decoration of hall',
      description:
          'Add beautiful decorations to the hall to create an elegant atmosphere.',
      price: 2000.0,
      subOptions: [
        SubOption(
          title: 'Balloon arches and columns',
          price: 5000.0,
        ),
        SubOption(
          title: 'Paper lanterns or string lights',
          price: 2500.0,
        ),
        SubOption(
          title: 'Floral arrangements and centerpieces',
          price: 8000.0,
        ),
      ],
    ),
    Option(
      title: 'Decoration of stage',
      description: 'Decorate the stage with flowers, curtains, and lighting.',
      price: 1500.0,
      subOptions: [
        SubOption(
          title: 'Flowers',
          price: 5000.0,
        ),
        SubOption(
          title: 'Curtains',
          price: 7500.0,
        ),
        SubOption(
          title: 'Lighting',
          price: 2500.0,
        ),
      ],
    ),
    Option(
      title: 'Table and chairs',
      description:
          'Choose the perfect tables and chairs to match your event theme.',
      price: 1000.0,
      subOptions: [
        SubOption(
          title: 'Round tables and chairs',
          price: 5000.0,
        ),
        SubOption(
          title: 'Rectangular tables and chairs',
          price: 7500.0,
        ),
      ],
    ),
    Option(
      title: 'Lighting',
      description:
          'Create a warm and inviting ambiance with the right lighting.',
      price: 5000.0,
      subOptions: [
        SubOption(
          title: 'Spotlight',
          price: 5000.0,
        ),
        SubOption(
          title: 'Chandelier',
          price: 7500.0,
        ),
        SubOption(
          title: 'Fairy lights',
          price: 2500.0,
        ),
      ],
    ),
    Option(
      title: 'Music system',
      description: 'Set the mood with the right music system and playlist.',
      price: 1000.0,
      subOptions: [
        SubOption(
          title: 'DJ',
          price: 5000.0,
        ),
        SubOption(
          title: 'Live band',
          price: 7500.0,
        ),
        SubOption(
          title: 'Karaoke',
          price: 2500.0,
        ),
      ],
    ),
    Option(
      title: 'Lighting',
      description:
          'Create a warm and inviting ambiance with the right lighting.',
      price: 5000.0,
      subOptions: [
        SubOption(
          title: 'Uplighting',
          price: 2500.0,
        ),
        SubOption(
          title: 'String lights',
          price: 3000.0,
        ),
        SubOption(
          title: 'Chandeliers',
          price: 4000.0,
        ),
      ],
    ),
    Option(
      title: 'Music System',
      description: 'Set the mood with the right music system and playlist.',
      price: 10000.0,
      subOptions: [
        SubOption(
          title: 'DJ services',
          price: 7500.0,
        ),
        SubOption(
          title: 'Live band',
          price: 1500.0,
        ),
        SubOption(
          title: 'Sound system rental',
          price: 5000.0,
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    totalPrice = bookingController.calculateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Decorations'),
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
                    'Choose your decorations',
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
