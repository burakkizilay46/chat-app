import 'package:chat_app/core/constants/cache/cache_constants.dart';
import 'package:chat_app/providers/user/model/user_model.dart';

import 'package:hive_flutter/hive_flutter.dart';

class BaseCacheManager<T> {
  Box<T>? _box;
  final CacheBoxNames boxName;

  BaseCacheManager(this.boxName);

  Future<void> updateItem(dynamic key, T val) async {
    await _box?.put(key, val);
  }

  T? getItem(dynamic key) {
    return _box?.get(key);
  }

  List<T>? getAllItems() {
    return _box?.values.toList();
  }

  saveAllItems(List<T>? items) {
    if (items != null) {
      _box?.addAll(items);
    }
  }
}
