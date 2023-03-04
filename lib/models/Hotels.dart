import 'package:json_annotation/json_annotation.dart';

part 'Hotels.g.dart';

@JsonSerializable()
class Hotel {
  String? uid;
  String? name;
  String? description;
  int? price;
  String? img;
  int? capacity;
  int? rating;
  String? location;
  Map<String,Menu> menus;
  List<String>? services;
  List<Decorations> decorations;
  List<String> bookingDates=[];

  Hotel(
      this.uid,
      this.name,
      this.description,
      this.price,
      this.img,
      this.capacity,
      this.rating,
      this.location,
      this.menus,
      this.services,
      this.decorations);

  factory Hotel.fromJson(Map<String, dynamic> json) => _$HotelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelToJson(this);
}

@JsonSerializable()
class Menu {
  String? uid;
  String name;
  int? price;
  List items = [];
  Menu(this.uid, this.items,this.name,this.price);
  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
@JsonSerializable()
class Decorations {
  String? uid;
  String name;
  int charges;

  Decorations(this.uid, this.name,this.charges);
  factory Decorations.fromJson(Map<String, dynamic> json) => _$DecorationsFromJson(json);

  Map<String, dynamic> toJson() => _$DecorationsToJson(this);
}

class Booking {
  static int _maxId = 0;

  int? id;
  Hotel? hotel;
  String date;
  int numberOfPersons;
  String decorationType;
  String eventType;
  Menu menu;
  int totalBill;
  String userId;

  Booking({
    required this.date,
    required this.numberOfPersons,
    required this.decorationType,
    required this.eventType,
    required this.menu,
    required this.hotel,
    required this.totalBill,
    required this.userId,
  }) : id = ++_maxId {
    if (numberOfPersons <= 0) {
      throw ArgumentError('Number of persons must be greater than zero.');
    }
    if (menu.items.isEmpty || menu == null){
      throw ArgumentError('Menu must not be empty.');
    }
  }
}


// part 'booking.g.dart';
//
// @JsonSerializable()
// class Booking {
//   int id;
//   DateTime date;
//   int numberOfPersons;
//   String decorationType;
//   String eventType;
//   List<String> menu;
//
//   Booking({
//     required this.date,
//     required this.numberOfPersons,
//     required this.decorationType,
//     required this.eventType,
//     required this.menu,
//   }) : id = 0;
//
//   factory Booking.fromJson(Map<String, dynamic> json) =>
//       _$BookingFromJson(json);
//   Map<String, dynamic> toJson() => _$BookingToJson(this);
// }



