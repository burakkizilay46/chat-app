import 'package:chat_app/core/base/view/base_view.dart';
import 'package:chat_app/user/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
          actions: [],
        ),
        body: Center(
          child: Text(context.watch<UserProvider>().currentUser.displayName.toString()),
        ),
      ),
    );
  }
}
