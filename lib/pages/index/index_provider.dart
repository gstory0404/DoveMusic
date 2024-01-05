import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/net_api.dart';
import '../../entity/song_list_entity.dart';
import '../../net/lm_http.dart';
import '../../utils/toast/toast_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/19 14:44
/// @Email gstory0404@gmail.com
/// @Description: index Provider

class IndexModel {
  final String name;
  List<SongListEntity> songList;

  IndexModel({required this.name, required this.songList});

  IndexModel.initial()
      : name = "",
        songList = [];

  IndexModel copyWith({
    String? name,
    List<SongListEntity>? songList,
  }) {
    return IndexModel(
        name: name ?? this.name, songList: songList ?? this.songList);
  }
}

final indexProvider = StateNotifierProvider.autoDispose<IndexViewModel, IndexModel>((ref) {
  return IndexViewModel();
});

class IndexViewModel extends StateNotifier<IndexModel> {
  IndexViewModel() : super(IndexModel.initial()) {
    getOwnSongList();
  }

  //我的歌单列表
  void getOwnSongList() {
    LMHttp.instance.post<List<SongListEntity>>(NetApi.ownSongList,
        data: {"page": 1, "size": 200}, success: (data) {
      state = state.copyWith(songList: data);
    }, fail: (code, message) {
      ToastUtils.show("$code $message");
    });
  }
}
