class ReservationModel {
  String id;
  String bookingDate;
  String shift;
  int numberOfGuests;
  List<String> menu;
  List<String> decorations;
  String eventType;
  int totalBill;
  String userId;
  String hotelId;

  ReservationModel({
    required this.id,
    required this.bookingDate,
    required this.numberOfGuests,
    required this.menu,
    required this.decorations,
    required this.eventType,
    required this.totalBill,
    required this.userId,
    required this.shift,
    required this.hotelId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shift': shift,
      'bookingDate': bookingDate,
      'numberOfGuests': numberOfGuests,
      'menu': menu,
      'decorations': decorations,
      'eventType': eventType,
      'totalBill': totalBill,
      'userId': userId,
      'hotelId': hotelId,
    };
  }
}
