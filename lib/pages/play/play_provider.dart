import 'dart:convert';

import 'package:dovemusic/net/dv_http.dart';
import 'package:dovemusic/utils/encrypt/encrypt_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:dovemusic/entity/music_entity.dart';
import 'package:dovemusic/manager/audio_manager.dart';

import '../../utils/log/log_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/21 12:24
/// @Email gstory0404@gmail.com
/// @Description: 播放页Provider

class PlayState {
  final MusicEntity? musicEntity;
  final Duration curDuration;
  final Duration maxDuration;
  final Duration bufferedDuration;
  final bool isPlaying;
  final LoopMode loopMode;
  final double volume;
  final bool shuffleModeEnabled;

  PlayState({
    required this.musicEntity,
    required this.curDuration,
    required this.maxDuration,
    required this.bufferedDuration,
    required this.isPlaying,
    required this.loopMode,
    required this.volume,
    required this.shuffleModeEnabled,
  });

  PlayState.initial()
      : musicEntity = null,
        curDuration = Duration.zero,
        bufferedDuration = Duration.zero,
        maxDuration = Duration.zero,
        isPlaying = false,
        loopMode = LoopMode.all,
        volume = 0.5,
        shuffleModeEnabled = false;

  PlayState copyWith({
    MusicEntity? musicEntity,
    Duration? curDuration,
    Duration? bufferedDuration,
    Duration? maxDuration,
    bool? isPlaying,
    LoopMode? loopMode,
    double? volume,
    bool? shuffleModeEnabled,
  }) {
    return PlayState(
      musicEntity: musicEntity ?? this.musicEntity,
      curDuration: curDuration ?? this.curDuration,
      bufferedDuration: bufferedDuration ?? this.bufferedDuration,
      maxDuration: maxDuration ?? this.maxDuration,
      isPlaying: isPlaying ?? this.isPlaying,
      loopMode: loopMode ?? this.loopMode,
      volume: volume ?? this.volume,
      shuffleModeEnabled: shuffleModeEnabled ?? this.shuffleModeEnabled,
    );
  }
}

final playProvider = StateNotifierProvider<PlayViewModel, PlayState>((ref) {
  return PlayViewModel();
});

class PlayViewModel extends StateNotifier<PlayState> {
  PlayViewModel() : super(PlayState.initial()) {
    //监听播放位置
    AudioManager.instance.playbackEventStream.listen((event) {
      state = state.copyWith(
        bufferedDuration: event.bufferedPosition,
        maxDuration: event.duration,
        // isPlaying: !(event.processingState == ProcessingState.completed),
      );
      if (state.musicEntity?.id != AudioManager.instance.getPlayMusic()?.id) {
        state = state.copyWith(
            musicEntity: AudioManager.instance.getPlayMusic()?..lyrics = '');
        if (state.musicEntity?.lyrics?.isEmpty ?? false) {
          getKuGouLrc(state.musicEntity!.name ?? "",
              state.musicEntity!.artistName, state.musicEntity!.albumName);
        }
      }
    });
    //监听播放进度
    AudioManager.instance.playerPositionStream.listen((event) {
      // LogUtil.d("播放进度 $event");
      state = state.copyWith(curDuration: event);
    });
    //监听播放状态
    AudioManager.instance.playingStream.listen((event) {
      state = state.copyWith(isPlaying: event);
    });
    //监听音量
    AudioManager.instance.volumeStream.listen((event) {
      state = state.copyWith(volume: event);
    });
    //监听播放模式
    AudioManager.instance.loopModeStream.listen((event) {
      state = state.copyWith(loopMode: event);
    });
    //监听随机模式
    AudioManager.instance.shuffleModeEnabledStream.listen((event) {
      state = state.copyWith(shuffleModeEnabled: event);
    });
  }

  ///跳转进度
  void seek(Duration duration) {
    AudioManager.instance.seek(duration);
    AudioManager.instance.play(play: true);
  }

  //适配酷狗歌词
  Future getKuGouLrc(String name, String? artist, String? album) async {
    // http://mobilecdn.kugou.com/api/v3/search/song?format=json&keyword=%E6%96%AD%E6%A1%A5%E6%AE%8B%E9%9B%AA%20%E5%93%88%E5%93%88&page=1&pagesize=2&showtype=1
    var searchData = await DMHttp.instance.requestApi(
        baseUrl: "http://mobilecdn.kugou.com",
        path:
            "/api/v3/search/song?format=json&keyword=$name $artist $album&page=1&pagesize=2&showtype=1");
    LogUtil.d("searchData => $searchData");
    if (searchData == null) {
      return;
    }
    var searchMap = json.decode(searchData);
    if (searchMap["status"] == null ||
        searchMap["status"] != 1 ||
        searchMap["data"] == null ||
        searchMap['data']['info'] == null) {
      LogUtil.d("searchData => 异常");
      return;
    }
    // https://krcs.kugou.com/search?ver=1&man=yes&client=mobi&keyword=&duration=&hash=a9a8d57c5aef93fc18a636514500e7e7&album_audio_id=
    var songHash = searchMap['data']['info'][0]['hash'];
    var songData = await DMHttp.instance.requestApi(
        baseUrl: "https://krcs.kugou.com",
        path:
            "/search?ver=1&man=yes&client=mobi&keyword=&duration=&hash=$songHash&album_audio_id=");
    LogUtil.d("songData => $songData");
    if (songData == null) {
      return;
    }
    Map<String, dynamic> songMap;
    if (songData is Map<String, dynamic>) {
      songMap = songData;
    } else {
      songMap = json.decode(songData);
    }
    if (songMap["status"] == null ||
        songMap["status"] != 200 ||
        songMap["candidates"] == null) {
      return;
    }
    // https://lyrics.kugou.com/download?ver=1&client=pc&id=160224024&accesskey=73524B4AD5D29E9CEF022D920C0ADBAD&fmt=lrc&charset=utf8
    var id = songMap['candidates'][0]['id'];
    var accessKey = songMap['candidates'][0]['accesskey'];
    var lrcData = await DMHttp.instance.requestApi(
        baseUrl: "https://lyrics.kugou.com",
        path:
            "/download?ver=1&client=pc&id=$id&accesskey=$accessKey&fmt=lrc&charset=utf8");
    LogUtil.d("lrcData => $lrcData");
    if (lrcData == null) {
      return;
    }
    Map<String, dynamic> lrcMap;
    if (lrcData is Map<String, dynamic>) {
      lrcMap = lrcData;
    } else {
      lrcMap = json.decode(lrcData);
    }
    if (lrcMap["status"] == null ||
        lrcMap["status"] != 200 ||
        lrcMap["content"] == null) {
      return;
    }
    var lrcMD5 = lrcMap["content"];
    var lrc = EncryptUtils.base64ToStr(lrcMD5);
    LogUtil.d("lrc => $lrc");
    if (lrc.isEmpty) {
      return;
    }
    state = state.copyWith(musicEntity: state.musicEntity?..lyrics = lrc);
  }
}
