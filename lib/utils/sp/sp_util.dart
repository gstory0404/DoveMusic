import 'package:shared_preferences/shared_preferences.dart';

import '../log/log_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/19 16:41
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SPUtil {
  SharedPreferences? preferences;

  Future<SPUtil> init() async {
    preferences = await SharedPreferences.getInstance();
    return this;
  }

  ///保存数据
  SPUtil save(String key, dynamic value) {
    LogUtil.d("写入缓存 $key --> $value");
    switch (value.runtimeType) {
      case int:
        preferences?.setInt(key, value);
        break;
      case bool:
        preferences?.setBool(key, value);
        break;
      case double:
        preferences?.setDouble(key, value);
        break;
      case String:
        preferences?.setString(key, value);
        break;
      case const (List<String>):
        preferences?.setStringList(key, value);
        break;
      default:
        preferences?.setString(key, value.toString());
        break;
    }
    return this;
  }

  ///获取数据
  T get<T>(String key, dynamic defaultValue) {
    T value;
    switch (T) {
      case int:
        value = preferences?.getInt(key) ?? defaultValue;
        break;
      case bool:
        value = preferences?.getBool(key) ?? defaultValue;
        break;
      case double:
        value = preferences?.getDouble(key) ?? defaultValue;
        break;
      case String:
        value = preferences?.getString(key) ?? defaultValue;
        break;
      case const (List<String>):
        value = preferences?.getStringList(key) ?? defaultValue;
        break;
      default:
        value = preferences?.get(key) ?? defaultValue;
        break;
    }
    // LogUtil.d("读取缓存 $key --> $value");
    return value;
  }

  ///删除key
  Future<bool> remove(String key) async {
    return await preferences?.remove(key) ?? false;
  }

  ///清空
  Future<bool> clear() async {
    return await preferences?.clear() ?? false;
  }
}
