import 'package:chat_app/providers/friends/model/friends_model.dart';
import 'package:chat_app/providers/room/model/room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  Future<List<FirendsModel>> getUsers() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('/users');

    QuerySnapshot querySnapshot = await users.get();
    final allUsers =
        querySnapshot.docs.map((doc) => FirendsModel.fromJson(doc.data() as Map<String, dynamic>)).toList();

    // Burada allUsers değişkeni tüm kullanıcı verilerini içerir.
    return allUsers;
  }

  Future<List<RoomsModel>> getRooms(String userId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference rooms = firestore.collection('/rooms');

    QuerySnapshot snapshot = await rooms.where('users', arrayContains: userId).get();

    /* QuerySnapshot querySnapshot = await rooms.get(); */
    final allRooms = snapshot.docs.map((doc) => RoomsModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    return allRooms;
  }
}
