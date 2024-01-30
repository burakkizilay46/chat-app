// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/core/components/chat_bubble/chat_bubble_view.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';
import 'package:chat_app/providers/chat/chat_provider.dart';
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
    TextEditingController _controller = TextEditingController();
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
                onPressed: () => context.read<ChatProvider>().listenToMessages(widget.chats.id),
                icon: Icon(Icons.refresh))
          ],
          title: Text(widget.chats.id, style: context.normalTextStyle.copyWith(fontSize: 12)),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                flex: 88,
                child: Consumer<ChatProvider>(
                  builder: (context, chatProvider, child) {
                    return ListView.builder(
                        itemCount: chatProvider.messages.length,
                        itemBuilder: (context, index) {
                          var message = chatProvider.messages[index];
                          var isSender = context.read<UserProvider>().currentUser!.uid.toString() == message.senderId;

                          return ChatBubble(
                            message: message.content,
                            isSender: isSender,
                          );
                        });
                  },
                ),
              ),
              Flexible(
                flex: 10,
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              label: Text('Mesaj'),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(100))),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          context.read<ChatProvider>().sendMessage(
                              widget.chats.id, _controller.text.trim(), context.read<UserProvider>().currentUser!.uid);
                          _controller.clear();
                          setState(() {});
                        },
                        icon: Icon(Icons.send))
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
