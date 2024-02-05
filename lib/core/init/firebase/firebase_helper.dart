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
    // ignore: unused_local_variable
    final id = snapshot.docs.map((e) => e.id);

    /* QuerySnapshot querySnapshot = await rooms.get(); */

    final allRooms =
        snapshot.docs.map((doc) => RoomsModel.fromJson(doc.id.toString(), doc.data() as Map<String, dynamic>)).toList();
    return allRooms;
  }

  Future<void> sendMessage(String roomId, String content, String senderId) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Oluşturmak istediğiniz Message modeli
    Map<String, dynamic> messageData = {'content': content, 'senderId': senderId};

    // Belirli bir room dokümanını bulma ve messages dizisine yeni mesaj ekleyin
    DocumentReference roomRef = firestore.collection('rooms').doc(roomId);

    return firestore.runTransaction((transaction) async {
      DocumentSnapshot roomSnapshot = await transaction.get(roomRef);

      if (!roomSnapshot.exists) {
        throw Exception("Room not found!");
      }

      Map<String, dynamic> roomData = roomSnapshot.data() as Map<String, dynamic>;
      List<dynamic> messages = roomData['messages'] as List<dynamic>? ?? [];
      messages.add(messageData);

      transaction.update(roomRef, {'messages': messages});
    });
  }

  Stream<List<Message>> listenChat(String roomId) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference roomRef = firestore.collection('rooms').doc(roomId);

    return roomRef.snapshots().map((documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
        List<dynamic> messagesData = data['messages'] as List<dynamic>;
        return messagesData.map((msgData) => Message.fromJson(msgData as Map<String, dynamic>)).toList();
      } else {
        return [];
      }
    });
  }

  Future<void> createRoom(List<String> userIDs) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentReference room = await firestore.collection('rooms').add({'users': userIDs, 'messages': []});

    print('Oda başarıyla oluşturuldu: ${room.id}');
  }
}
