// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/core/components/chat_bubble/chat_bubble_view.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';
import 'package:chat_app/providers/user/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/providers/room/model/room_model.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  final RoomsModel chats;

  ChatView({
    Key? key,
    required this.chats,
  }) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    var currentUserId = context.read<UserProvider>().currentUser!.uid.toString();
    String otherSenderId = '';
    for (var message in widget.chats.messages) {
      if (message.senderId != currentUserId) {
        otherSenderId = message.senderId;
        break;
      }
    }
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: Icon(Icons.refresh))
          ],
          title: Text(
            widget.chats.id,
            style: context.normalTextStyle.copyWith(fontSize: 12),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                flex: 88,
                child: ListView.builder(
                    itemCount: widget.chats.messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                          message: widget.chats.messages[index].content,
                          isSender: context.read<UserProvider>().currentUser!.uid.toString() ==
                              widget.chats.messages[index].senderId);
                    }),
              ),
              Flexible(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: TextField(
                          decoration: InputDecoration(
                              label: Text('Mesaj'),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(100))),
                        ),
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.send))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
