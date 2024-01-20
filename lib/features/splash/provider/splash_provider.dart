import 'package:chat_app/core/base/provider/base_provider.dart';
import 'package:chat_app/core/constants/navigation/navigation_constants.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashProvider extends BaseProvider {
  @override
  void setContext(BuildContext context) => this.context = context;

  SplashProvider() {
    init();
  }

  void init() async {
    await Hive.openBox<String>('userBox');
    await Future.delayed(const Duration(seconds: 2));
    navigateToPages();
  }

  Future<void> navigateToPages() async {
    await navigation.navigateToPageClear(path: NavigationConstants.SIGNIN);
  }
}
