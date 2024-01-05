import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/entity/music_entity.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/album/album_page.dart';
import 'package:larkmusic/pages/play/play_provider.dart';
import 'package:larkmusic/pages/singer/singer_page.dart';
import 'package:larkmusic/widget/icon_widget.dart';
import 'package:larkmusic/widget/ink_widget.dart';

import '../generated/l10n.dart';
import 'songlist_add_song_dialog.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 14:22
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MusicItem extends ConsumerStatefulWidget {
  MusicEntity entity;
  VoidCallback? play;

  MusicItem({super.key, required this.entity, this.play});

  @override
  ConsumerState<MusicItem> createState() => _MusicItemState();
}

class _MusicItemState extends ConsumerState<MusicItem> {
  bool hasHover = false;

  _menuItems(BuildContext context) {
    return <PopupMenuEntry>[
      PopupMenuItem(
        enabled: false,
        height: 10,
        child: Row(
          children: [
            const Icon(
              Icons.audiotrack_outlined,
              size: 16,
              color: Colors.black,
            ),
            Text(
              "${widget.entity.name}",
              style: const TextStyle(fontSize: 14, color: Colors.black),
            )
          ],
        ),
      ),
      const PopupMenuDivider(),
      PopupMenuItem(
        height: 10,
        onTap: () {
          AudioManager.instance.playMusic(widget.entity);
        },
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            S.current.play,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
      ),
      const PopupMenuDivider(),
      PopupMenuItem(
        height: 10,
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return SongListAddSongDialog(id: widget.entity.id ?? 0);
              });
        },
        child: Text(
          S.current.addToSongList,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    //监听当前播放的music
    final playMusicEntity =
        ref.watch(playProvider.select((value) => value.musicEntity));
    final isPlaying =
        ref.watch(playProvider.select((value) => value.isPlaying));
    return InkWidget(
      onHover: (b) {
        setState(() {
          hasHover = b;
        });
      },
      onTap: kIsWeb ||
              Platform.isFuchsia ||
              Platform.isWindows ||
              Platform.isMacOS ||
              Platform.isLinux
          ? null
          : () {
              AudioManager.instance.playMusic(widget.entity);
            },
      onLongPress: (offset) async {
        showMenu(
            context: context,
            color: Colors.white,
            position: RelativeRect.fromLTRB(
              offset.dx / 2,
              offset.dy - 100,
              MediaQuery.of(context).size.width - offset.dx / 2,
              MediaQuery.of(context).size.height - offset.dy + 100,
            ),
            items: _menuItems(context));
      },
      isCheck: playMusicEntity?.id == widget.entity.id,
      radius: 0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        height: 46,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.entity.name ?? "",
                      style: TextStyle(
                        fontSize: 12,
                        color: playMusicEntity?.id == widget.entity.id
                            ? Theme.of(context).colorScheme.primary
                            : Colors.black,
                      ),
                      maxLines: 1,
                    ),
                  ),
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
                    PopupMenuButton(
                      icon: const Icon(
                        Icons.menu,
                        size: 18,
                      ),
                      elevation: 5,
                      padding: const EdgeInsets.all(6),
                      itemBuilder: (BuildContext context) {
                        return _menuItems(context);
                      },
                    ),
                    const SizedBox(width: 20),
                  ],
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWidget(
                onTap: () {
                  if (widget.entity.artistId == 0) {
                    return;
                  }
                  SingerPage.go(context, widget.entity.artistId);
                },
                child: Text(
                  widget.entity.artistName ?? "",
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  maxLines: 1,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWidget(
                onTap: () {
                  if (widget.entity.albumId == 0) {
                    return;
                  }
                  AlbumPage.go(context, widget.entity.albumId);
                },
                child: Container(
                  child: Text(
                    widget.entity.albumName ?? "",
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
