import 'package:chat_app/core/base/view/base_view.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';
import 'package:chat_app/core/init/firebase/firebase_helper.dart';

import 'package:chat_app/providers/friends/friends_provider.dart';
import 'package:chat_app/providers/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      provider: UserProvider(),
      onProviderReady: (UserProvider provider) {
        provider.setContext(context);
        provider.init();
        context.read<FriendsProvider>().init();
      },
      onPageBuilder: (UserProvider provider) => Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () async {
            FirebaseHelper().getRooms();
          }),
          appBar: AppBar(
            title: Text(
              context.read<UserProvider>().currentUser!.uid.toLowerCase(),
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
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: context.watch<FriendsProvider>().rooms.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => context.read<FriendsProvider>().navigateToChatView(),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        '${context.watch<FriendsProvider>().rooms[index]}',
                        style: context.normalTextStyle.copyWith(fontSize: 14),
                      ),
                    ),
                  ),
                );
              },
            ),
          ))),
    );
  }
}
