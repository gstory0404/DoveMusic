import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/pages/console/console_page.dart';
import 'package:dovemusic/pages/home/widget/go_sync_dialog.dart';
import 'package:dovemusic/pages/home/widget/home_album.dart';
import 'package:dovemusic/pages/home/widget/home_recently.dart';
import 'package:dovemusic/pages/home/widget/home_songlist.dart';
import 'package:dovemusic/pages/home/home_provider.dart';
import 'package:dovemusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';
import '../widget/home_random.dart';
import '../widget/home_singer.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/19 16:05
/// @Email gstory0404@gmail.com
/// @Description: 首页 桌面端

class HomeDesktopPage extends ConsumerStatefulWidget {



  HomeDesktopPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeDesktopPageState();
  }
}

class HomeDesktopPageState extends ConsumerState<HomeDesktopPage> {

  bool _isShowSycDialog = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((mag) {
      ref.watch(homeProvider.notifier).addListener(
            (state) {
            if (state.latestMusicList != null && state.latestMusicList!.isEmpty && !_isShowSycDialog) {
              _isShowSycDialog = true;
              showDialog(
                context: context,
                builder: (context) {
                  return GoSyncDialog();
                },
              );
            }
        },
      );
    });
  }


  @override
  Widget build(BuildContext context) {
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
