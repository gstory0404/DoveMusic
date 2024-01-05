import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/home/widget/home_album.dart';
import 'package:larkmusic/pages/home/widget/home_recently.dart';
import 'package:larkmusic/pages/home/widget/home_songlist.dart';
import 'package:larkmusic/pages/home/home_provider.dart';
import 'package:larkmusic/widget/status_widget.dart';

import '../widget/home_random.dart';
import '../widget/home_singer.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/19 16:05
/// @Email gstory0404@gmail.com
/// @Description: 首页 桌面端

class HomeDesktopPage extends ConsumerWidget {
  HomeDesktopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var model = ref.watch(homeProvider);
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: StatusWidget(
            status: model.status,
            replay: () {
              ref.watch(homeProvider.notifier).refreshPage();
            },
            child: EasyRefresh(
              controller: model.controller,
              triggerAxis: Axis.vertical,
              onRefresh: () {
                ref.watch(homeProvider.notifier).refreshPage();
              },
              child: ListView(
                children: [
                  //随便听听
                  HomeRandom(),
                  //最新入库
                  HomeRecently(),
                  //歌单列表
                  HomeSongList(),
                  //专辑列表
                  HomeAlbum(),
                  //歌手
                  HomeSinger(),
                ],
              ),
            )),
      ),
    );
  }
}
