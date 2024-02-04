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
              body: Center(
                child: context.watch<UserProvider>().allUsers.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        height: context.height,
                        child: ListView.builder(
                          itemCount: context.watch<UserProvider>().allUsers.length,
                          itemBuilder: (context, index) {
                            var item = context.watch<UserProvider>().allUsers[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: Image.network(item.photoURL!),
                                  title: Text(item.userId!),
                                ),
                                Divider(),
                              ],
                            );
                          },
                        ),
                      ),
              ));
        });
  }
}
