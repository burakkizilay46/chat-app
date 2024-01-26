import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:chat_app/user/model/user_model.dart';
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
    Hive.registerAdapter(UserModelAdapter());
    await Future.delayed(const Duration(seconds: 2));
    navigateToPages();
  }

  Future<void> navigateToPages() async {
    await navigation.navigateToPageClear(path: NavigationConstants.SAMPLE);
  }
}
