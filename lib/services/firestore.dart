import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evento/models/Hotels.dart';
import 'package:evento/services/AuthService.dart';

class FirestoreService {

  FirebaseFirestore _db = FirebaseFirestore.instance;

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

  Future<List<Hotel>> getHotelbyLocation(String location) async {
    var ref = _db.collection('hotels').where('location',isEqualTo: location);
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
    var ref = _db.collection('hotels').doc(id);
    var snapshot = await ref.get();
    var data = snapshot.data();
    var hotel = Hotel.fromJson(data!);
    return hotel;
  }


  createBooking(Booking booking) async{
    var ref = _db.collection('bookings').doc();
    var hotelRef= _db.collection('hotels').doc(booking.hotel?.uid);

    var newBooking = {
      'id': ref.id,
      'userId': booking.userId,
      'hotelId': booking.hotel?.uid,
      'eventType': booking.eventType,
      'hotelName': booking.hotel?.name,
      'decorationType': booking.decorationType,
      'bookingDate': booking.date,
      'numberOfGuests': booking.numberOfPersons,
      'totalBill':booking.totalBill,
    };


// Add a new document to the collection with a unique ID
    await hotelRef.update({'bookingDates':FieldValue.arrayUnion([booking.date])});
    await ref
        .set(newBooking)
        .then((value) => print("Document added successfully."))
        .catchError((error) => print("Failed to add document: $error"));
  }

}
