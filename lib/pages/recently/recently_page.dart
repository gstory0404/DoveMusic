import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/pages/base/base_page.dart';
import 'package:larkmusic/pages/recently/desktop/recently_desktop_page.dart';
import 'package:larkmusic/pages/recently/phone/recently_phone_page.dart';
import 'package:larkmusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/14 17:41
/// @Email gstory0404@gmail.com
/// @Description: 最近入库

class RecentlyPage extends BasePage{

  static void go(BuildContext context){
    context.pushNamed(RouterPage.recently);
  }

  @override
  Widget desktop() {
    return RecentlyDesktopPage();
  }

  @override
  Widget phone() {
    return RecentlyPhonePage();
  }

}