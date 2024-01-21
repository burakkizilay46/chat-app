import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserProvider extends BaseProvider with ChangeNotifier {
  @override
  void setContext(BuildContext context) => this.context = context;

  late User _currentUser;
  User get currentUser => _currentUser;

  Future<void> saveUserInfos(User user) async {
    _currentUser = user;
    notifyListeners();
  }

  @override
  void init() {
    // TODO: implement init
  }
}
