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
