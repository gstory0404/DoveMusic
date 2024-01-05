import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget/mine_songlist_item.dart';
import '../widget/mine_user_item.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 11:40
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MineDesktopPage extends ConsumerStatefulWidget {
  MineDesktopPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MineDesktopPageState();
  }
}

class MineDesktopPageState extends ConsumerState<MineDesktopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: Container(
        child: Column(
          children: [
            MineUserItem(),
            Expanded(
              child: MineSongListItem(
                count: MediaQuery.of(context).size.width ~/ 110,
                childAspectRatio: 0.9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
