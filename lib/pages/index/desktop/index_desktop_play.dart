import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:dovemusic/manager/audio_manager.dart';
import 'package:dovemusic/pages/play/play_page.dart';
import 'package:dovemusic/pages/play/play_provider.dart';
import 'package:dovemusic/pages/singer/singer_page.dart';
import 'package:dovemusic/widget/ink_widget.dart';
import 'package:dovemusic/widget/placeholder_image.dart';
import 'package:dovemusic/widget/volume_widget.dart';

import '../../../utils/log/log_util.dart';
import '../../../widget/icon_widget.dart';
import '../../../widget/songlist_add_song_dialog.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/26 16:14
/// @Email gstory0404@gmail.com
/// @Description: 首页-播放组件

class IndexDesktopPlay extends ConsumerWidget {
  IndexDesktopPlay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(playProvider);
    // LogUtil.d("${state.curDuration}  ${state.bufferedDuration}  ${state.maxDuration}");
    return Column(
      children: [
        const Divider(height: 0.5),
        Container(
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
            thumbRadius: 3.0,
            onSeek: (duration) {
              AudioManager.instance.seek(duration);
            },
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          color: Colors.white,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //封面
                    InkWell(
                      child: PlaceholderImage(
                        width: 50,
                        height: 50,
                        image: state.musicEntity?.picture ?? "",
                      ),
                      onTap: () {
                        if (state.musicEntity == null) {
                          return;
                        }
                        PlayPage.go(context);
                      },
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //歌名
                          InkWidget(
                            onTap: () {
                              if (state.musicEntity == null) {
                                return;
                              }
                              PlayPage.go(context);
                            },
                            child: Text(
                              state.musicEntity?.name ?? "",
                              style: const TextStyle(fontSize: 12),
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(height: 3),
                          //作者
                          InkWidget(
                            onTap: () {
                              if (state.musicEntity == null) {
                                return;
                              }
                              SingerPage.go(
                                  context, state.musicEntity?.artistId);
                            },
                            child: Text(
                              state.musicEntity?.artistName ?? "",
                              style: const TextStyle(fontSize: 12),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //上一首
                    IconWidget(
                      icon: Icons.first_page_outlined,
                      isSelect: false,
                      size: 30,
                      onPress: () {
                        AudioManager.instance.previous();
                      },
                    ),
                    const SizedBox(width: 10),
                    //播放
                    IconWidget(
                      icon: Icons.play_circle_outlined,
                      selectedIcon: Icons.pause_circle_outline_outlined,
                      isSelect: state.isPlaying,
                      size: 30,
                      onPress: () {
                        AudioManager.instance.play();
                      },
                    ),
                    const SizedBox(width: 10),
                    //下一首
                    IconWidget(
                      icon: Icons.last_page_outlined,
                      isSelect: false,
                      size: 30,
                      onPress: () {
                        AudioManager.instance.next();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //时间
                    StreamBuilder<Duration?>(
                      stream: AudioManager.instance.playerPositionStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<Duration?> shot) {
                        return Text(
                          "${shot.data?.toString().substring(0, 7)} / ${AudioManager.instance.duration?.toString().substring(0, 7)}",
                          style: const TextStyle(fontSize: 12),
                        );
                      },
                    ),
                    Container(width: 10),
                    //音量
                    IconWidget(
                      icon: Icons.add_box_outlined,
                      isSelect: false,
                      size: 20,
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
                    //播放模式
                    IconWidget(
                      icon: AudioManager.instance.getPlayModeIcon(state),
                      isSelect: false,
                      size: 20,
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
                    //音量
                    IconWidget(
                      icon: Icons.volume_up,
                      isSelect: false,
                      size: 20,
                      onPress: () {
                        Navigator.push(context, VolumeWidget());
                      },
                    ),
                    //播放列表
                    IconWidget(
                      icon: Icons.queue_music,
                      isSelect: false,
                      size: 20,
                      onPress: () {
                        Scaffold.of(context).openEndDrawer();
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
