import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/manager/audio_manager.dart';
import 'package:dovemusic/pages/search/search_provider.dart';
import 'package:dovemusic/pages/search/widget/search_album_item.dart';
import 'package:dovemusic/pages/search/widget/search_music_item.dart';
import 'package:dovemusic/pages/search/widget/search_singer_item.dart';
import 'package:dovemusic/utils/toast/toast_util.dart';
import 'package:dovemusic/widget/ink_widget.dart';
import 'package:dovemusic/widget/music_item.dart';
import 'package:dovemusic/widget/play_all_button.dart';
import 'package:dovemusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';
import '../widget/search_songlist_item.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 17:34
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchDesktopPage extends ConsumerWidget {
  SearchDesktopPage({super.key});

  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(searchProvider);
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      child: TextField(
                        // focusNode: _nameFocusNode,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(top: 0, bottom: 0),
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          hintText: S.current.enterMusicName,
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.music_note_rounded,
                            size: 24,
                          ),
                        ),
                        controller: _textEditingController,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWidget(
                    onTap: () {
                      if (_textEditingController.text.isEmpty) {
                        ToastUtils.show(S.current.enterMusicName);
                        return;
                      }
                      ref
                          .read(searchProvider.notifier)
                          .getSearchList(_textEditingController.text);
                    },
                    radius: 20,
                    child: Container(
                      alignment: Alignment.center,
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        S.current.search,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[100],
            ),
            Expanded(
              child: StatusWidget(
                status: model.status,
                replay: () {
                  ref
                      .read(searchProvider.notifier)
                      .getSearchList(_textEditingController.text);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //歌单
                      model.searchEntity?.songListList?.isNotEmpty ?? false
                          ? Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  color: Theme.of(context).primaryColor,
                                  width: 4,
                                  height: 20,
                                  margin:
                                  const EdgeInsets.only(right: 10),
                                ),
                                Text(
                                  S.current.songList,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 80,
                              child: ListView.builder(
                                itemCount: model
                                    .searchEntity?.songListList?.length,
                                scrollDirection: Axis.horizontal,
                                itemExtent: 70,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SearchSongListItem(
                                    entity: model.searchEntity!
                                        .songListList![index],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                          : Container(),
                      //歌手
                      model.searchEntity?.singerList?.isNotEmpty ?? false
                          ? Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  color: Theme.of(context).primaryColor,
                                  width: 4,
                                  height: 20,
                                  margin:
                                  const EdgeInsets.only(right: 10),
                                ),
                                Text(
                                  S.current.singer,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 80,
                              child: ListView.builder(
                                itemCount: model
                                    .searchEntity?.singerList?.length,
                                scrollDirection: Axis.horizontal,
                                itemExtent: 70,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SearchSingerItem(
                                    entity: model.searchEntity!
                                        .singerList![index],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                          : Container(),
                      //专辑
                      model.searchEntity?.albumList?.isNotEmpty ?? false
                          ? Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  color: Theme.of(context).primaryColor,
                                  width: 4,
                                  height: 20,
                                  margin:
                                  const EdgeInsets.only(right: 10),
                                ),
                                Text(
                                  S.current.album,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 80,
                              child: ListView.builder(
                                itemCount: model
                                    .searchEntity?.albumList?.length,
                                scrollDirection: Axis.horizontal,
                                itemExtent: 70,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return SearchAlbumItem(
                                    entity: model.searchEntity!
                                        .albumList![index],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                          : Container(),
                      //歌曲
                      model.searchEntity?.musicList?.isNotEmpty ?? false
                          ? Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  color: Theme.of(context).primaryColor,
                                  width: 4,
                                  height: 20,
                                  margin:
                                  const EdgeInsets.only(right: 10),
                                ),
                                Text(
                                  S.current.music,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: ListView.builder(
                                itemCount: model
                                    .searchEntity?.musicList?.length,
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return SearchMusicItem(
                                    entity: model.searchEntity!
                                        .musicList![index],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
