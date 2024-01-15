import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/config/app_config.dart';
import 'package:dovemusic/config/net_api.dart';
import 'package:dovemusic/entity/song_list_entity.dart';

import '../../net/lm_http.dart';
import '../../widget/status_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/2 16:26
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListState {
  List<SongListEntity> songList;
  StatusType status;
  late EasyRefreshController controller = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  SongListState({required this.songList, required this.status});

  SongListState.initial()
      : songList = [],
        status = StatusType.MAIN;

  SongListState copyWith({
    List<SongListEntity>? songList,
    StatusType? status,
  }) {
    return SongListState(
      songList: songList ?? this.songList,
      status: status ?? this.status,
    );
  }
}

final songListProvider =
    StateNotifierProvider.autoDispose<SongListViewModel, SongListState>((ref) {
  return SongListViewModel();
});

class SongListViewModel extends StateNotifier<SongListState> {
  //页面
  int page = 1;

  SongListViewModel() : super(SongListState.initial()) {
    refreshPage();
  }

  //刷新页面
  void refreshPage() {
    state = state.copyWith(status: StatusType.LOADING);
    page = 1;
    state.controller.callRefresh();
    _getSongList();
  }

  //下一页
  void loadMorePage() {
    page++;
    state.controller.callLoad();
    _getSongList();
  }

  //歌单列表
  void _getSongList() {
    LMHttp.instance.post<List<SongListEntity>>(NetApi.songList,
        data: {"page": page, "size": AppConfig.maxSize}, success: (data) {
      if (data.length < AppConfig.maxSize) {
        state.controller.finishLoad(IndicatorResult.noMore);
      } else {
        state.controller.finishLoad(IndicatorResult.success);
      }
      if (page == 1) {
        state.controller.finishRefresh(IndicatorResult.success);
        state = state.copyWith(songList: data, status: StatusType.MAIN);
      } else {
        var list = state.songList;
        list.addAll(data);
        state = state.copyWith(songList: list, status: StatusType.MAIN);
      }
    }, fail: (code, message) {
      if (page == 1) {
        state = state.copyWith(status: StatusType.ERROR);
        state.controller.finishRefresh(IndicatorResult.fail);
      } else {
        state.controller.finishLoad(IndicatorResult.fail);
      }
    });
  }
}
