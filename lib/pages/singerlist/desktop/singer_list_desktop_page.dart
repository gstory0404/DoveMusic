import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/singerlist/desktop/singer_list_desktop_item.dart';
import 'package:larkmusic/pages/singerlist/singer_list_provider.dart';
import 'package:larkmusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 16:37
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SingerListDesktopPage extends ConsumerWidget {
  const SingerListDesktopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(singerListProvider);
    return Scaffold(
      backgroundColor: Colors.white60,
      body: StatusWidget(status: model.status, child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                S.current.singer,
                style: TextStyle(fontSize: 36),
              ),
            ),
            Expanded(
              child: EasyRefresh(
                controller: model.controller,
                triggerAxis: Axis.vertical,
                onRefresh: () {
                  ref.read(singerListProvider.notifier).refreshPage();
                },
                onLoad: () {
                  ref.read(singerListProvider.notifier).loadMorePage();
                },
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width ~/ 110,
                    childAspectRatio: 0.9, //子widget宽高比例
                  ),
                  itemCount: model.singerList.length,
                  itemBuilder: (context, index) {
                    return SingerListDesktopItem(
                      entity: model.singerList[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),)
    );
  }
}
