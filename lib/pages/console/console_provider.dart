import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/home/home_provider.dart';

import '../../config/net_api.dart';
import '../../net/lm_http.dart';
import '../../utils/log/log_util.dart';
import '../../utils/toast/toast_util.dart';
import '../index/index_provider.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/22 11:19
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ConsoleState {
  List<String> syncLogs;

  ConsoleState({required this.syncLogs});

  ConsoleState.initial() : syncLogs = [];

  ConsoleState copyWith({
    List<String>? syncLogs,
  }) {
    return ConsoleState(
      syncLogs: syncLogs ?? this.syncLogs,
    );
  }
}

final consoleProvider =
    StateNotifierProvider.autoDispose<ConsoleViewModel, ConsoleState>((ref) {
  return ConsoleViewModel(refresh: () {
    ref.refresh(homeProvider);
    ref.refresh(indexProvider);
  });
});

class ConsoleViewModel extends StateNotifier<ConsoleState> {
  Function refresh;

  ConsoleViewModel({required this.refresh}) : super(ConsoleState.initial());

  //同步歌曲
  void syncMusic() {
    state = state.copyWith(syncLogs: []);
    CancelToken cancelToken = CancelToken();
    LMHttp.instance.sse(NetApi.syncMusic, cancelToken: cancelToken,
        success: (data) {
      if (data.startsWith("data:")) {
        LogUtil.d("接收的事件 ${data.substring("data:".length)}");
        state = state.copyWith(syncLogs: [...state.syncLogs, data.substring("data:".length)]);
      } else if (data.startsWith("end")) {
        LMHttp.instance.cancelRequests(token: cancelToken);
        refresh();
      }
    }, fail: (code, message) {
      ToastUtils.show("$code $message");
    });
  }
}
