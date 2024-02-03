// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chat_app/core/base/view/base_view.dart';
import 'package:chat_app/core/components/chat_bubble/chat_bubble_view.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';
import 'package:chat_app/providers/chat/chat_provider.dart';
import 'package:chat_app/providers/user/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/providers/room/model/room_model.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  final RoomsModel chats;
  const ChatView({
    Key? key,
    required this.chats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    TextEditingController _controller = TextEditingController();

    void _scrollToBottom() {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }

    return BaseView(
      provider: ChatProvider(),
      onProviderReady: (ChatProvider provider) {
        provider.listenToMessages(chats.id);
      },
      onPageBuilder: (ChatProvider provider) {
        return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () => context.read<ChatProvider>().listenToMessages(chats.id), icon: Icon(Icons.refresh))
              ],
              title: Text(chats.id, style: context.normalTextStyle.copyWith(fontSize: 12)),
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Flexible(
                    flex: 88,
                    child: Consumer<ChatProvider>(
                      builder: (context, chatProvider, child) {
                        if (chatProvider.messages.isEmpty) {
                          // Liste boşsa gösterilecek widget
                          return Center(child: Text("Mesaj yok"));
                        }
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: chatProvider.messages.length,
                          itemBuilder: (context, index) {
                            var message = chatProvider.messages[index];
                            var isSender = context.read<UserProvider>().currentUser!.uid.toString() == message.senderId;
                            return ChatBubble(
                              message: message.content,
                              isSender: isSender,
                            );
                          },
                        );
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
                              context
                                  .read<ChatProvider>()
                                  .sendMessage(
                                      chats.id, _controller.text.trim(), context.read<UserProvider>().currentUser!.uid)
                                  .then((value) => _scrollToBottom);
                              _controller.clear();
                            },
                            icon: Icon(Icons.send))
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
