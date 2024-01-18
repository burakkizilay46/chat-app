import 'package:chat_app/core/init/navigation/navigation_service.dart';
import 'package:flutter/widgets.dart';

abstract class BaseProvider extends ChangeNotifier {
  BuildContext? context;
  NavigationService navigation = NavigationService.instance;
}
