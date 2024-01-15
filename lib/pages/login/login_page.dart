import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/pages/base/base_page.dart';
import 'package:dovemusic/pages/login/desktop/login_desktop_page.dart';
import 'package:dovemusic/pages/login/phone/login_phone_page.dart';
import 'package:dovemusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/24 15:10
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class LoginPage extends BasePage{

  LoginPage({super.key});

  static void go(BuildContext context) {
    context.pushReplacementNamed(RouterPage.login);
    if(context.canPop()){
      context.pop();
    }
  }

  @override
  Widget desktop() {
    return LoginDesktopPage();
  }

  @override
  Widget phone() {
    return LoginPhonePage();
  }

}