import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/songlist/desktop/song_list_desktop_item.dart';
import 'package:larkmusic/pages/songlist/song_list_provider.dart';
import 'package:larkmusic/widget/background_widget.dart';
import 'package:larkmusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 16:22
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListPhonePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(songListProvider);
    return BackGroundWidget(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                S.current.songList,
              ),
            ),
            backgroundColor: Colors.white60,
            body: StatusWidget(
              status: model.status,
              child: Container(
                child: EasyRefresh(
                  controller: model.controller,
                  triggerAxis: Axis.vertical,
                  onRefresh: () {
                    ref.read(songListProvider.notifier).refreshPage();
                  },
                  onLoad: () {
                    ref.read(songListProvider.notifier).loadMorePage();
                  },
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //横轴三个子widget
                      childAspectRatio: 1, //子widget宽高比例
                    ),
                    itemCount: model.songList.length,
                    itemBuilder: (context, index) {
                      return SongListDesktopItem(
                        entity: model.songList[index],
                      );
                    },
                  ),
                ),
              ),
            )));
  }
}
