import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/home/home_provider.dart';
import 'package:larkmusic/pages/songlist/song_list_page.dart';

import '../../../generated/l10n.dart';
import 'home_songlist_item.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/29 16:05
/// @Email gstory0404@gmail.com
/// @Description: 首页-歌单列表

class HomeSongList extends ConsumerWidget {
  HomeSongList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songList = ref.watch(homeProvider.select((value) => value.songList));
    return songList?.isNotEmpty ?? false
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.centerLeft,
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
                          S.current.songList,
                          style: const TextStyle(
                              fontSize: 22, color: Colors.black),
                        )
                      ],
                    ),
                    InkWell(
                      child: Text("${S.current.more} >"),
                      onTap: () {
                        SongListPage.go(context);
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,
                  height: 156,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      itemCount: songList?.length,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemExtent: 120,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeSongListItem(entity: songList![index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
