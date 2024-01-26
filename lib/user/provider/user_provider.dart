import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:chat_app/core/init/network/auth/google_signin.dart';
import 'package:chat_app/user/model/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserProvider extends BaseProvider with ChangeNotifier {
  UserProvider() {
    init();
  }

  @override
  void setContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  UserModel _currentUser = UserModel();
  UserModel get currentUser => _currentUser;

  Future<void> signIn() async {
    try {
      await signInWithGoogle().then((value) async {
        await saveCurrentUser(value.user!);
        userIsLogin();
        navigation.navigateToPage(path: NavigationConstants.HOME);
        notifyListeners();
      });
    } catch (error) {
      print(error);
      Exception(error);
    }
  }

  Future<void> userIsLogin() async {
    var box = await Hive.openBox('isLogged');
    await box.put('isLogged', true);
  }

  UserModel _userToUserModel(User user) {
    return UserModel()
      ..uid = user.uid
      ..email = user.email ?? ''
      ..photoUrl = user.photoURL ?? ''
      ..displayName = user.displayName ?? '';
  }

  Future<void> saveCurrentUser(User user) async {
    var userModel = _userToUserModel(user);
    var box = await Hive.openBox<UserModel>('userBox');
    if (!(await box.isEmpty)) {
      await box.clear();
    }
    await box.put('currentUser', userModel);
    await getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    var box = await Hive.openBox<UserModel>('userBox');
    _currentUser = box.get('currentUser') as UserModel;
    notifyListeners();
  }

  @override
  void init() async {
    await getCurrentUser();
  }
}
