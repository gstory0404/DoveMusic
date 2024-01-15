import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/pages/base/base_page.dart';
import 'package:dovemusic/pages/search/desktop/search_desktop_page.dart';
import 'package:dovemusic/pages/search/phone/search_phone_page.dart';
import 'package:dovemusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 17:30
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchPage extends BasePage{

  const SearchPage({super.key});


  static void go(BuildContext context){
    context.pushNamed(RouterPage.search);
  }

  @override
  Widget desktop() {
    return SearchDesktopPage();
  }

  @override
  Widget phone() {
    return SearchPhonePage();
  }

}