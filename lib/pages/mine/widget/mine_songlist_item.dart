import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/index/index_provider.dart';

import '../../../generated/l10n.dart';
import '../../../widget/icon_widget.dart';
import '../../songlist/desktop/song_list_desktop_item.dart';
import '../../songlist_detail/widget/songlist_create_dialog.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 12:19
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MineSongListItem extends ConsumerWidget {

  int count;
  double childAspectRatio;

  MineSongListItem({super.key,required this.count,this.childAspectRatio = 1.0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Text(
                  S.current.mySongList,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(width: 10),
                Consumer(builder: (context, ref, _) {
                  return IconWidget(
                    icon: Icons.note_add_outlined,
                    iconColor: Colors.black,
                    size: 16,
                    onPress: () {
                      showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return SongListCreateWidget();
                              })
                          .then((value) => ref
                              .read(indexProvider.notifier)
                              .getOwnSongList());
                    },
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                var songList =
                    ref.watch(indexProvider.select((value) => value.songList));
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: count, //横轴三个子widget
                    childAspectRatio: childAspectRatio, //子widget宽高比例
                  ),
                  itemCount: songList.length,
                  itemBuilder: (context, index) {
                    return SongListDesktopItem(
                      entity: songList[index],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
