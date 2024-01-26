import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:chat_app/core/init/network/auth/google_signin.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';

class UserProvider extends BaseProvider with ChangeNotifier {
  @override
  void setContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  late final User _currentUser;
  User get currentUser => _currentUser;

  Future<void> signIn() async {
    try {
      signInWithGoogle().then((value) {
        print(value.user.runtimeType);
        _currentUser = value.user!;
        navigation.navigateToPage(path: NavigationConstants.HOME);
        notifyListeners();
      });
    } catch (error) {
      print(error);
      Exception(error);
    }
  }

  Future<void> saveCurrentUser(User user) async {
    notifyListeners();
  }

  @override
  void init() async {
    /*   await Hive.openBox<UserModel>('userBox'); */
  }
}
