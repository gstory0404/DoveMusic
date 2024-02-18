import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/config/app_config.dart';
import 'package:dovemusic/config/net_api.dart';
import 'package:dovemusic/entity/music_entity.dart';

import '../../net/dv_http.dart';
import '../../utils/toast/toast_util.dart';
import '../../widget/status_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/14 17:41
/// @Email gstory0404@gmail.com
/// @Description: 最近入库

class RecentlyState {
  List<MusicEntity> musicList;
  StatusType status;
  late EasyRefreshController controller = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  RecentlyState({required this.musicList, required this.status});

  RecentlyState.initial()
      : musicList = [],
        status = StatusType.MAIN;

  RecentlyState copyWith({
    List<MusicEntity>? musicList,
    StatusType? status,
  }) {
    return RecentlyState(
      musicList: musicList ?? this.musicList,
      status: status ?? this.status,
    );
  }
}

final recentlyProvider =
    StateNotifierProvider.autoDispose<RecentlyViewModel, RecentlyState>((ref) {
  return RecentlyViewModel();
});

class RecentlyViewModel extends StateNotifier<RecentlyState> {
  int page = 1;

  RecentlyViewModel() : super(RecentlyState.initial()) {
    refreshPage();
  }

  //刷新页面
  void refreshPage() {
    state = state.copyWith(status: StatusType.LOADING);
    page = 1;
    state.controller.callRefresh();
    _getRecentlyList();
  }

  //加载更多
  void loadMorePage() {
    page++;
    state.controller.callLoad();
    _getRecentlyList();
  }

  //最新入库
  void _getRecentlyList() {
    DMHttp.instance.post<List<MusicEntity>>(NetApi.recently,
        data: {"page": page, "size": AppConfig.maxSize}, success: (data) {
      if (data.length < AppConfig.maxSize) {
        state.controller.finishLoad(IndicatorResult.noMore);
      } else {
        state.controller.finishLoad(IndicatorResult.success);
      }
      if (page == 1) {
        state.controller.finishRefresh(IndicatorResult.success);
        state = state.copyWith(musicList: data, status: StatusType.MAIN);
      } else {
        var list = state.musicList;
        list.addAll(data);
        state = state.copyWith(musicList: list, status: StatusType.MAIN);
      }
    }, fail: (code, message) {
      if (page == 1) {
        state.controller.finishRefresh(IndicatorResult.fail);
        state = state.copyWith(status: StatusType.ERROR);
      } else {
        state.controller.finishLoad(IndicatorResult.fail);
      }
      ToastUtils.show("$code $message");
    });
  }
}
