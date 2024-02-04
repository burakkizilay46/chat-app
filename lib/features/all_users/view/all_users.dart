import 'package:chat_app/core/base/view/base_view.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';
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
              appBar: AppBar(),
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
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: ListTile(
                                        leading: CircleAvatar(backgroundImage: NetworkImage(item.photoURL!)),
                                        title: Text(item.userId!),
                                      ),
                                    ),
                                    Divider(),
                                  ],
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
