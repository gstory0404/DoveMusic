import 'package:flutter/material.dart';
import 'package:dovemusic/widget/ink_widget.dart';
import 'package:dovemusic/widget/placeholder_image.dart';

import '../../../entity/music_entity.dart';
import '../../../generated/l10n.dart';
import '../../../manager/audio_manager.dart';
import '../../../widget/songlist_add_song_dialog.dart';

/// @Author: gstory
/// @CreateDate: 2024/1/3 17:03
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchMusicItem extends StatelessWidget {
  MusicEntity entity;

  SearchMusicItem({super.key, required this.entity});

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
            ),
            Expanded(
              child: Text(
                "${entity.name}",
                style: const TextStyle(fontSize: 14),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
      const PopupMenuDivider(),
      PopupMenuItem(
        height: 10,
        onTap: () {
          AudioManager.instance.playMusic(entity);
        },
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            S.current.play,
            style: const TextStyle(fontSize: 14),
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
                return SongListAddSongDialog(id: entity.id ?? 0);
              });
        },
        child: Text(
          S.current.addToSongList,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return InkWidget(
      onTap: () {
        AudioManager.instance.playMusic(entity);
      },
      onLongPress: (offset) async {
        showMenu(
            context: context,
            constraints: const BoxConstraints(
              maxWidth: 200,
              minWidth: 80,
            ),
            position: RelativeRect.fromLTRB(
              offset.dx / 2,
              offset.dy - 100,
              MediaQuery.of(context).size.width - offset.dx / 2,
              MediaQuery.of(context).size.height - offset.dy + 100,
            ),
            items: _menuItems(context));
      },
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${entity.name}",
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            SizedBox(height: 4),
            Text(
              "${entity.artistName} · ${entity.albumName}",
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.grey.shade300,
              height: 1,
              margin: const EdgeInsets.only(top: 4),
            )
          ],
        ),
      ),
    );
  }
}
