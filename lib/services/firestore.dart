import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evento/models/Hotels.dart';
import 'package:evento/models/rervation_model.dart';
import 'package:evento/services/AuthService.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  deleteCurrentUserFromFirestore() async {
    await _db.collection("users").doc(AuthService().user!.uid).delete();
  }

  deleteBooking(String bookingId, String hotelId, String date) async {
    var bookings = await _db
        .collection("bookings")
        .where("id", isEqualTo: bookingId)
        .get();
    bookings.docs.forEach((element) async {
      await element.reference.delete();
    });
    print("deleted");
  }

  createReservation(ReservationModel reservation) {
    _db.collection("bookings").add(reservation.toJson());
  }

  getBookings() async {
    var ref = _db
        .collection('bookings')
        .where('userId', isEqualTo: AuthService().user!.uid);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((b) => b.data());
    // print(data);
    var bookings = data
        .map((e) => {
              "id": e['id'],
              "bookingDate": e['bookingDate'],
              "numberofPerson": e['numberOfGuests'],
              "decorationType": e['decorationType'],
              "eventType": e['eventType'],
              'totalBill': e['totalBill'],
              'userId': e['userId'],
              "hotelId": e['hotelId'],
              "shift": e['shift'],
            })
        .toList();
    print("egheg--$bookings");

    for (var i = 0; i < bookings.length; i++) {
      var hotel = await getHotelByID(bookings[i]['hotelId']);
      print(hotel.toString());
      bookings[i].addAll({
        "hotelName": hotel.name,
        "hotelImg": hotel.img,
        "hotelLocation": hotel.location,
        "hotelPrice": hotel.price,
        "hotelCapacity": hotel.capacity,
        "hotelRating": hotel.rating,
        "hotelDescription": hotel.description,
      });
    }
    print(bookings);
    // await bookings.map((e)async => await getHotelByID(e['hotelId']).then((value) {
    // print("corresponding hotel");
    // print(value.toString());
    // }));
    return bookings;
  }
  // await  bookings.map((b) async{
  //   await getHotelByID(b['hotelId']).
  //   then((Hotel hotel) {
  //       print(hotel);
  //       var hotelData = {
  //         "hotelName":hotel.name,
  //         "hotelImg":hotel.img,
  //         "hotelLocation":hotel.location,
  //         "hotelPrice":hotel.price,
  //         "hotelCapacity":hotel.capacity,
  //         "hotelRating":hotel.rating,
  //         "hotelDescription":hotel.description,
  //       };
  //       b.addAll(hotelData);
  //       return b;
  //   });
  // bookings.add({});

  // print(bookings);

  // }

  Future<List<Hotel>> getHotelList() async {
    var ref = _db.collection('hotels');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var hotels = data.map((e) => Hotel.fromJson(e));
    // print(hotels.toList().first.name);
    // print(hotels.toList().first.decorations);
    // print(hotels.toList().first.capacity);
    // print(hotels.toList().first.description);
    // print(hotels.toList().first.img);
    // print(hotels.toList().first.menu);
    // print(hotels.toList().first.price);

    return hotels.toList();
  }

  Future<List<Hotel>> getHotelbyLocation(String location, String event) async {
    var ref = _db
        .collection('hotels')
        .where('location', isEqualTo: location)
        .where('services', arrayContains: event);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var hotels = data.map((e) => Hotel.fromJson(e));

    print("location:$location");
    // print(hotels.toList().first.name);
    // print(hotels.toList().first.decorations);
    // print(hotels.toList().first.capacity);
    // print(hotels.toList().first.description);
    // print(hotels.toList().first.img);
    // print(hotels.toList().first.menu);
    // print(hotels.toList().first.price);

    return hotels.toList();
  }

  getHotelByID(String id) async {
    var ref = _db.collection('hotels').where('uid', isEqualTo: id);
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data()).first;
    var hotel = Hotel.fromJson(data);
    return hotel;
  }

  Future<Map<String, dynamic>?> getUserData() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('users').doc(AuthService().user?.uid).get();
    print(snapshot['name']);
    return snapshot.data();
    // {
    // 'name': snapshot['name'],
    // 'email': snapshot['email'],
    // 'gender': snapshot['gender'],
    // 'age': snapshot['age']
    // };
  }

  // createBooking(Map<String, dynamic> booking) async {
  //   var ref = _db.collection('bookings').doc();
  //   var hotelRef = _db.collection('hotels').doc(booking.hotel?.uid);
  //
  //   var newBooking = {
  //     'id': ref.id,
  //     'userId': booking.userId,
  //     'hotelId': booking.hotel?.uid,
  //     'eventType': booking.eventType,
  //     'hotelName': booking.hotel?.name,
  //     'decorationType': booking.decorationType,
  //     'bookingDate': booking.date,
  //     'numberOfGuests': booking.numberOfPersons,
  //     'totalBill': booking.totalBill,
  //   };
  //
  //   await ref
  //       .set(newBooking)
  //       .then((value) => print("Document added successfully."))
  //       .catchError((error) => print("Failed to add document: $error"));
  // }
}
