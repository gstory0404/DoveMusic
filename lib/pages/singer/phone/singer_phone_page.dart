import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/manager/audio_manager.dart';
import 'package:dovemusic/pages/singer/desktop/singer_desktop_top.dart';
import 'package:dovemusic/pages/singer/singer_provider.dart';
import 'package:dovemusic/widget/background_widget.dart';
import 'package:dovemusic/widget/music_item.dart';
import 'package:dovemusic/widget/status_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 16:14
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述
///

class SingerPhonePage extends ConsumerWidget {
  int singerId;

  SingerPhonePage({Key? key, required this.singerId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(singerProvider(singerId));
    return BackGroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${model.singer?.name}",
          ),
        ),
        body: StatusWidget(
          status: model.status,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingerDesktopTop(entity: model.singer),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(S.current.musicName),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(S.current.singer),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(S.current.album),
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
                    itemCount: model.singer?.list?.length ?? 0,
                    itemBuilder: (context, index) {
                      return MusicItem(
                        entity: model.singer!.list![index],
                        play: () {
                          AudioManager.instance
                              .setList(model.singer?.list ?? [], index);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
