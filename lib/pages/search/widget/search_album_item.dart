import 'package:flutter/material.dart';
import 'package:dovemusic/pages/album/album_page.dart';

import '../../../entity/album_entity.dart';
import '../../../widget/ink_widget.dart';
import '../../../widget/placeholder_image.dart';

/// @Author: gstory
/// @CreateDate: 2024/1/4 11:34
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchAlbumItem extends StatelessWidget {
  AlbumEntity entity;

  SearchAlbumItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return InkWidget(
      onTap: () {
        AlbumPage.go(context, entity.id);
      },
      child: Container(
        child: Column(
          children: [
            PlaceholderImage(
                image: entity.picture ?? "", width: 60, height: 60),
            Text(
              "${entity.name}",
              style: TextStyle(fontSize: 13, color: Colors.black),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
