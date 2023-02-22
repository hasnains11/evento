import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evento/models/Hotels.dart';

class FirestoreService{

  FirebaseFirestore _db=FirebaseFirestore.instance;

  Future<List<Hotel>> getHotelList() async{
    var ref=_db.collection('hotels');
    var snapshot=await ref.get();
    var data= snapshot.docs.map((s)=>s.data());
    var hotels=data.map((e) => Hotel.fromJson(e));
    // print(hotels.toList().first.name);
    // print(hotels.toList().first.decorations);
    // print(hotels.toList().first.capacity);
    // print(hotels.toList().first.description);
    // print(hotels.toList().first.img);
    // print(hotels.toList().first.menu);
    // print(hotels.toList().first.price);

    return hotels.toList();
  }

}
