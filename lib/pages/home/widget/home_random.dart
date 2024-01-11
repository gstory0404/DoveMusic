import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/widget/ink_widget.dart';

import '../../../generated/l10n.dart';
import '../../../manager/audio_manager.dart';
import '../../../widget/play_all_button.dart';
import '../home_provider.dart';
import 'home_music_item.dart';

/// @Author: gstory
/// @CreateDate: 2024/1/5 11:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class HomeRandom extends ConsumerWidget {
  HomeRandom({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final randomMusicList =
        ref.watch(homeProvider.select((value) => value.randomMusicList));
    return randomMusicList?.isNotEmpty ?? false
        ? Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      color: Theme.of(context).primaryColor,
                      width: 4,
                      height: 20,
                      margin: const EdgeInsets.only(right: 10),
                    ),
                    Text(
                      S.current.recommend,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                    ),
                    const SizedBox(width: 10),
                    PlayAllButton(
                      title: S.current.playAll,
                      icon: Icons.play_arrow,
                      onTap: () {
                        if (randomMusicList?.isNotEmpty ?? false) {
                          AudioManager.instance.setList(randomMusicList!, 0);
                        }
                      },
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 100,
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: ListView.builder(
                      itemCount: randomMusicList?.length,
                      scrollDirection: Axis.horizontal,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemExtent: 80,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeMusicItem(entity: randomMusicList![index]);
                      },
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
