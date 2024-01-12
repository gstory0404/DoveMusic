import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/index/index_provider.dart';
import 'package:larkmusic/pages/mine/mine_provider.dart';
import 'package:larkmusic/pages/songlist_detail/songlist_detail_provider.dart';
import 'package:larkmusic/pages/songlist_detail/widget/songlist_detail_top.dart';
import 'package:larkmusic/utils/toast/toast_util.dart';
import 'package:larkmusic/widget/music_item.dart';
import 'package:larkmusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 17:00
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListDetailDesktopPage extends ConsumerWidget {
  int songListId;

  SongListDetailDesktopPage({Key? key, required this.songListId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(songListDetailProvider(songListId), (previous, next) {
      if (next.isDelete ?? false) {
        ToastUtils.show(S.current.deleteSongListSuccess);
        ref.watch(mineProvider.notifier).getOwnSongList();
        context.pop();
      }
    });
    final model = ref.watch(songListDetailProvider(songListId));
    return Scaffold(
        body: StatusWidget(
          status: model.status,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SongListDetailTop(entity: model.songListDetail),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  margin: EdgeInsets.only(top: 14),
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(S.current.musicName),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(S.current.singer),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(S.current.album),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey[100],
                ),
                Expanded(
                  child: EasyRefresh(
                    triggerAxis: Axis.vertical,
                    onRefresh: () {
                      ref
                          .read(songListDetailProvider(songListId).notifier)
                          .getSongListDetail();
                    },
                    child: ListView.builder(
                      itemCount: model.songListDetail?.list?.length ?? 0,
                      itemBuilder: (context, index) {
                        return MusicItem(
                          entity: model.songListDetail!.list![index],
                          play: () {
                            AudioManager.instance.setList(
                                model.songListDetail?.list ?? [], index);
                          },
                          menus: [
                            const PopupMenuDivider(),
                            PopupMenuItem(
                              height: 10,
                              onTap: () {
                                ref
                                    .watch(songListDetailProvider(songListId)
                                        .notifier)
                                    .deleteSong([
                                  model.songListDetail!.list![index].id!
                                ]);
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  S.current.delete,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
