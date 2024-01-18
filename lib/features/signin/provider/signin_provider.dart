import 'dart:convert';

import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:chat_app/core/init/network/auth/google_signin.dart';

class SignInProvider extends BaseProvider {
  SignInProvider();

  String _pictureUrl = "";
  String get pictureUrl => _pictureUrl;

  Future<void> signIn() async {
    try {
      await signInWithGoogle().then((value) => navigation.navigateToPage(path: NavigationConstants.HOME));
    } catch (error) {
      print(error);
    }
  }
}
