import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/pages/base/base_page.dart';
import 'package:larkmusic/pages/singerlist/desktop/singer_list_desktop_page.dart';
import 'package:larkmusic/pages/singerlist/phone/singer_list_phone_page.dart';
import 'package:larkmusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 16:25
/// @Email gstory0404@gmail.com
/// @Description: 歌手列表

class SingerListPage extends BasePage{

  static void go(BuildContext context){
    context.pushNamed(RouterPage.singerList);
  }

  @override
  Widget desktop() {
    return SingerListDesktopPage();
  }

  @override
  Widget phone() {
    return SingerListPhonePage();
  }
}