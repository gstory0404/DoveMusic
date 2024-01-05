import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/album/album_provider.dart';
import 'package:larkmusic/pages/album/desktop/album_desktop_top.dart';
import 'package:larkmusic/widget/music_item.dart';

import '../../../generated/l10n.dart';
import '../../../widget/status_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/8 18:07
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AlbumDesktopPage extends ConsumerWidget {
  int albumId;

  AlbumDesktopPage({Key? key, required this.albumId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final album =
        ref.watch(albumProvider(albumId).select((value) => value.album));
    return Scaffold(
      backgroundColor: Colors.white60,
      body: StatusWidget(
        status: ref.watch(albumProvider(albumId).select((value) => value.status)),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AlbumDesktopTop(entity: album),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                // margin: EdgeInsets.only(top: 14),
                height: 40,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        S.current.music,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        S.current.singer,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        S.current.album,
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
                child: ListView.builder(
                  itemCount: album?.list?.length ?? 0,
                  itemBuilder: (context, index) {
                    return MusicItem(
                      entity: album!.list![index],
                      play: () {
                        AudioManager.instance.setList(album.list ?? [], index);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
