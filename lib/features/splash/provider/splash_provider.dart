import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashProvider extends BaseProvider with ChangeNotifier {
  @override
  void setContext(BuildContext context) => this.context = context;

  SplashProvider() {
    init();
  }

  @override
  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    checkInternetConnection();
  }

  Future<void> navigateToPages() async {
    bool userIsLogged = false;
    var box = await Hive.openBox('isLogged');
    userIsLogged = await box.get('isLogged', defaultValue: false);

    userIsLogged
        ? await navigation.navigateToPageClear(path: NavigationConstants.HOME)
        : await navigation.navigateToPageClear(path: NavigationConstants.SIGNIN);

    box.close();
  }

  void checkInternetConnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('İnternet Bağlantısı Yok!');
    } else {
      navigateToPages();
    }
  }
}
