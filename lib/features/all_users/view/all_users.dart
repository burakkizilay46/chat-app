import 'package:chat_app/core/base/view/base_view.dart';
import 'package:chat_app/core/components/appbar/custom_appbar.dart';

import 'package:chat_app/core/extensions/context_extansion.dart';
import 'package:chat_app/providers/friends/friends_provider.dart';
import 'package:chat_app/providers/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
        provider: UserProvider(),
        onProviderReady: (UserProvider provider) {
          provider.getAllUsers();
        },
        onPageBuilder: (UserProvider provider) {
          return Scaffold(
              appBar: CustomAppBar(
                title: Text(
                  'Kişi Seç',
                  style: context.normalTextStyle,
                ),
              ),
              body: Consumer(
                builder: (context, UserProvider conProvider, child) {
                  return Center(
                    child: conProvider.allUsers.isEmpty
                        ? const Center(child: CircularProgressIndicator())
                        : SizedBox(
                            height: context.height,
                            child: ListView.builder(
                              itemCount: conProvider.allUsers.length,
                              itemBuilder: (context, index) {
                                var item = conProvider.allUsers[index];
                                return GestureDetector(
                                  onTap: () => context
                                      .read<FriendsProvider>()
                                      .createRoom([context.read<UserProvider>().currentUser!.uid, item.userId]),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(backgroundImage: NetworkImage(item.photoURL!)),
                                        title:
                                            Text(item.userId!, style: context.normalTextStyle.copyWith(fontSize: 12)),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  );
                },
              ));
        });
  }
}
