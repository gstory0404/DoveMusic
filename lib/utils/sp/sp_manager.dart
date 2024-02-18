import 'package:dovemusic/config/global_keys.dart';
import 'package:dovemusic/entity/login_entity.dart';
import 'package:dovemusic/utils/sp/sp_impl.dart';
import 'package:dovemusic/utils/sp/sp_util.dart';

import '../log/log_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/3/17 12:03
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SPManager implements SPImpl {
  factory SPManager() => _getInstance();

  static SPManager get instance => _getInstance();
  static SPManager? _instance;

  static SPManager _getInstance() {
    _instance ??= SPManager._internal();
    return _instance!;
  }

  SPManager._internal() {
    // init();
  }

  SPUtil? _spUtil;

  Future<void> init() async {
    _spUtil = await SPUtil().init();
    return;
  }

  @override
  void saveLanguage(String? lan) {
    _spUtil?.save("language", lan);
  }

  @override
  String getLanguage() {
    LogUtil.d("获取语言 ${_spUtil?.get("language", LanguageKey.auto)}");
    return _spUtil?.get("language", LanguageKey.auto) ?? LanguageKey.auto;
  }

  @override
  void saveAccountPass(String account, String password) {
    _spUtil?.save("account", account);
    _spUtil?.save("password", password);
  }

  @override
  String getAccount() {
    return _spUtil?.get("account", "") ?? "";
  }

  @override
  String getPassword() {
    return _spUtil?.get("password", "") ?? "";
  }

  @override
  void saveUserInfo(LoginEntity entity) {
    _spUtil?.save("userId", entity.userId);
    _spUtil?.save("token", entity.token);
    _spUtil?.save("userName", entity.userName);
    _spUtil?.save("purview", entity.purview);
  }

  void cleanUserInfo() {
    _spUtil?.save("userId", 0);
    _spUtil?.save("token", "");
    _spUtil?.save("userName", "");
    _spUtil?.save("purview", 0);
  }

  @override
  LoginEntity getUserInfo() {
    return LoginEntity()
      ..userId = _spUtil?.get("userId", 0)
      ..token = _spUtil?.get("token", "")
      ..userName = _spUtil?.get("userName", "")
      ..purview = _spUtil?.get("purview", 0);
  }

  bool isLogin() {
    print(getUserInfo().toJson());
    return getUserInfo().userId != 0 && (getUserInfo().token?.isNotEmpty ?? false);
  }

  @override
  String getHost() {
    return _spUtil?.get("host", "") ?? "";
  }

  @override
  void saveHost(String? url) {
    _spUtil?.save("host", url);
  }

  @override
  double getVolume() {
    return _spUtil?.get("volume", 0.5) ?? 0.5;
  }

  @override
  void saveVolume(double volume) {
    _spUtil?.save("volume", volume);
  }

  @override
  int getLocale() {
    return _spUtil?.get("locale", 1) ?? 1;
  }

  @override
  void saveLocale(int locale) {
    _spUtil?.save("locale", locale);
  }
}
