import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/pages/songlist/desktop/song_list_desktop_item.dart';
import 'package:dovemusic/pages/songlist/song_list_provider.dart';
import 'package:dovemusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/2 16:25
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListDesktopPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(songListProvider);
    return Scaffold(
        backgroundColor: Colors.white60,
        body: StatusWidget(
          status: model.status,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    S.current.songList,
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                Expanded(
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width ~/ 110,
                        childAspectRatio: 0.9, //子widget宽高比例
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
              ],
            ),
          ),
        ));
  }
}
