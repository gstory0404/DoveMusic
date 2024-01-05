import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/play/play_provider.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/7 12:30
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class VolumeWidget extends PopupRoute {
  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            Positioned(
              right: 50,
              bottom: 60,
              child: Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final volume =
                  ref.watch(playProvider.select((value) => value.volume));
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Slider(
                        value: volume,
                        min: 0,
                        max: 1,
                        divisions: 20,
                        thumbColor: Theme.of(context).colorScheme.primary,
                        activeColor:Theme.of(context).colorScheme.primary,
                        inactiveColor:Colors.grey[500],
                          label:"${(volume * 100).toInt()}",
                        onChanged: (value) {
                          AudioManager.instance.setVolume(value);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}
