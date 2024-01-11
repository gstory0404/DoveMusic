import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/config/assets_image.dart';
import 'package:larkmusic/generated/l10n.dart';
import 'package:larkmusic/pages/albumlist/album_list_page.dart';
import 'package:larkmusic/pages/home/home_page.dart';
import 'package:larkmusic/pages/index/desktop/index_desktop_item.dart';
import 'package:larkmusic/pages/index/index_provider.dart';
import 'package:larkmusic/pages/mine/mine_page.dart';
import 'package:larkmusic/pages/recently/recently_page.dart';
import 'package:larkmusic/pages/singerlist/singer_list_page.dart';
import 'package:larkmusic/pages/songlist/song_list_page.dart';
import 'package:larkmusic/pages/songlist_detail/songlist_detail_page.dart';
import 'package:larkmusic/pages/songlist_detail/widget/songlist_create_dialog.dart';
import 'package:larkmusic/widget/icon_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/17 16:56
/// @Email gstory0404@gmail.com
/// @Description: 首页菜单

class IndexDesktopMenu extends StatefulWidget {
  const IndexDesktopMenu({Key? key}) : super(key: key);

  @override
  State<IndexDesktopMenu> createState() => _IndexDesktopMenuState();
}

class _IndexDesktopMenuState extends State<IndexDesktopMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            // margin: const EdgeInsets.only(top: 40, bottom: 20),
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsImages.logo,
                  width: 50,
                  height: 50,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(height: 10),
                Text(
                  S.current.appName,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    S.current.online,
                    style: const TextStyle(fontSize: 12,color: Colors.black45),
                  ),
                ),
                IndexDesktopItem(
                    title: S.current.home,
                    onTap: () {
                      HomePage.go(context);
                    }),
                IndexDesktopItem(
                    title: S.current.recent,
                    onTap: () {
                      RecentlyPage.go(context);
                    }),
                IndexDesktopItem(
                    title: S.current.singer,
                    onTap: () {
                      SingerListPage.go(context);
                    }),
                IndexDesktopItem(
                    title: S.current.album,
                    onTap: () {
                      AlbumListPage.go(context);
                    }),
                IndexDesktopItem(
                    title: S.current.songList,
                    onTap: () {
                      SongListPage.go(context);
                    }),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    S.current.personalCenter,
                    style: const TextStyle(fontSize: 12,color: Colors.black45),
                  ),
                ),
                IndexDesktopItem(
                    title: S.current.mySongList,
                    onTap: () {
                      MinePage.go(context);
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
