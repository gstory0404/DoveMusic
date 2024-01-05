import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/entity/song_list_entity.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/songlist_detail/songlist_detail_provider.dart';
import 'package:larkmusic/utils/sp/sp_manager.dart';
import 'package:larkmusic/widget/filtered_widget.dart';
import 'package:larkmusic/widget/placeholder_image.dart';
import 'package:larkmusic/widget/play_all_button.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/19 14:19
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListDetailTop extends StatelessWidget {
  SongListEntity? entity;

  SongListDetailTop({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 110,
          child: FilteredWidget(
            child: PlaceholderImage(
              width: MediaQuery.of(context).size.width,
              height: 110,
              image: entity?.picture ?? "",
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PlaceholderImage(
                width: 120,
                height: 120,
                image: entity?.picture ?? "",
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entity?.name ?? "",
                      style: const TextStyle(fontSize: 22, color: Colors.white),
                      maxLines: 1,
                    ),
                    Container(height: 6),
                    Text(
                      "${S.current.owner}: ${entity?.userName}" ?? "",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                      maxLines: 1,
                    ),
                    Container(height: 6),
                    Text(
                      "${S.current.desc}：${entity?.desc}" ?? "",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                      maxLines: 1,
                    ),
                    Expanded(child: Container()),
                    Row(
                      children: [
                        PlayAllButton(
                          title: S.current.playAll,
                          icon: Icons.play_arrow,
                          onTap: () {
                            AudioManager.instance
                                .setList(entity?.list ?? [], 0);
                          },
                        ),
                        const SizedBox(width: 4),
                        PlayAllButton(
                          title: S.current.importSongs,
                          icon: Icons.add,
                          onTap: () {
                            AudioManager.instance
                                .setList(entity?.list ?? [], 0);
                          },
                        ),
                        const SizedBox(width: 4),
                        entity?.userId ==
                                SPManager.instance.getUserInfo().userId
                            ? Consumer(builder: (context, ref, _) {
                                return PlayAllButton(
                                  title: S.current.songListDelete,
                                  icon: Icons.delete,
                                  onTap: () {
                                    ref
                                        .watch(songListDetailProvider(
                                                entity?.id ?? 0)
                                            .notifier)
                                        .deleteSongList();
                                  },
                                );
                              })
                            : Container(),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
