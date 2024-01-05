import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/search/search_provider.dart';
import 'package:larkmusic/utils/toast/toast_util.dart';
import 'package:larkmusic/widget/background_widget.dart';
import 'package:larkmusic/widget/ink_widget.dart';
import 'package:larkmusic/widget/music_item.dart';
import 'package:larkmusic/widget/play_all_button.dart';
import 'package:larkmusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';
import '../widget/search_album_item.dart';
import '../widget/search_music_item.dart';
import '../widget/search_singer_item.dart';
import '../widget/search_songlist_item.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 18:12
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchPhonePage extends ConsumerWidget {
  SearchPhonePage({super.key});

  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(searchProvider);
    return BackGroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  child: TextField(
                    // focusNode: _nameFocusNode,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(top: 0, bottom: 0),
                      border: const OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      hintText: S.current.enterMusicName,
                      hintStyle:
                          const TextStyle(fontSize: 16, color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.music_note_rounded,
                        size: 18,
                      ),
                    ),
                    controller: _textEditingController,
                  ),
                ),
              ),
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
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(14),
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
        backgroundColor: Colors.transparent,
        body: StatusWidget(
          status: model.status,
          replay: () {
            ref
                .read(searchProvider.notifier)
                .getSearchList(_textEditingController.text);
          },
          child: EasyRefresh(
            controller: model.controller,
            triggerAxis: Axis.vertical,
            onRefresh: () {
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
      ),
    );
  }
}
