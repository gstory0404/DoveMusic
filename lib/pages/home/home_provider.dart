import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/config/app_config.dart';
import 'package:larkmusic/config/net_api.dart';
import 'package:larkmusic/entity/album_entity.dart';
import 'package:larkmusic/entity/music_entity.dart';
import 'package:larkmusic/entity/singer_entity.dart';
import 'package:larkmusic/entity/song_list_entity.dart';
import 'package:larkmusic/utils/log/log_util.dart';
import 'package:larkmusic/utils/sp/sp_manager.dart';
import 'package:larkmusic/widget/status_widget.dart';

import '../../generated/l10n.dart';
import '../../net/lm_http.dart';
import '../../utils/toast/toast_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/19 16:04
/// @Email gstory0404@gmail.com
/// @Description: 首页 Provider

class HomeState {
  String name;
  StatusType status;
  List<MusicEntity>? latestMusicList;
  List<MusicEntity>? randomMusicList;
  List<SongListEntity>? songList;
  List<AlbumEntity>? albumList;
  List<SingerEntity>? singerList;
  late EasyRefreshController controller = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: false);

  HomeState(
      {required this.name,
      required this.status,
      this.latestMusicList,
      this.randomMusicList,
      this.songList,
      this.albumList,
      this.singerList});

  HomeState.initial()
      : name = S.current.home,
        status = StatusType.LOADING,
        songList = [],
        randomMusicList = [],
        albumList = [],
        singerList = [];

  HomeState copyWith({
    String? name,
    StatusType? status,
    List<MusicEntity>? latestMusicList,
    List<MusicEntity>? randomMusicList,
    List<SongListEntity>? songList,
    List<AlbumEntity>? albumList,
    List<SingerEntity>? singerList,
  }) {
    return HomeState(
      name: name ?? this.name,
      status: status ?? this.status,
      latestMusicList: latestMusicList ?? this.latestMusicList,
      randomMusicList: randomMusicList ?? this.randomMusicList,
      songList: songList ?? this.songList,
      albumList: albumList ?? this.albumList,
      singerList: singerList ?? this.singerList,
    );
  }
}

final homeProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>((ref) {
  return HomeViewModel();
});

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel() : super(HomeState.initial()) {
    refreshPage();
  }

  void refreshPage() {
    state = state.copyWith(status: StatusType.LOADING);
    getLatestMusic();
    getPlaylist();
    getAlbumList();
    getArtistList();
    getRandomList();
  }

  //最新入库
  void getLatestMusic() {
    LMHttp.instance.post<List<MusicEntity>>(NetApi.recently,
        data: {"page": 1, "size": AppConfig.maxSize}, success: (data) {
      if (mounted) {
        state.controller.finishRefresh(IndicatorResult.success);
        state = state.copyWith(status: StatusType.MAIN, latestMusicList: data);
      }
    }, fail: (code, message) {
      if (mounted) {
        state.controller.finishRefresh(IndicatorResult.fail);
        state = state.copyWith(status: StatusType.ERROR);
      }
      ToastUtils.show("$code $message");
    });
  }

  //歌单
  void getPlaylist() {
    LMHttp.instance.post<List<SongListEntity>>(NetApi.songList,
        data: {"page": 1, "size": AppConfig.maxSize}, success: (data) {
      if (mounted) {
        state.controller.finishRefresh(IndicatorResult.success);
        state = state.copyWith(songList: data);
      }
    }, fail: (code, message) {
      ToastUtils.show("$code $message");
    });
  }

  //专辑
  void getAlbumList() {
    LMHttp.instance.post<List<AlbumEntity>>(NetApi.albumList,
        data: {"page": 1, "size": AppConfig.maxSize}, success: (data) {
      if (mounted) {
        state.controller.finishRefresh(IndicatorResult.success);
        state = state.copyWith(albumList: data);
      }
    }, fail: (code, message) {
      ToastUtils.show("$code $message");
    });
  }

  //歌手
  void getArtistList() {
    LMHttp.instance.post<List<SingerEntity>>(NetApi.singerList,
        data: {"page": 1, "size": AppConfig.maxSize}, success: (data) {
      if (mounted) {
        state.controller.finishRefresh(IndicatorResult.success);
        state = state.copyWith(singerList: data);
      }
    }, fail: (code, message) {
      ToastUtils.show("$code $message");
    });
  }

  //随机播放
  void getRandomList() {
    LMHttp.instance.post<List<MusicEntity>>(NetApi.random, success: (data) {
      if (mounted) {
        state = state.copyWith(randomMusicList: data);
      }
    }, fail: (code, message) {
      LogUtil.d("$code $message");
      ToastUtils.show("$code $message");
    });
  }
}
