import 'package:chat_app/core/constants/cache/cache_constants.dart';
import 'package:chat_app/core/init/cache/hive_manager.dart';
import 'package:chat_app/core/init/navigation/navigation_service.dart';
import 'package:chat_app/providers/user/model/user_model.dart';
import 'package:flutter/widgets.dart';

abstract class BaseProvider {
  BuildContext? context;
  NavigationService navigation = NavigationService.instance;
  final BaseCacheManager<UserModel> manager = BaseCacheManager<UserModel>(CacheBoxNames.user);

  void init();
  void setContext(BuildContext context);
}
