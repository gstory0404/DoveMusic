import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/pages/base/base_page.dart';
import 'package:larkmusic/pages/singer/desktop/singer_desktop_page.dart';
import 'package:larkmusic/pages/singer/phone/singer_phone_page.dart';
import 'package:larkmusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 16:59
/// @Email gstory0404@gmail.com
/// @Description: 歌手详情

class SingerPage extends BasePage {
  int singerId;

  SingerPage({super.key, required this.singerId});

  static void go(BuildContext context,int? id) {
    context.pushNamed(RouterPage.singer, pathParameters: {"singerId": "$id"});
  }

  @override
  Widget desktop() {
    return SingerDesktopPage(singerId: singerId);
  }

  @override
  Widget phone() {
   return SingerPhonePage(singerId: singerId);
  }
}
