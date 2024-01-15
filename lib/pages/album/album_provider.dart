import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/config/net_api.dart';
import 'package:dovemusic/entity/album_entity.dart';
import 'package:dovemusic/net/lm_http.dart';
import 'package:dovemusic/utils/log/log_util.dart';
import 'package:dovemusic/widget/status_widget.dart';

import '../../utils/toast/toast_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/8 18:04
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AlbumState {
  AlbumEntity? album;
  StatusType status;

  AlbumState({required this.album, required this.status});

  AlbumState.initial()
      : album = null,
        status = StatusType.MAIN;

  AlbumState copyWith({
    AlbumEntity? album,
    StatusType? status,
  }) {
    return AlbumState(
      album: album ?? this.album,
      status: status ?? this.status,
    );
  }
}

final albumProvider =
    StateNotifierProvider.family.autoDispose<AlbumViewModel, AlbumState, int>(
        (ref, albumId) {
  return AlbumViewModel(albumId);
});

class AlbumViewModel extends StateNotifier<AlbumState> {
  late int _albumId;

  AlbumViewModel(int albumId) : super(AlbumState.initial()) {
    _albumId = albumId;
    getAlbumDetail();
  }

  //专辑详情
  void getAlbumDetail() {
    state = state.copyWith(status: StatusType.LOADING);
    LMHttp.instance.post<AlbumEntity>(NetApi.albumDetail,
        data: {"id": _albumId}, success: (data) {
      LogUtil.d(data.toJson());
      state = state.copyWith(album: data, status: StatusType.MAIN);
    }, fail: (code, message) {
      state = state.copyWith(status: StatusType.ERROR);
      ToastUtils.show("$code $message");
    });
  }
}
