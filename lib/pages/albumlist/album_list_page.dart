import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/pages/albumlist/desktop/album_list_desktop_page.dart';
import 'package:dovemusic/pages/base/base_page.dart';
import 'package:dovemusic/routes/app_pages.dart';

import 'phone/phone_list_phone_page.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/8 17:48
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AlbumListPage extends BasePage{

  const AlbumListPage({super.key});


  static void go(BuildContext context){
    context.pushNamed(RouterPage.albumList);
  }

  @override
  Widget desktop() {
    return const AlbumListDesktopPage();
  }

  @override
  Widget phone() {
    return AlbumListPhonePage();
  }
}