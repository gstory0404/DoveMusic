import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/pages/base/base_page.dart';
import 'package:larkmusic/pages/home/desktop/home_desktop_page.dart';
import 'package:larkmusic/pages/home/phone/home_phone_page.dart';
import 'package:larkmusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/17 11:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class HomePage extends BasePage {

  static void go(BuildContext context){
    context.goNamed(RouterPage.home);
  }

  @override
  Widget desktop() {
    return HomeDesktopPage();
  }

  @override
  Widget phone() {
    return HomePhonePage();
  }
}
