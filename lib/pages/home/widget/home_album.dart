import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/albumlist/album_list_page.dart';
import 'package:larkmusic/pages/home/widget/home_album_item.dart';
import 'package:larkmusic/pages/home/home_provider.dart';
import 'package:larkmusic/widget/ink_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/29 16:55
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class HomeAlbum extends ConsumerWidget {
  HomeAlbum({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumList =
        ref.watch(homeProvider.select((value) => value.albumList));
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    width: 4,
                    height: 20,
                    margin: const EdgeInsets.only(right: 10),
                  ),
                  Text(
                    S.current.album,
                    style: const TextStyle(fontSize: 22, color: Colors.black),
                  )
                ],
              ),
              InkWidget(
                child: Text("${S.current.more} >"),
                onTap: () {
                  AlbumListPage.go(context);
                },
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            height: 120,
            child: ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                itemCount: albumList?.length,
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemExtent: 100,
                itemBuilder: (BuildContext context, int index) {
                  return HomeAlbumItem(entity: albumList![index]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
