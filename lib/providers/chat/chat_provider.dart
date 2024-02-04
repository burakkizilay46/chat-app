import 'dart:async';

import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/init/firebase/firebase_helper.dart';
import 'package:chat_app/providers/room/model/room_model.dart';
import 'package:flutter/material.dart';

class ChatProvider extends BaseProvider with ChangeNotifier {
  @override
  void init() {}

  @override
  void setContext(BuildContext context) {
    // TODO: implement setContext
  }

  StreamSubscription<List<Message>>? _chatSubscription;
  List<Message> _messages = [];
  List<Message> get messages => _messages;
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void listenToMessages(String roomId) async {
    _chatSubscription?.cancel(); // Önceki dinleyici varsa iptal et
    _chatSubscription = FirebaseHelper().listenChat(roomId).listen((newMessages) {
      _messages = newMessages;
      notifyListeners();
      if (_messages.isNotEmpty) {
        _isLoading = false;
        notifyListeners();
      }
    });
  }

  Future<void> sendMessage(String roomId, String content, String senderId) async {
    await FirebaseHelper().sendMessage(roomId, content, senderId);
    notifyListeners();
  }
}


 /* FirebaseFirestore.instance.collection('rooms').doc(roomId).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;
        List<dynamic> messagesData = data['messages'] as List<dynamic>? ?? [];
        _messages = messagesData.map((msgData) => Message.fromJson(msgData as Map<String, dynamic>)).toList();
        notifyListeners(); // Tüketicilere veri güncellendiğini bildir
      }
    }); */
