import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/pages/album/desktop/album_desktop_page.dart';
import 'package:dovemusic/pages/album/phone/album_phone_page.dart';
import 'package:dovemusic/pages/base/base_page.dart';
import 'package:dovemusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/8 18:03
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AlbumPage extends BasePage {
  int albumId;

  AlbumPage({super.key, required this.albumId});

  static void go(BuildContext context,int? id) {
    context.pushNamed(RouterPage.album, pathParameters: {"albumId": "$id"});
  }

  @override
  Widget desktop() {
    return AlbumDesktopPage(albumId: albumId);
  }

  @override
  Widget phone() {
    return AlbumPhonePage(albumId: albumId);
  }
}