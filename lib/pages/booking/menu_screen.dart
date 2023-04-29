import 'package:evento/controllers/booking_controller.dart';
import 'package:evento/pages/booking/decoration_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/Hotels.dart';

class MenuPackage {
  final String name;
  final String description;
  final double price;
  final List items;

  MenuPackage(
      {required this.name,
      required this.description,
      required this.price,
      required this.items});
}

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late MenuPackage _selectedPackage;
  final bookingController = Get.find<BookingController>();

  late List<MenuPackage> packages;

  // setPackages() {
  //   return hotel.menus.entries.map((menu) => MenuPackage(name:hotel.menus[menu]!.name ,
  //       description: "hotel.menus[menu]!", price: hotel.menus[menu]!.price!.toDouble(), items: hotel.menus[menu]!.items)).toList();
  //
  // }

  @override
  void initState() {
    super.initState();

    Hotel hotel = bookingController.selectedHotel!;
    // List<Menu?> menus=hotel.menus.entries.map((e) => hotel.menus[e]).toList();

    // packages=hotel.menus.entries.map((menu) => MenuPackage(name:hotel.menus[menu]?.name??"" ,
    //        description: "hotel.menus[menu]!", price: hotel.menus[menu]?.price!.toDouble(), items: hotel.menus[menu]?.items??[])).toList();
    var menus = hotel.menus.map((key, value) => MapEntry(
        key,
        MenuPackage(
            name: value.name,
            description: "",
            price: value.price!.toDouble(),
            items: value.items)));
    // print(menus.map((key, value) =>MapEntry(key,MenuPackage(name:value.name,description:"value.description",price:value.price!.toDouble(),items:value.items))));
    print(hotel.name);
    packages = menus.values.toList();
    _selectedPackage = packages.first;
  }

  void _selectPackage(MenuPackage package) {
    setState(() {
      _selectedPackage = package;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Food Menu Package"),
      ),
      body: ListView.builder(
        itemCount: packages.length,
        itemBuilder: (BuildContext context, int index) {
          final package = packages[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            color: _selectedPackage == package ? Colors.blue[100] : null,
            child: InkWell(
              onTap: () => _selectPackage(package),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package.name,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      package.description,
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      "Rs.${package.price.toInt().toString()}",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      "Included Items:",
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          package.items.map((item) => Text(item)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.all(8.0),
          height: Get.height * 0.12,
          width: Get.width,
          child: Column(
            children: [
              Row(children: [
                Text("Bill:"),
                Spacer(),
                Text(
                    "Rs.${_selectedPackage.price * bookingController.numberofguests}"),
              ]),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Continue button pressed
                    bookingController.addMenu(_selectedPackage);
                    Get.to(() => DecorationScreen());
                  },
                  child: Text("Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
