import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/config/assets_image.dart';
import 'package:larkmusic/generated/l10n.dart';
import 'package:larkmusic/pages/albumlist/album_list_page.dart';
import 'package:larkmusic/pages/home/home_page.dart';
import 'package:larkmusic/pages/index/desktop/index_desktop_item.dart';
import 'package:larkmusic/pages/index/index_provider.dart';
import 'package:larkmusic/pages/recently/recently_page.dart';
import 'package:larkmusic/pages/singerlist/singer_list_page.dart';
import 'package:larkmusic/pages/songlist/song_list_page.dart';
import 'package:larkmusic/pages/songlist_detail/songlist_detail_page.dart';
import 'package:larkmusic/pages/songlist_detail/widget/songlist_creat_dialog.dart';
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
                Text(
                  S.current.appName,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    S.current.online,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onBackground),
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
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        S.current.mySongList,
                        style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onBackground),
                      ),
                      const SizedBox(width: 10),
                      Consumer(builder: (context, ref, _) {
                        return IconWidget(
                          icon: Icons.note_add_outlined,
                          iconColor: Colors.white,
                          size: 16,
                          onPress: () {
                            showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SongListCreateWidget();
                                    })
                                .then((value) => ref
                                    .read(indexProvider.notifier)
                                    .getOwnSongList());
                          },
                        );
                      }),
                    ],
                  ),
                ),
                Consumer(
                  builder: (context, ref, _) {
                    var songList = ref
                        .watch(indexProvider.select((value) => value.songList));
                    return Column(
                      // shrinkWrap: true,
                      children: songList
                          .map(
                            (item) => IndexDesktopItem(
                              title: "${item.name}",
                              onTap: () {
                                SongListDetailPage.go(context, item.id);
                              },
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
