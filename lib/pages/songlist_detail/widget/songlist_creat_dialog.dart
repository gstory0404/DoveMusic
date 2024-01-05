import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/net/lm_http.dart';
import 'package:larkmusic/pages/songlist_detail/songlist_detail_page.dart';

import '../../../config/net_api.dart';
import '../../../generated/l10n.dart';
import '../../../utils/toast/toast_util.dart';
import '../../../widget/input_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/15 12:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListCreateWidget extends StatelessWidget {
  SongListCreateWidget({super.key});

  String? _name;
  String? _desc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.createSongList),
      titleTextStyle: const TextStyle(fontSize: 20, color: Colors.white),
      backgroundColor: Colors.grey,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Wrap(
        children: [
          Column(
            children: [
              InputWidget(
                lable: S.current.songListName,
                icon: const Icon(Icons.title),
                minWidth: 400,
                maxWidth: 400,
                maxLength: 20,
                maxLines: 1,
                radius: 10,
                onChanged: (data) {
                  _name = data;
                },
              ),
              InputWidget(
                lable: S.current.songListDesc,
                icon: const Icon(Icons.content_paste),
                minWidth: 400,
                maxWidth: 400,
                maxLength: 100,
                maxLines: 5,
                minLines: 1,
                radius: 10,
                onChanged: (data) {
                  _desc = data;
                },
              ),
            ],
          )
        ],
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0)),
          child: Text(S.current.cancel,
              style: const TextStyle(color: Colors.black)),
          onPressed: () {
            context.pop();
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor)),
          child:
              Text(S.current.sure, style: const TextStyle(color: Colors.white)),
          onPressed: () {
            if (_name?.isEmpty ?? true) {
              ToastUtils.show(S.current.songListNameEmpty);
              return;
            }
            if (_desc?.isEmpty ?? true) {
              ToastUtils.show(S.current.songListDescEmpty);
              return;
            }
            _createSongList(context);
          },
        ),
      ],
    );
  }

  //创建歌单
  void _createSongList(BuildContext context) {
    LMHttp.instance.post<int>(NetApi.create,
        data: {"name": _name, "desc": _desc}, success: (data) {
      SongListDetailPage.go(context, data);
      context.pop(data);
    }, fail: (code, message) {
      ToastUtils.show("$code $message");
    });
  }
}
