import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/net/dv_http.dart';
import 'package:dovemusic/pages/mine/mine_provider.dart';
import 'package:dovemusic/widget/ink_widget.dart';
import 'package:dovemusic/widget/placeholder_image.dart';

import '../config/net_api.dart';
import '../generated/l10n.dart';
import '../pages/index/index_provider.dart';
import '../utils/toast/toast_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/15 12:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListAddSongDialog extends ConsumerWidget {
  int id;

  SongListAddSongDialog({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var songList = ref.watch(mineProvider.select((value) => value.songList));
    return AlertDialog(
      title: Text(
        S.current.songListAddMusic,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      titleTextStyle: const TextStyle(fontSize: 20, color: Colors.white),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Container(
        width: 150,
        child: Wrap(
          children: songList
              .map(
                (value) => Container(
                  margin: EdgeInsets.only(top: 10),
                  child: InkWidget(
                    onTap: () {
                      _songListAddMusic(context, value.id ?? 0);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          PlaceholderImage(
                              image: value.picture ?? "",
                              width: 40,
                              height: 40),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  value.name ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  value.desc ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Text(
                                  "${value.userId}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  //歌单添加歌曲
  void _songListAddMusic(BuildContext context, int songListId) {
    DMHttp.instance.post<String>(NetApi.songListAddMusic, data: {
      "id": songListId,
      "music_ids": [id]
    }, success: (data) {
      ToastUtils.show(S.current.addSuccess);
      Navigator.of(context).pop();
    }, fail: (code, message) {
      ToastUtils.show("$code $message");
    });
  }
}
