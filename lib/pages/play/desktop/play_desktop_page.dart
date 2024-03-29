import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/pages/play/play_provider.dart';
import 'package:dovemusic/pages/play/widget/Lyric_widget.dart';
import 'package:dovemusic/widget/filtered_widget.dart';
import 'package:dovemusic/widget/placeholder_image.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/21 12:25
/// @Email gstory0404@gmail.com
/// @Description: 播放页桌面端

class PlayDesktopPage extends ConsumerWidget {
  final lyricUI = UINetease();

  PlayDesktopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final picture =
        ref.watch(playProvider.select((value) => value.musicEntity?.picture));
    return Scaffold(
      body: Stack(
        children: [
          FilteredWidget(
            child: PlaceholderImage(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              image: picture ?? "",
              radius: 0,
            ),
          ),
          LyricWidget(),
        ],
      ),
    );
  }
}
