import 'dart:math';

import 'package:evento/models/rervation_model.dart';
import 'package:evento/pages/booking/menu_screen.dart';
import 'package:evento/services/AuthService.dart';
import 'package:evento/services/firestore.dart';
import 'package:get/get.dart';

import '../models/Hotels.dart';
import '../pages/booking/decoration_screen.dart';

class BookingController extends GetxController {
  Map bookingDetails = {};
  String shift = "";
  List<String> decorationList = [];
  int numberofguests = 0;
  Hotel? selectedHotel;
  List<Option> optionsWithSelectedSubOptions = [];
  int decorationBill = 0;
  MenuPackage menu =
      MenuPackage(name: "", description: "", price: 0, items: []);
  int totalPrice = 0;
  String bookingDate = "";

  addShift(String shift) {
    this.shift = shift;
    update();
  }

  addBookingDate(String date) {
    bookingDate = date;
    update();
  }

  void setDecorationBill(int bill) {
    decorationBill = bill;
    update();
  }

  calculateTotalPrice() {
    totalPrice = 0;
    totalPrice += menu.price.toInt() * numberofguests;
    totalPrice += decorationBill;
    update();
    return totalPrice.toInt();
  }

  void addNumberOfGuests(int number) {
    numberofguests = number;
    update();
  }

  addDecorationOptions(List<Option> options) {
    optionsWithSelectedSubOptions = options;
    update();
  }

  addSingleDecorationOption(Option option) {
    if (optionsWithSelectedSubOptions.contains(option)) {
      int index = optionsWithSelectedSubOptions.indexOf(option);
      optionsWithSelectedSubOptions[index] = option;
    } else {
      optionsWithSelectedSubOptions.add(option);
    }
    update();
  }

  double calculateDecorationBill() {
    int total = 0;
    optionsWithSelectedSubOptions.forEach((option) {
      if (option.subOptions != null) {
        List<SubOption> selectedSubOptions = option.subOptions!
            .where((subOption) => subOption.isSelected)
            .toList();
        if (selectedSubOptions.isNotEmpty) {
          selectedSubOptions.forEach((subOption) {
            total += subOption.price.toInt();
          });
        }
      }
    });
    return total.toDouble();
  }

  void addMenu(MenuPackage menuPackage) {
    menu = menuPackage;
    calculateTotalPrice();
    update();
  }

  void addCurrentHotel(Hotel hotel) {
    selectedHotel = hotel;
    update();
  }

  addItem(Map item) async {
    bookingDetails.addAll(item);
    update();
  }

  void removeSingleDecorationOption(Option option) {
    optionsWithSelectedSubOptions.remove(option);
    update();
  }

  List<Hotel> hotelList = [];
  setHotelList(List<Hotel> hotelList) {
    hotelList = hotelList;
    update();
  }

  createBooking() async {
    List<String> menuItems = menu.items.map((e) => e.toString()).toList();
    print("selected hotel id: ${selectedHotel!.uid}");
    print("selected hotel name: ${selectedHotel!.name}");
    ReservationModel reservationModel = ReservationModel(
        hotelId: selectedHotel!.uid.toString(),
        menu: menuItems,
        numberOfGuests: numberofguests,
        shift: shift,
        decorations: decorationList,
        eventType: bookingDetails["event"],
        id: Random().nextInt(100000).toString(),
        userId: AuthService().user!.uid,
        totalBill: totalPrice,
        bookingDate: bookingDate);
    await FirestoreService().createReservation(reservationModel);
  }
}
