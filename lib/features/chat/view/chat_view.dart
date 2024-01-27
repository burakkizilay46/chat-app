import 'package:chat_app/core/components/chat_bubble/chat_bubble_view.dart';
import 'package:chat_app/providers/user/provider/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = new ScrollController();

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      final bottomOffset = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(
        bottomOffset,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: context.watch<ChatProvider>().messages.length,
            itemBuilder: (context, index) {
              var alignment = index % 2 == 0 ? Alignment.centerRight : Alignment.centerLeft;
              return ChatBubble(message: context.watch<ChatProvider>().messages[index], isSender: index % 2 == 0);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                ),
              ),
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    context.read<ChatProvider>().sendMessage(_controller.text.trim());
                    scrollToBottom();
                  })
            ],
          ),
        ),
      ],
    );
  }
}
