import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/pages/mine/mine_provider.dart';

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

  MineSongListItem(
      {super.key, required this.count, this.childAspectRatio = 1.0});

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
                          .then((value) =>
                              ref.read(mineProvider.notifier).getOwnSongList());
                    },
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, _) {
                return EasyRefresh(
                  controller: ref.watch(mineProvider).controller,
                  triggerAxis: Axis.vertical,
                  onRefresh: () {
                    ref.read(mineProvider.notifier).getOwnSongList();
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 10,
                        runSpacing: 10,
                        alignment: WrapAlignment.start,
                        runAlignment: WrapAlignment.start,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: ref
                            .watch(
                                mineProvider.select((value) => value.songList))
                            .map((e) => SongListDesktopItem(entity: e))
                            .toList(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
