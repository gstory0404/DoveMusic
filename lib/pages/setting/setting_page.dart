import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/pages/base/base_page.dart';
import 'package:dovemusic/pages/setting/desktop/setting_desktop_page.dart';
import 'package:dovemusic/pages/setting/phone/setting_phone_page.dart';
import 'package:dovemusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 15:43
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingPage extends BasePage{

  SettingPage({super.key});

  static void go(BuildContext context) {
    context.pushNamed(RouterPage.setting);
  }

  @override
  Widget desktop() {
    return SettingDesktopPage();
  }

  @override
  Widget phone() {
    return const SettingPhonePage();
  }

}