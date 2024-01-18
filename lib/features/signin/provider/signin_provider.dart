import 'dart:convert';

import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/init/network/auth/google_signin.dart';

class SignInProvider extends BaseProvider {
  SignInProvider();

  String _pictureUrl = "";
  String get pictureUrl => _pictureUrl;

  Future<void> signIn() async {
    try {
      final response = await signInWithGoogle();
      _pictureUrl = response.user!.photoURL!;
      print(_pictureUrl);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
