import 'package:flutter/material.dart';
import 'package:flutter_list_view/flutter_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/manager/audio_manager.dart';
import 'package:dovemusic/pages/index/desktop/index_desktop_playlist_item.dart';

import '../../../generated/l10n.dart';
import '../../play/play_provider.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/7 16:05
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexDesktopPlayList extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _IndexDesktopPlayListState();
  }
}

class _IndexDesktopPlayListState extends ConsumerState<IndexDesktopPlayList> {
  final _controller = FlutterListViewController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((mag) {
      var music = ref.watch(playProvider.select((value) => value.musicEntity));
      for (var i = 0; i < AudioManager.instance.getPlayList().length; i++) {
        if (AudioManager.instance.getPlayList()[i].id == music?.id) {
          _controller.sliverController.jumpToIndex(i);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.playList,
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: FlutterListView(
          controller: _controller,
          delegate: FlutterListViewDelegate(
            (BuildContext context, int index) => IndexDesktopPlayListItem(
              entity: AudioManager.instance.getPlayList()[index],
              delete: () {
                setState(() {});
              },
            ),
            childCount: AudioManager.instance.getPlayList().length,
          ),
        ),
      ),
    );
  }
}
