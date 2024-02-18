import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/utils/sp/sp_manager.dart';

import '../../config/net_api.dart';
import '../../entity/song_list_entity.dart';
import '../../net/dv_http.dart';
import '../../utils/toast/toast_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 11:42
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MineState {
  final int userId;
  final String userName;
  final String userAccount;
  List<SongListEntity> songList;

  EasyRefreshController controller = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: false);

  MineState({
    required this.userId,
    required this.userName,
    required this.userAccount,
    required this.songList,
  });

  MineState.initial()
      : userId = 0,
        userName = "",
        userAccount = "",
        songList = [];

  MineState copyWith({
    int? userId,
    String? userName,
    String? userAccount,
    List<SongListEntity>? songList,
  }) {
    return MineState(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAccount: userAccount ?? this.userAccount,
      songList: songList ?? this.songList,
    );
  }
}

final mineProvider = StateNotifierProvider<MineViewModel, MineState>((ref) {
  return MineViewModel();
});

class MineViewModel extends StateNotifier<MineState> {
  MineViewModel() : super(MineState.initial()) {
    state = state.copyWith(
        userId: SPManager.instance.getUserInfo().userId,
        userName: SPManager.instance.getAccount(),
        userAccount: SPManager.instance.getAccount());
    getOwnSongList();
  }

  //我的歌单列表
  void getOwnSongList() {
    DMHttp.instance.post<List<SongListEntity>>(NetApi.ownSongList,
        data: {"page": 1, "size": 200}, success: (data) {
      state.controller.finishRefresh(IndicatorResult.success);
      state = state.copyWith(songList: data);
    }, fail: (code, message) {
      state.controller.finishRefresh(IndicatorResult.fail);
      ToastUtils.show("$code $message");
    });
  }
}
