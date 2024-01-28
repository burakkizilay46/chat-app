// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/core/components/chat_bubble/chat_bubble_view.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';
import 'package:chat_app/providers/user/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/providers/room/model/room_model.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  final RoomsModel chats;

  ChatView({
    Key? key,
    required this.chats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentUserId = context.read<UserProvider>().currentUser!.uid.toString();
    String otherSenderId = '';
    for (var message in chats.messages) {
      if (message.senderId != currentUserId) {
        otherSenderId = message.senderId;
        break;
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            otherSenderId,
            style: context.normalTextStyle.copyWith(fontSize: 12),
          ),
        ),
        body: ListView.builder(
            itemCount: chats.messages.length,
            itemBuilder: (context, index) {
              return ChatBubble(
                  message: chats.messages[index].content,
                  isSender: context.read<UserProvider>().currentUser!.uid.toString() == chats.messages[index].senderId);
            }));
  }
}
