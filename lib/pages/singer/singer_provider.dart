import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/config/net_api.dart';
import 'package:larkmusic/entity/singer_entity.dart';

import '../../net/lm_http.dart';
import '../../utils/toast/toast_util.dart';
import '../../widget/status_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 16:59
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SingerState {
  SingerEntity? singer;
  StatusType status;

  SingerState({required this.singer, required this.status});

  SingerState.initial()
      : singer = null,
        status = StatusType.MAIN;

  SingerState copyWith({
    SingerEntity? singer,
    StatusType? status,
  }) {
    return SingerState(
      singer: singer ?? this.singer,
      status: status ?? this.status,
    );
  }
}

final singerProvider =
    StateNotifierProvider.family.autoDispose<SingerViewModel, SingerState, int>(
        (ref, singerId) {
  return SingerViewModel(singerId);
});

class SingerViewModel extends StateNotifier<SingerState> {
  late int _singerId;

  SingerViewModel(int singerId) : super(SingerState.initial()) {
    _singerId = singerId;
    getSingerDetail();
  }

  //最新入库
  void getSingerDetail() {
    state = state.copyWith(status: StatusType.LOADING);
    LMHttp.instance.post<SingerEntity>(NetApi.singerDetail,
        data: {"id": _singerId}, success: (data) {
      state = state.copyWith(singer: data, status: StatusType.MAIN);
    }, fail: (code, message) {
      state = state.copyWith(status: StatusType.ERROR);
      ToastUtils.show("$code $message");
    });
  }
}
