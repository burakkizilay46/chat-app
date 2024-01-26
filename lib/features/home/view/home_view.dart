import 'package:chat_app/core/base/view/base_view.dart';
import 'package:chat_app/core/components/chat_bubble/chat_bubble_view.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';
import 'package:chat_app/user/provider/chat_provider.dart';
import 'package:chat_app/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return BaseView(
      provider: UserProvider(),
      onProviderReady: (UserProvider provider) {
        provider.setContext(context);
        provider.init();
      },
      onPageBuilder: (UserProvider provider) => Scaffold(
        appBar: AppBar(
          title: Text(
            context.read<UserProvider>().currentUser!.displayName!.toLowerCase(),
            style: context.normalTextStyle.copyWith(fontSize: 14),
          ),
          actions: [
            CircleAvatar(
              radius: 24,
              child: ClipOval(
                child: Image.network(
                  context.read<UserProvider>().currentUser!.photoURL.toString(),
                  fit: BoxFit.cover, // You can adjust the BoxFit property as needed.
                ),
              ),
            ),
            IconButton(onPressed: () => context.read<UserProvider>().signOut(), icon: Icon(Icons.logout)),
            SizedBox(width: 8)
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
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
                      onPressed: () => context.read<ChatProvider>().sendMessage(_controller.text))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
