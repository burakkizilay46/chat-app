import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:chat_app/core/init/network/auth/google_signin.dart';
import 'package:chat_app/user/provider/user_provider.dart';

import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SignInProvider extends BaseProvider with ChangeNotifier {
  @override
  void setContext(BuildContext context) => this.context = context;

  Future<void> signIn() async {
    try {
      await signInWithGoogle().then((value) {
        UserProvider().saveUserInfos(value.user!);
        navigation.navigateToPage(path: NavigationConstants.HOME);
        notifyListeners();
      });
    } catch (error) {
      print(error);
      Exception(error);
    }
  }

  @override
  void init() {
    // TODO: implement init
  }
}
