import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/config/net_api.dart';
import 'package:larkmusic/entity/song_list_entity.dart';

import '../../generated/l10n.dart';
import '../../net/lm_http.dart';
import '../../utils/toast/toast_util.dart';
import '../../widget/status_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 16:59
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListDetailState {
  SongListEntity? songListDetail;
  bool? isDelete;
  StatusType status;

  SongListDetailState(
      {required this.songListDetail,
      required this.isDelete,
      required this.status});

  SongListDetailState.initial()
      : songListDetail = null,
        isDelete = false,
        status = StatusType.MAIN;

  SongListDetailState copyWith({
    SongListEntity? songListDetail,
    bool? isDelete,
    StatusType? status,
  }) {
    return SongListDetailState(
      songListDetail: songListDetail ?? this.songListDetail,
      isDelete: isDelete ?? this.isDelete,
      status: status ?? this.status,
    );
  }
}

final songListDetailProvider = StateNotifierProvider.family<
    SongListDetailViewModel, SongListDetailState, int>((ref, singerId) {
  return SongListDetailViewModel(singerId);
});

class SongListDetailViewModel extends StateNotifier<SongListDetailState> {
  late int _songListId;

  SongListDetailViewModel(int songListId)
      : super(SongListDetailState.initial()) {
    _songListId = songListId;
    getSongListDetail();
  }

  //歌单详情
  void getSongListDetail() {
    state = state.copyWith(status: StatusType.LOADING);
    LMHttp.instance.post<SongListEntity>(NetApi.songListDetail,
        data: {"id": _songListId}, success: (data) {
      state = state.copyWith(songListDetail: data, status: StatusType.MAIN);
    }, fail: (code, message) {
      state = state.copyWith(status: StatusType.ERROR);
      ToastUtils.show("$code $message");
    });
  }

  //删除歌单
  void deleteSongList() {
    LMHttp.instance.post<int>(NetApi.songListDelete, data: {"id": _songListId},
        success: (data) {
      state = state.copyWith(isDelete: true);
    }, fail: (code, message) {
      ToastUtils.show("$code $message");
    });
  }

  //删除歌曲
  void deleteSong(List<int> ids) {
    LMHttp.instance.post<String>(NetApi.songListDeleteMusic,
        data: {"id": _songListId, "music_ids": ids}, success: (data) {
      ToastUtils.show(S.current.deleteSuccess);
      getSongListDetail();
    }, fail: (code, message) {
      ToastUtils.show("$code $message");
    });
  }
}
