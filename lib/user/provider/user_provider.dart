import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/user/model/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends BaseProvider with ChangeNotifier {
  late UserModel _currentUser = UserModel();
  UserModel get currentUser => _currentUser;

  @override
  void setContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  void saveUserInfos(User user) {
    _currentUser = UserModel(
      displayName: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
      uid: user.uid,
    );
    notifyListeners();
  }

  Future<void> cacheUser(UserModel user) async {
    /*  Box<UserModel> userBox = Hive.box<UserModel>('userBox');
    await userBox.add(user); */
    notifyListeners();
  }

  @override
  void init() async {
    /*   await Hive.openBox<UserModel>('userBox'); */
  }
}
