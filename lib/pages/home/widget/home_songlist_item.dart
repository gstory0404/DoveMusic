import 'package:flutter/material.dart';
import 'package:dovemusic/entity/song_list_entity.dart';
import 'package:dovemusic/pages/songlist_detail/songlist_detail_page.dart';
import 'package:dovemusic/widget/ink_widget.dart';
import 'package:dovemusic/widget/placeholder_image.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/29 16:45
/// @Email gstory0404@gmail.com
/// @Description: 首页-歌单列表-item

class HomeSongListItem extends StatelessWidget {
  final SongListEntity entity;

  const HomeSongListItem({Key? key, required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWidget(
      onTap: () {
        SongListDetailPage.go(context, entity.id);
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(6),
        child: Column(
          children: [
            PlaceholderImage(
              width: 120,
              height: 120,
              image: entity.list?[0].picture ?? "",
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
