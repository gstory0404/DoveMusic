import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/config/app_config.dart';
import 'package:dovemusic/config/net_api.dart';
import 'package:dovemusic/entity/album_entity.dart';

import '../../net/lm_http.dart';
import '../../utils/toast/toast_util.dart';
import '../../widget/status_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/8 17:49
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AlbumListState {
  List<AlbumEntity> albumList;
  StatusType status;
  late EasyRefreshController controller = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: true);

  AlbumListState({required this.albumList, required this.status});

  AlbumListState.initial()
      : albumList = [],
        status = StatusType.MAIN;

  AlbumListState copyWith({
    List<AlbumEntity>? albumList,
    StatusType? status,
  }) {
    return AlbumListState(
      albumList: albumList ?? this.albumList,
      status: status ?? this.status,
    );
  }
}

final albumListProvider =
    StateNotifierProvider.autoDispose<AlbumListViewModel, AlbumListState>((ref) {
  return AlbumListViewModel();
});

class AlbumListViewModel extends StateNotifier<AlbumListState> {
  //页面
  int page = 1;

  AlbumListViewModel() : super(AlbumListState.initial()) {
    refreshPage();
  }

  //刷新页面
  void refreshPage() {
    state = state.copyWith(status: StatusType.LOADING);
    page = 1;
    state.controller.callRefresh();
    _getAlbumList();
  }

  //下一页
  void loadMorePage() {
    page++;
    state.controller.callLoad();
    _getAlbumList();
  }

  //专辑列表
  void _getAlbumList() {
    LMHttp.instance.post<List<AlbumEntity>>(NetApi.albumList,
        data: {"page": page, "size": AppConfig.maxSize}, success: (data) {
      if (data.length < AppConfig.maxSize) {
        state.controller.finishLoad(IndicatorResult.noMore);
      } else {
        state.controller.finishLoad(IndicatorResult.success);
      }
      if (page == 1) {
        state.controller.finishRefresh(IndicatorResult.success);
        state = state.copyWith(albumList: data, status: StatusType.MAIN);
      } else {
        var list = state.albumList;
        list.addAll(data);
        state = state.copyWith(albumList: list, status: StatusType.MAIN);
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
