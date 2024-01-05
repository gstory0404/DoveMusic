import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/albumlist/album_list_provider.dart';
import 'package:larkmusic/pages/albumlist/desktop/album_list_desktop_item.dart';
import 'package:larkmusic/widget/background_widget.dart';
import 'package:larkmusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 16:28
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AlbumListPhonePage extends ConsumerWidget {
  const AlbumListPhonePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(albumListProvider);
    return BackGroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.current.album,
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
                ref.read(albumListProvider.notifier).refreshPage();
              },
              onLoad: () {
                ref.read(albumListProvider.notifier).loadMorePage();
              },
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, //横轴三个子widget
                  childAspectRatio: 1, //子widget宽高比例
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
        ),
      ),
    );
  }
}
