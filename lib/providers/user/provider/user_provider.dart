import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:chat_app/core/init/network/auth/google_signin.dart';
import 'package:chat_app/providers/user/firebase/user_firebase.dart';
import 'package:chat_app/providers/user/model/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProvider extends BaseProvider with ChangeNotifier {
  UserProvider() {
    getCurrentUser();
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  Box? box;
  User? _currentUser;
  User? get currentUser => _currentUser;

  Future<void> signIn() async {
    try {
      await signInWithGoogle().then((value) async {
        if (value.additionalUserInfo!.isNewUser) {
          registerUser(value.user!);
        } else {
          signInApp();
        }
      });
    } catch (error) {
      print(error);
      Exception(error);
    }
  }

  void signInApp() {
    userIsLogin(true);
    getCurrentUser();
    navigation.navigateToPageClear(path: NavigationConstants.HOME);
    notifyListeners();
  }

  Future<void> registerUser(User newUser) async {
    await UserDatabase().addUser(newUser).then((value) => signInApp());
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      userIsLogin(false);
      navigation.navigateToPageClear(path: NavigationConstants.SIGNIN);
    });
  }

  Future<void> userIsLogin(bool loginValue) async {
    box = await Hive.openBox('isLogged');
    await box!.put('isLogged', loginValue);
  }

  void getCurrentUser() {
    _currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  @override
  void init() async {
    box = await Hive.openBox<UserModel>('userBox');
    box?.close();
  }
}
