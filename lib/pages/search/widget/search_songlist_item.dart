import 'package:flutter/material.dart';
import 'package:dovemusic/widget/ink_widget.dart';
import 'package:dovemusic/widget/placeholder_image.dart';

import '../../../entity/song_list_entity.dart';
import '../../songlist_detail/songlist_detail_page.dart';

/// @Author: gstory
/// @CreateDate: 2024/1/4 11:00
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchSongListItem extends StatelessWidget {
  SongListEntity entity;

  SearchSongListItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return InkWidget(
      onTap: (){
        SongListDetailPage.go(context, entity.id);
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
