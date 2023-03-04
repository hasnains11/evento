// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Hotels.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
      json['uid'] as String?,
      json['name'] as String?,
      json['description'] as String?,
      json['price'] as int?,
      json['img'] as String?,
      json['capacity'] as int?,
      json['rating'] as int?,
      json['location'] as String?,
      (json['menus'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Menu.fromJson(e as Map<String, dynamic>)),
      ),
      (json['services'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['decorations'] as List<dynamic>)
          .map((e) => Decorations.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..bookingDates = (json['bookingDates'] as List<dynamic>)
        .map((e) => e as String)
        .toList();

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'img': instance.img,
      'capacity': instance.capacity,
      'rating': instance.rating,
      'location': instance.location,
      'menus': instance.menus,
      'services': instance.services,
      'decorations': instance.decorations,
      'bookingDates': instance.bookingDates,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      json['uid'] as String?,
      json['items'] as List<dynamic>,
      json['name'] as String,
      json['price'] as int?,
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'price': instance.price,
      'items': instance.items,
    };

Decorations _$DecorationsFromJson(Map<String, dynamic> json) => Decorations(
      json['uid'] as String?,
      json['name'] as String,
      json['charges'] as int,
    );

Map<String, dynamic> _$DecorationsToJson(Decorations instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'charges': instance.charges,
    };
