import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/pages/base/base_page.dart';
import 'package:larkmusic/pages/songlist/desktop/song_list_desktop_page.dart';
import 'package:larkmusic/pages/songlist/phone/song_list_phone_page.dart';
import 'package:larkmusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/2 16:23
/// @Email gstory0404@gmail.com
/// @Description: 歌单列表

class SongListPage extends BasePage{

  static void go(BuildContext context){
    context.pushNamed(RouterPage.songList);
  }

  @override
  Widget desktop() {
    return SongListDesktopPage();
  }

  @override
  Widget phone() {
    return SongListPhonePage();
  }
}
