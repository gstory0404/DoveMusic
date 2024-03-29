import 'package:flutter/material.dart';
import 'package:dovemusic/pages/index/desktop/index_desktop_menu.dart';
import 'package:dovemusic/pages/index/desktop/index_desktop_play.dart';
import 'package:dovemusic/pages/index/desktop/index_desktop_playlist.dart';
import 'package:dovemusic/pages/index/desktop/index_desktop_title.dart';
import 'package:dovemusic/widget/background_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/4/26 18:19
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexDesktopPage extends StatefulWidget {
  Widget? child;

  IndexDesktopPage({Key? key, required this.child}) : super(key: key);

  @override
  State<IndexDesktopPage> createState() => _IndexDesktopPageState();
}

class _IndexDesktopPageState extends State<IndexDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: IndexDesktopPlayList(),
      ),
      body: BackGroundWidget(
        child: Center(
          child: Row(
            children: [
              const SizedBox(
                width: 180,
                child: IndexDesktopMenu(),
              ),
              const VerticalDivider(width: 0.5),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      const IndexDesktopTitle(),
                      Expanded(
                        child: widget.child!,
                      ),
                      IndexDesktopPlay(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
