import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/config/app_config.dart';
import 'package:dovemusic/config/net_api.dart';
import 'package:dovemusic/entity/singer_entity.dart';

import '../../net/dv_http.dart';
import '../../utils/toast/toast_util.dart';
import '../../widget/status_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 16:25
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SingerListState {
  List<SingerEntity> singerList;
  StatusType status;
  late EasyRefreshController controller = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  SingerListState({required this.singerList, required this.status});

  SingerListState.initial() : singerList = [],
        status = StatusType.MAIN;

  SingerListState copyWith({
    List<SingerEntity>? singerList,
    StatusType? status,
  }) {
    return SingerListState(
      singerList: singerList ?? this.singerList,
      status: status ?? this.status,
    );
  }
}

final singerListProvider =
    StateNotifierProvider.autoDispose<SingerListViewModel, SingerListState>((ref) {
  return SingerListViewModel();
});

class SingerListViewModel extends StateNotifier<SingerListState> {
  //页面
  int page = 1;

  SingerListViewModel() : super(SingerListState.initial()) {
    refreshPage();
  }

  //刷新页面
  void refreshPage() {
    state = state.copyWith(status: StatusType.LOADING);
    page = 1;
    state.controller.callRefresh();
    _getSingerList();
  }

  //下一页
  void loadMorePage() {
    page++;
    state.controller.callLoad();
    _getSingerList();
  }

  //最新入库
  void _getSingerList() {
    DMHttp.instance.post<List<SingerEntity>>(NetApi.singerList,
        data: {"page": 1, "size": AppConfig.maxSize}, success: (data) {
      if (data.length < AppConfig.maxSize) {
        state.controller.finishLoad(IndicatorResult.noMore);
      } else {
        state.controller.finishLoad(IndicatorResult.success);
      }
      if (page == 1) {
        state.controller.finishRefresh(IndicatorResult.success);
        state = state.copyWith(singerList: data, status: StatusType.MAIN);
      } else {
        var list = state.singerList;
        list.addAll(data);
        state = state.copyWith(singerList: list, status: StatusType.MAIN);
      }
    }, fail: (code, message) {
      if (page == 1) {
        state.controller.finishRefresh(IndicatorResult.fail);
        state.controller.finishRefresh(IndicatorResult.fail);
      } else {
        state.controller.finishLoad(IndicatorResult.fail);
      }
      ToastUtils.show("$code $message");
    });
  }
}
