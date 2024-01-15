import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/pages/home/widget/home_album.dart';
import 'package:dovemusic/pages/home/widget/home_recently.dart';
import 'package:dovemusic/pages/home/widget/home_songlist.dart';
import 'package:dovemusic/pages/search/search_page.dart';
import 'package:dovemusic/widget/icon_widget.dart';

import '../../../generated/l10n.dart';
import '../home_provider.dart';
import '../widget/home_random.dart';
import '../widget/home_singer.dart';

/// @Author: gstory
/// @CreateDate: 2023/10/24 16:23
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class HomePhonePage extends ConsumerWidget {
  HomePhonePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var model = ref.watch(homeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.online),
        backgroundColor: Colors.white12,
        actions: [
          IconWidget(
            icon: Icons.search,
            size: 25,
            iconColor: Colors.black,
            onPress: () {
              SearchPage.go(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white60,
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child:EasyRefresh(
          controller: model.controller,
          triggerAxis: Axis.vertical,
          onRefresh: () {
            ref.read(homeProvider.notifier).refreshPage();
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
        ),
      ),
    );
  }
}
