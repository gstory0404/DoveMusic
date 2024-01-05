import 'package:flutter/material.dart';
import 'package:larkmusic/entity/album_entity.dart';
import 'package:larkmusic/pages/album/album_page.dart';
import 'package:larkmusic/widget/ink_widget.dart';
import 'package:larkmusic/widget/placeholder_image.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/8 17:52
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AlbumListDesktopItem extends StatelessWidget {
  AlbumEntity entity;

  AlbumListDesktopItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWidget(
        onTap: () {
          AlbumPage.go(context, entity.id);
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PlaceholderImage(
                width: 80,
                height: 80,
                image: entity.picture ?? "",
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  entity.name ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
