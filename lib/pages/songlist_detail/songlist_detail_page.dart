import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/pages/base/base_page.dart';
import 'package:dovemusic/pages/songlist_detail/desktop/songlist_detail_desktop_page.dart';
import 'package:dovemusic/pages/songlist_detail/phone/songlist_phone_page.dart';
import 'package:dovemusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 16:59
/// @Email gstory0404@gmail.com
/// @Description: 歌手详情

class SongListDetailPage extends BasePage {
  int songListId;

  SongListDetailPage({super.key, required this.songListId});

  static void go(BuildContext context,int? id) {
    context.pushNamed(RouterPage.songListDetail, pathParameters: {"songListId": "$id"});
  }

  @override
  Widget desktop() {
    return SongListDetailDesktopPage(songListId: songListId);
  }

  @override
  Widget phone() {
    return SongListDetailPhonePage(songListId: songListId);
  }
}
