import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:larkmusic/entity/music_entity.dart';
import 'package:larkmusic/pages/play/play_provider.dart';
import 'package:larkmusic/utils/sp/sp_manager.dart';

import '../config/net_api.dart';
import '../utils/log/log_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/19 16:38
/// @Email gstory0404@gmail.com
/// @Description: 播放器管理

class AudioManager {
  factory AudioManager() => _getInstance();

  static AudioManager get instance => _getInstance();
  static AudioManager? _instance;

  static AudioManager _getInstance() {
    _instance ??= AudioManager._internal();
    return _instance!;
  }

  AudioManager._internal() {
    _init();
  }

  //播放器
  final _player = AudioPlayer();

  //播放列表
  final _playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      shuffleOrder: DefaultShuffleOrder(),
      children: []);
  final List<MusicEntity> _musicList = [];

  //当前播放下标
  int _playIndex = 0;

  //播放位置监听
  Stream<PlaybackEvent> get playbackEventStream => _player.playbackEventStream;

  //播放进度监听
  Stream<Duration?> get playerPositionStream => _player.positionStream;

  //播放状态监听
  Stream<bool?> get playingStream => _player.playingStream;

  //循环模式监听
  Stream<LoopMode?> get loopModeStream => _player.loopModeStream;

  //音量监听
  Stream<double?> get volumeStream => _player.volumeStream;

  //是否随机模式监听
  Stream<bool?> get shuffleModeEnabledStream =>
      _player.shuffleModeEnabledStream;

  //是否正在播放
  bool get isPlaying => _player.playing;

  //总时长
  Duration? get duration => _player.duration;

  Future<void> _init() async {
    _initAudio();
  }

  ///初始化播放器
  void _initAudio() async {
    //初始化播放器Session
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    //监听音频的终端状态
    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            _player.pause();
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            break;
          case AudioInterruptionType.pause:
            _player.play();
            break;
          case AudioInterruptionType.unknown:
            break;
        }
      }
    });
    //监听耳机拔出状态
    session.becomingNoisyEventStream.listen((_) {
      _player.pause();
    });

    //播放位置监听监听
    playbackEventStream.listen((event) {
      // LogUtil.d('playbackEventStream event: $event');
      _playIndex = event.currentIndex ?? 0;
    }, onError: (Object e, StackTrace stackTrace) {
      LogUtil.d('A stream error occurred: $e');
    });
    //播放状态监听
    playingStream.listen((event) {
      // LogUtil.d('playingStream event: $event');
    });

    setVolume(SPManager.instance.getVolume());
    setLoopMode(LoopMode.all);
    setShuffleMode(false);
  }

  ///获取播放列表
  List<MusicEntity> getPlayList() {
    return _musicList;
  }

  ///设置播放列表
  Future<void> setList(List<MusicEntity> list, int index) async {
    if (list.isEmpty) {
      return;
    }
    await _addPlayList(musicList: list);
    if (_player.audioSource?.sequence.isEmpty ?? true) {
      try {
        await _player.setAudioSource(_playlist, preload: true);
      } catch (e, stackTrace) {
        LogUtil.d("Error loading playlist: $e  $stackTrace");
      }
    }
    await _player.seek(Duration.zero, index: 0);
    await _player.play();
  }

  ///添加歌曲
  Future<void> playMusic(MusicEntity musicEntity) async {
    LogUtil.d("播放列表 ${_playlist.length}");
    //如果歌曲已在列表中存在 则直接播放该歌曲
    for (int i = 0; i < _musicList.length; i++) {
      if (_musicList[i].id == musicEntity.id) {
        await _player.seek(Duration.zero, index: i);
        return;
      }
    }
    await _addPlayList(music: musicEntity);
    if (_player.audioSource?.sequence.isEmpty ?? true) {
      try {
        await _player.setAudioSource(_playlist, preload: true);
      } catch (e, stackTrace) {
        LogUtil.d("Error loading playlist: $e  $stackTrace");
      }
    }
    await _player.seek(Duration.zero, index: _playlist.length - 1);
    await _player.play();
  }

  ///添加音乐
  Future<void> _addPlayList(
      {MusicEntity? music, List<MusicEntity>? musicList}) async {
    if (music != null) {
      _musicList.add(music);
      await _playlist.add(_musicToAudioSource(music));
    }
    if (musicList?.isNotEmpty ?? false) {
      _musicList.clear();
      _musicList.addAll(musicList!);
      _playlist.clear();
      List<AudioSource> sourceList = [];
      for (var element in musicList) {
        sourceList.add(_musicToAudioSource(element));
      }
      await _playlist.addAll(sourceList);
    }
    return;
  }

  ///音乐转播放格式
  AudioSource _musicToAudioSource(MusicEntity entity) {
    print(NetApi.playPath(id: entity.id!));
    return AudioSource.uri(
      Uri.parse(NetApi.playPath(id: entity.id!)),
      tag: MediaItem(
        id: '${entity.id}',
        album: '${entity.artistName} - ${entity.albumName}',
        title: entity.name ?? "",
        // artUri: Uri.dataFromString(entity.picture ?? ""),
      ),
    );
  }

  ///获取当前播放音乐
  MusicEntity? getPlayMusic() {
    if (_musicList.isEmpty ||
        _playIndex < 0 ||
        _playIndex > _musicList.length - 1) {
      return null;
    }
    return _musicList[_playIndex];
  }

  ///播放
  void play({bool play = false}) {
    if (_musicList.isEmpty) {
      return;
    }
    if (_player.playerState.processingState == ProcessingState.completed) {
      _player.seek(Duration.zero);
      _player.play();
      return;
    }
    if (_player.playing && !play) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  ///删除歌曲
  void deleteMusic(MusicEntity entity) {
    int position = -1;
    for (int i = 0; i < _musicList.length; i++) {
      if (_musicList[i].id == entity.id) {
        position = i;
      }
    }
    if (position == -1) {
      return;
    }
    if (_playIndex == position) {
      _player.seekToNext();
    }
    _musicList.removeAt(position);
    _playlist.removeAt(position);
  }

  ///停止
  void stop() {
    if (_musicList.isEmpty) {
      return;
    }
    _player.stop();
  }

  ///上一首
  void previous() {
    if (_musicList.isEmpty) {
      return;
    }
    if (_player.hasPrevious) {
      _player.seekToPrevious();
    }
  }

  ///下一首
  void next() {
    if (_musicList.isEmpty) {
      return;
    }
    if (_player.hasNext) {
      _player.seekToNext();
    }
  }

  ///跳转到
  void seek(Duration duration) {
    if (_musicList.isEmpty) {
      return;
    }
    _player.seek(duration);
  }

  //设置循环模式
  Future<void> setLoopMode(LoopMode mode) {
    return _player.setLoopMode(mode);
  }

  //设置随机模式
  Future<void> setShuffleMode(bool enabled) {
    return _player.setShuffleModeEnabled(enabled);
  }

  //设置音量
  Future<void> setVolume(double volume) {
    SPManager.instance.saveVolume(volume);
    return _player.setVolume(volume);
  }

  ///获取播放模型图标
  IconData getPlayModeIcon(PlayState state) {
    //随机模式
    if (state.shuffleModeEnabled) {
      return Icons.shuffle;
    }
    //循环
    if (state.loopMode == LoopMode.all) {
      return Icons.loop_outlined;
    } else if (state.loopMode == LoopMode.one) {
      return Icons.repeat_one;
    }
    return Icons.playlist_play;
  }
}
