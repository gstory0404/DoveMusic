import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/recently/recently_provider.dart';
import 'package:larkmusic/widget/music_item.dart';
import 'package:larkmusic/widget/play_all_button.dart';
import 'package:larkmusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/14 17:42
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class RecentlyDesktopPage extends ConsumerWidget {
  RecentlyDesktopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(recentlyProvider);
    return Scaffold(
      backgroundColor: Colors.white60,
      body: StatusWidget(status: model.status, child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                S.current.recent,
                style: const TextStyle(fontSize: 36),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: PlayAllButton(
                onTap: () {
                  AudioManager.instance.setList(model.musicList, 0);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              height: 46,
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
                    child:Text(S.current.album),
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
                controller: model.controller,
                triggerAxis: Axis.vertical,
                onRefresh: () {
                  ref.read(recentlyProvider.notifier).refreshPage();
                },
                onLoad: () {
                  ref.read(recentlyProvider.notifier).loadMorePage();
                },
                child: ListView.builder(
                  itemCount: model.musicList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return MusicItem(
                      entity: model.musicList[index],
                      play: () {
                        AudioManager.instance.setList(model.musicList, index);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
