import 'package:chat_app/core/base/view/base_view.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';
import 'package:chat_app/user/provider/user_provider.dart';
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
            SizedBox(width: 8)
          ],
        ),
        body: Center(),
      ),
    );
  }
}
