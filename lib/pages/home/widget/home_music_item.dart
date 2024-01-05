import 'package:flutter/material.dart';
import 'package:larkmusic/entity/music_entity.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/widget/ink_widget.dart';
import 'package:larkmusic/widget/placeholder_image.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/25 18:53
/// @Email gstory0404@gmail.com
/// @Description: 首页-歌曲列表-item

class HomeMusicItem extends StatelessWidget {
  MusicEntity entity;

  HomeMusicItem({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWidget(
      onTap: () {
        AudioManager.instance.playMusic(entity);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlaceholderImage(
              width: 60,
              height: 60,
              image: entity.picture ?? "",
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                entity.name ?? "",
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface),
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
