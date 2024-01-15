import 'package:flutter/material.dart';
import 'package:dovemusic/entity/song_list_entity.dart';
import 'package:dovemusic/pages/songlist_detail/songlist_detail_page.dart';
import 'package:dovemusic/widget/ink_widget.dart';
import 'package:dovemusic/widget/placeholder_image.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 16:51
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListDesktopItem extends StatelessWidget {
  SongListEntity entity;

  SongListDesktopItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWidget(
        onTap: () {
          SongListDetailPage.go(context, entity.id);
        },
        child: Container(
          padding: EdgeInsets.all(6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PlaceholderImage(
                width: 60,
                height: 60,
                image: entity.picture ?? "",
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "${entity.name}",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
