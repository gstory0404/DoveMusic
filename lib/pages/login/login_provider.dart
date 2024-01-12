import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/config/net_api.dart';
import 'package:larkmusic/entity/login_entity.dart';
import 'package:larkmusic/net/lm_http.dart';
import 'package:larkmusic/pages/index/index_provider.dart';
import 'package:larkmusic/pages/mine/mine_provider.dart';
import 'package:larkmusic/utils/encrypt/encrypt_utils.dart';
import 'package:larkmusic/utils/log/log_util.dart';
import 'package:larkmusic/utils/sp/sp_manager.dart';

import '../../config/assets_image.dart';
import '../home/home_provider.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/24 17:30
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class LoginState {
  final String url;
  final String account;
  final String password;
  final LoginEntity? loginEntity;
  final String? errMsg;

  LoginState(
      {required this.url,
      required this.account,
      required this.password,
      this.loginEntity,
      this.errMsg});

  LoginState.initial()
      : url = SPManager.instance.getHost(),
        account = SPManager.instance.getAccount(),
        password = SPManager.instance.getPassword(),
        loginEntity = SPManager.instance.getUserInfo(),
        errMsg = null;

  LoginState copyWith({
    String? url,
    String? account,
    String? password,
    LoginEntity? loginEntity,
    String? errMsg,
  }) {
    return LoginState(
      url: url ?? this.url,
      account: account ?? this.account,
      password: password ?? this.password,
      loginEntity: loginEntity,
      errMsg: errMsg,
    );
  }
}

final loginProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>((ref) {
  return LoginViewModel(refresh: () {
    ref.watch(homeProvider.notifier).refreshPage();
    ref.watch(mineProvider.notifier).getOwnSongList();
  });
});

class LoginViewModel extends StateNotifier<LoginState> {
  Function refresh;

  LoginViewModel({required this.refresh}) : super(LoginState.initial());

  //读取本地缓存
  void readCacheData() {
    //读取配置文件
    dotenv.load(fileName: AssetsEnv.env).then((value) {
      var baseUrl =
          dotenv.get("BASE_URL", fallback: SPManager.instance.getHost());
      if (SPManager.instance.getHost().isEmpty && baseUrl.isNotEmpty) {
        setHost(baseUrl);
      }
    });
  }

  //输入域名
  void setHost(String url) {
    //初始化
    LMHttp.instance.init(baseUrl: SPManager.instance.getHost());
    SPManager.instance.saveHost(url);
    state = state.copyWith(url: url);
  }

  //输入账号
  void setAccount(String account) {
    LogUtil.d(account);
    state = state.copyWith(account: account);
  }

  //输入密码
  void setPassword(String password) {
    LogUtil.d(password);
    state = state.copyWith(password: password);
  }

  //登录
  void login() {
    LMHttp.instance.post<LoginEntity>(NetApi.login, data: {
      "account": state.account,
      "password": EncryptUtils.strToMd5(state.password)
    }, success: (data) {
      SPManager.instance.saveAccountPass(state.account, state.password);
      SPManager.instance.saveUserInfo(data);
      state = state.copyWith(loginEntity: data, errMsg: null);
    }, fail: (code, message) {
      state = state.copyWith(errMsg: message);
    });
  }
}
