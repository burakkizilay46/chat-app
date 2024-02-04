import 'package:chat_app/providers/user/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDatabase {
  Future<void> addUser(User userData) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users
        .doc(userData.uid) // Belirli bir userId ile doküman oluşturabilirsiniz.
        .set({
          'userId': userData.uid,
          'photoURL': userData.photoURL
        }) // userData, eklenecek kullanıcı verilerini içeren bir Map olmalı.
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      // Firestore'dan 'users' koleksiyonunu sorgula
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();

      // Belge listesini UserModel listesine dönüştür
      List<UserModel> users = querySnapshot.docs.map((doc) {
        // Her belgeyi UserModel'e dönüştür
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return users;
    } catch (e) {
      print(e);
      return []; // Hata durumunda boş bir liste dön
    }
  }
}
