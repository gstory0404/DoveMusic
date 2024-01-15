import 'package:flutter/material.dart';
import 'package:dovemusic/entity/album_entity.dart';
import 'package:dovemusic/pages/album/album_page.dart';
import 'package:dovemusic/widget/ink_widget.dart';
import 'package:dovemusic/widget/placeholder_image.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/29 17:16
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class HomeAlbumItem extends StatelessWidget {
  final AlbumEntity entity;

  HomeAlbumItem({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWidget(
      onTap: (){
        AlbumPage.go(context, entity.id);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(6),
        child: Column(
          children: [
            PlaceholderImage(
              width: 80,
              height: 80,
              image: entity.picture ?? "",
            ),
            Container(
              margin: EdgeInsets.only(top: 6),
              child: Text(
                "${entity.name} ${entity.artist}",
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
