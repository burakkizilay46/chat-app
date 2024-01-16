import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:flutter/src/widgets/framework.dart';

class SplashProvider extends BaseProvider {
  SplashProvider() {
    init();
  }

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    navigateToPages();
  }

  @override
  void setContext(BuildContext context) => this.context = context;

  Future<void> navigateToPages() async {
    await navigation.navigateToPageClear(path: NavigationConstants.SIGNIN);
  }
}
