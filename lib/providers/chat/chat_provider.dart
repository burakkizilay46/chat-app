import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:flutter/material.dart';

class ChatProvider extends BaseProvider with ChangeNotifier {
  @override
  void init() {
    // TODO: implement init
  }

  @override
  void setContext(BuildContext context) {
    // TODO: implement setContext
  }
  final List<String> _messages = [];
  List<String> get messages => _messages;

  void sendMessage(String message) {
    _messages.add(message);
    notifyListeners();
  }
}
