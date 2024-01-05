import 'package:flutter/material.dart';
import 'package:larkmusic/widget/ink_widget.dart';
import 'package:larkmusic/widget/placeholder_image.dart';

import '../../../entity/music_entity.dart';
import '../../../manager/audio_manager.dart';

/// @Author: gstory
/// @CreateDate: 2024/1/3 17:03
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchMusicItem extends StatelessWidget {
  MusicEntity entity;

  SearchMusicItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return InkWidget(
      onTap: () {
        AudioManager.instance.playMusic(entity);
      },
      child: Container(
        margin: EdgeInsets.only(top: 6),
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
              style: TextStyle(fontSize: 13, color: Colors.black),
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
