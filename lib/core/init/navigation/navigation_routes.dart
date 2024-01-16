import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:chat_app/features/home/view/home_view.dart';
import 'package:chat_app/features/signin/view/signin_view.dart';
import 'package:flutter/material.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.DEFAULT:
        return normalNavigate(const SignInView());
      case NavigationConstants.HOME:
        return normalNavigate(const HomeView());
      default:
        return normalNavigate(const HomeView());
    }
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
