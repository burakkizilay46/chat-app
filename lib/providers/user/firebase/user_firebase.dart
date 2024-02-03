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
}
