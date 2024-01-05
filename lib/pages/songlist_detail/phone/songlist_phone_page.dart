import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/songlist_detail/songlist_detail_provider.dart';
import 'package:larkmusic/widget/background_widget.dart';
import 'package:larkmusic/widget/music_item.dart';
import 'package:larkmusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';
import '../widget/songlist_detail_top.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 16:24
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListDetailPhonePage extends ConsumerWidget {
  int songListId;

  SongListDetailPhonePage({Key? key, required this.songListId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(songListDetailProvider(songListId));
    return BackGroundWidget(
        child: Scaffold(
      appBar: AppBar(
        title: Text("${model.songListDetail?.name}"),
      ),
      backgroundColor: Colors.white60,
      body: StatusWidget(status: model.status, child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SongListDetailTop(entity: model.songListDetail),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
                        AudioManager.instance
                            .setList(model.songListDetail?.list ?? [], index);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),)
    ));
  }
}
