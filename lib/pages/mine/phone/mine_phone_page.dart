import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/setting/setting_page.dart';
import 'package:larkmusic/widget/icon_widget.dart';

import '../../../generated/l10n.dart';
import '../widget/mine_songlist_item.dart';
import '../widget/mine_user_item.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 11:39
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MinePhonePage extends ConsumerStatefulWidget {
  const MinePhonePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return MinePhonePageState();
  }
}

class MinePhonePageState extends ConsumerState<MinePhonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(S.current.personalCenter),
        actions: [
          IconWidget(
            icon: Icons.settings,
            size: 20,
            onPress: () {
              SettingPage.go(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white60,
      body: Container(
        child: Column(
          children: [
            MineUserItem(),
            Expanded(
              child: MineSongListItem(
                count: 3,
                childAspectRatio: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
