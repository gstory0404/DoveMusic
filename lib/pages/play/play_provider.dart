import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:larkmusic/entity/music_entity.dart';
import 'package:larkmusic/manager/audio_manager.dart';

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
        musicEntity: AudioManager.instance.getPlayMusic(),
        bufferedDuration: event.bufferedPosition,
        maxDuration: event.duration,
        // isPlaying: !(event.processingState == ProcessingState.completed),
      );
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
}
