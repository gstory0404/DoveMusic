import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/index/desktop/index_desktop_playlist.dart';
import 'package:larkmusic/pages/play/play_provider.dart';
import 'package:larkmusic/pages/play/widget/Lyric_widget.dart';
import 'package:larkmusic/widget/filtered_widget.dart';
import 'package:larkmusic/widget/icon_widget.dart';
import 'package:larkmusic/widget/placeholder_image.dart';
import 'package:larkmusic/widget/volume_widget.dart';

import '../../../utils/log/log_util.dart';
import '../../../widget/songlist_add_song_dialog.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 15:27
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class PlayPhonePage extends ConsumerWidget {
  PlayPhonePage({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playProvider);
    return Stack(
      children: [
        FilteredWidget(
          child: PlaceholderImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            image: state.musicEntity?.picture ?? "",
            radius: 0,
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              "${state.musicEntity?.name}",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          endDrawer: Drawer(
            child: IndexDesktopPlayList(),
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Expanded(child: LyricWidget()),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: ProgressBar(
                  progress: state.curDuration,
                  buffered: state.bufferedDuration,
                  total: state.maxDuration,
                  progressBarColor: Theme.of(context).colorScheme.primary,
                  baseBarColor: Colors.white,
                  bufferedBarColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.24),
                  timeLabelLocation: TimeLabelLocation.none,
                  thumbColor: Theme.of(context).colorScheme.background,
                  barHeight: 6.0,
                  thumbRadius: 2.0,
                  onSeek: (duration) {
                    AudioManager.instance.seek(duration);
                  },
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 16, left: 14, right: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //播放模式
                    IconWidget(
                      icon: AudioManager.instance.getPlayModeIcon(state),
                      isSelect: false,
                      size: 28,
                      iconColor: Colors.white,
                      selectedColor: Colors.white,
                      onPress: () {
                        if (state.shuffleModeEnabled) {
                          AudioManager.instance.setShuffleMode(false);
                          AudioManager.instance.setLoopMode(LoopMode.one);
                        } else {
                          if (state.loopMode == LoopMode.one) {
                            AudioManager.instance.setLoopMode(LoopMode.all);
                          } else if (state.loopMode == LoopMode.all) {
                            AudioManager.instance.setLoopMode(LoopMode.off);
                          } else {
                            AudioManager.instance.setShuffleMode(true);
                            AudioManager.instance.setLoopMode(LoopMode.all);
                          }
                        }
                      },
                    ),
                    //添加歌单
                    IconWidget(
                      icon: Icons.add_box_outlined,
                      isSelect: false,
                      size: 28,
                      iconColor: Colors.white,
                      selectedColor: Colors.white,
                      onPress: () {
                        if (state.musicEntity?.id == 0) {
                          return;
                        }
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SongListAddSongDialog(
                                  id: state.musicEntity?.id ?? 0);
                            });
                      },
                    ),
                    //音量
                    IconWidget(
                      icon: Icons.volume_up,
                      isSelect: false,
                      size: 28,
                      iconColor: Colors.white,
                      selectedColor: Colors.white,
                      onPress: () {
                        Navigator.push(context, VolumeWidget());
                      },
                    ),
                    //播放列表
                    IconWidget(
                      icon: Icons.menu,
                      isSelect: false,
                      size: 28,
                      iconColor: Colors.white,
                      selectedColor: Colors.white,
                      onPress: () {
                        _scaffoldKey.currentState?.openEndDrawer();
                        // Scaffold.of(context).openDrawer();
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.only(top: 16, bottom: 30, left: 60, right: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //上一首
                    IconWidget(
                      icon: Icons.first_page_outlined,
                      isSelect: false,
                      size: 30,
                      iconColor: Colors.white,
                      selectedColor: Colors.white,
                      onPress: () {
                        AudioManager.instance.previous();
                      },
                    ),
                    //播放
                    IconWidget(
                      icon: Icons.play_circle_outlined,
                      selectedIcon: Icons.pause_circle_outline_outlined,
                      isSelect: state.isPlaying,
                      iconColor: Colors.white,
                      selectedColor: Colors.white,
                      size: 46,
                      onPress: () {
                        AudioManager.instance.play();
                      },
                    ),
                    //下一首
                    IconWidget(
                      icon: Icons.last_page_outlined,
                      isSelect: false,
                      size: 30,
                      iconColor: Colors.white,
                      selectedColor: Colors.white,
                      onPress: () {
                        AudioManager.instance.next();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
