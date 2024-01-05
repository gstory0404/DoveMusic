import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/play/play_provider.dart';
import 'package:larkmusic/widget/icon_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 15:30
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class LyricWidget extends ConsumerWidget {
  final lyricUI = UINetease();

  LyricWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lyrics =
        ref.watch(playProvider.select((value) => value.musicEntity?.lyrics));
    final curDuration =
        ref.watch(playProvider.select((value) => value.curDuration));
    final isPlaying =
        ref.watch(playProvider.select((value) => value.isPlaying));
    return LyricsReader(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      model: LyricsModelBuilder.create()
          .bindLyricToMain(lyrics ?? "")
          .getModel(),
      position: curDuration.inMilliseconds,
      lyricUi: lyricUI,
      playing: isPlaying,
      size: const Size(double.infinity, double.infinity),
      emptyBuilder: () => Center(
        child: Text(
          S.current.lyricEmpty,
          style: lyricUI.getOtherMainTextStyle(),
        ),
      ),
      selectLineBuilder: (progress, confirm) {
        return Row(
          children: [
            IconWidget(
              icon: Icons.play_arrow,
              size: 20,
              iconColor: Colors.white,
              onPress: () {
                confirm.call();
                ref
                    .read(playProvider.notifier)
                    .seek(Duration(milliseconds: progress));
              },
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary),
                height: 1,
                width: double.infinity,
              ),
            ),
            Text(
              Duration(milliseconds: progress).toString().substring(0, 7),
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            )
          ],
        );
      },
    );
  }
}
