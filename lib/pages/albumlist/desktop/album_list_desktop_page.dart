import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/pages/albumlist/album_list_provider.dart';
import 'package:dovemusic/pages/albumlist/desktop/album_list_desktop_item.dart';
import 'package:dovemusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/8 17:51
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AlbumListDesktopPage extends ConsumerWidget {
  const AlbumListDesktopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(albumListProvider);
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
                    S.current.album,
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                Expanded(
                  child: EasyRefresh(
                    controller: model.controller,
                    triggerAxis: Axis.vertical,
                    onRefresh: () {
                      ref.read(albumListProvider.notifier).refreshPage();
                    },
                    onLoad: () {
                      ref.read(albumListProvider.notifier).loadMorePage();
                    },
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width ~/ 130,
                        childAspectRatio: 0.9, //子widget宽高比例
                      ),
                      itemCount: model.albumList.length,
                      itemBuilder: (context, index) {
                        return AlbumListDesktopItem(
                          entity: model.albumList[index],
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
