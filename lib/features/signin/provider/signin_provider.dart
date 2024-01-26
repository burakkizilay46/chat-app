import 'package:chat_app/core/base/provider/base_provider.dart';

import 'package:flutter/widgets.dart';

class SignInProvider extends BaseProvider with ChangeNotifier {
  @override
  void setContext(BuildContext context) {
    this.context = context;
    notifyListeners();
  }

  @override
  void init() {
    // TODO: implement init
  }
}
