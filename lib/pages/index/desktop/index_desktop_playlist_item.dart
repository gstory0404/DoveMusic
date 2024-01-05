import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/entity/music_entity.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/play/play_provider.dart';
import 'package:larkmusic/widget/icon_widget.dart';
import 'package:larkmusic/widget/ink_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/7 16:53
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexDesktopPlayListItem extends ConsumerStatefulWidget {
  MusicEntity entity;
  VoidCallback? play;
  VoidCallback? delete;

  IndexDesktopPlayListItem({super.key, required this.entity, this.play,this.delete});

  @override
  ConsumerState<IndexDesktopPlayListItem> createState() =>
      _IndexDesktopPlayListItemState();
}

class _IndexDesktopPlayListItemState
    extends ConsumerState<IndexDesktopPlayListItem> {
  bool hasHover = false;

  @override
  Widget build(BuildContext context) {
    //监听当前播放的music
    final playMusicEntity =
        ref.watch(playProvider.select((value) => value.musicEntity));
    final isPlaying =
        ref.watch(playProvider.select((value) => value.isPlaying));
    return InkWidget(
      onTap: () {
        if (playMusicEntity?.id == widget.entity.id) {
          AudioManager.instance.play(play: !isPlaying);
        } else {
          AudioManager.instance.playMusic(widget.entity);
        }
      },
      onHover: (b) {
        setState(() {
          hasHover = b;
        });
      },
      isCheck: playMusicEntity?.id == widget.entity.id,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.grey[100]!))),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.entity.name ?? "",
                          style: TextStyle(
                              color: playMusicEntity?.id == widget.entity.id
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black,
                              fontSize: 14),
                        ),
                        Text(
                          "${widget.entity.artistName} - ${widget.entity.albumName}",
                          style: TextStyle(
                              color: playMusicEntity?.id == widget.entity.id
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  // Text(widget.entity.name ?? ""),
                  if (hasHover) ...[
                    //播放
                    IconWidget(
                      icon: Icons.play_circle_outlined,
                      selectedIcon: Icons.pause_circle_outline_outlined,
                      isSelect:
                          playMusicEntity?.id == widget.entity.id && isPlaying,
                      size: 18,
                      onPress: () {
                        if (playMusicEntity?.id == widget.entity.id) {
                          AudioManager.instance.play(play: !isPlaying);
                        } else {
                          AudioManager.instance.playMusic(widget.entity);
                        }
                      },
                    ),
                    IconWidget(
                      icon: Icons.favorite_border,
                      selectedIcon: Icons.favorite,
                      isSelect: false,
                      size: 18,
                      onPress: () {},
                    ),
                    IconWidget(
                      icon: Icons.delete,
                      size: 18,
                      onPress: () {
                        AudioManager.instance.deleteMusic(widget.entity);
                        if(widget.delete != null){
                          widget.delete!();
                        }
                      },
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
