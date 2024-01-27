import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:chat_app/features/chat/view/chat_view.dart';
import 'package:chat_app/features/home/view/home_view.dart';
import 'package:chat_app/features/sample/sample_view.dart';
import 'package:chat_app/features/signin/view/signin_view.dart';
import 'package:chat_app/features/splash/view/splash_view.dart';
import 'package:flutter/material.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.DEFAULT:
        return normalNavigate(const SignInView());
      case NavigationConstants.SAMPLE:
        return normalNavigate(const SampleView());
      case NavigationConstants.SPLASH:
        return normalNavigate(const SplashView());
      case NavigationConstants.HOME:
        return normalNavigate(const HomeView());
      case NavigationConstants.SIGNIN:
        return normalNavigate(const SignInView());
      case NavigationConstants.CHATVIEW:
        return normalNavigate(ChatView());
      default:
        return normalNavigate(const HomeView());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
