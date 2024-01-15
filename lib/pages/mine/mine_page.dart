import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/pages/base/base_page.dart';
import 'package:dovemusic/pages/mine/desktop/mine_desktop_page.dart';
import 'package:dovemusic/pages/mine/phone/mine_phone_page.dart';
import 'package:dovemusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 16:40
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MinePage extends BasePage{

  MinePage({super.key});


  static void go(BuildContext context) {
    context.pushNamed(RouterPage.mine);
  }

  @override
  Widget desktop() {
    return MineDesktopPage();
  }

  @override
  Widget phone() {
    return MinePhonePage();
  }

}