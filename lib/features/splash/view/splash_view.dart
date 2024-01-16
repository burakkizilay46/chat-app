import 'package:chat_app/core/constants/image/image_constants.dart';
import 'package:chat_app/core/extensions/context_extansion.dart';
import 'package:chat_app/features/splash/provider/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashProvider(),
      child: const _SplashContent(),
    );
  }
}

class _SplashContent extends StatelessWidget {
  const _SplashContent();

  @override
  Widget build(BuildContext context) {
    final splashProvider = Provider.of<SplashProvider>(context);
    return Scaffold(
      backgroundColor: context.appColor,
      body: Center(
          child: Text(
        'Welcome Chat App',
        style: context.normalTextStyle.copyWith(color: context.appWhite),
      )),
    );
  }
}
