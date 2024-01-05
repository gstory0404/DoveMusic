import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/pages/base/base_page.dart';
import 'package:larkmusic/pages/play/desktop/play_desktop_page.dart';
import 'package:larkmusic/pages/play/phone/play_phone_page.dart';
import 'package:larkmusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/21 12:24
/// @Email gstory0404@gmail.com
/// @Description: 播放页

class PlayPage extends BasePage {

  static void go(BuildContext context) {
    context.pushNamed(RouterPage.play);
  }

  @override
  Widget desktop() {
    return PlayDesktopPage();
  }

  @override
  Widget phone() {
    return PlayPhonePage();
  }

}
