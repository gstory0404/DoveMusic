import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/console/console_provider.dart';
import 'package:larkmusic/pages/console/widget/sync_dialog.dart';

import '../../../generated/l10n.dart';
import '../../../widget/icon_widget.dart';
import '../../setting/widget/setting_item.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/22 11:22
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ConsoleContent extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      child: ListView(
        children: [
          //同步音乐文件
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SettingItem(
              title: S.current.syncMusic,
              content: IconWidget(icon: Icons.chevron_right, size: 16),
              onTap: () {
                ref.watch(consoleProvider.notifier).syncMusic();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return SyncDialog();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
