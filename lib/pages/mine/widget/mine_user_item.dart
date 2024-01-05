import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/config/assets_image.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:larkmusic/pages/index/index_page.dart';
import 'package:larkmusic/pages/login/login_page.dart';
import 'package:larkmusic/pages/mine/mine_provider.dart';
import 'package:larkmusic/pages/mine/widget/update_psd_dialog.dart';
import 'package:larkmusic/utils/sp/sp_manager.dart';
import 'package:larkmusic/widget/ink_widget.dart';
import 'package:larkmusic/widget/placeholder_image.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 12:01
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MineUserItem extends ConsumerWidget {
  const MineUserItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(mineProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      color: Colors.white54,
      child: Row(
        children: [
          PlaceholderImage(
            width: 60,
            height: 60,
            radius: 30,
            image: "",
            assetName: AssetsImages.iconUser,
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.userName,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                Text(
                  "${S.current.account}: ${state.userAccount}",
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
                Text(
                  "ID: ${state.userId}",
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
          InkWidget(
            child: Text(
              S.current.changePsd,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            onTap: () async {
              await showDialog(
                context: context,
                builder: (BuildContext context) => const UpdatePsdDialog(),
              );
            },
          ),
          const SizedBox(width: 10),
          InkWidget(
            child: Text(
              S.current.loginOut,
              style: TextStyle(fontSize: 12, color: Colors.black),
            ),
            onTap: () async {
              SPManager.instance.cleanUserInfo();
              AudioManager.instance.stop();
              LoginPage.go(context);
            },
          ),
        ],
      ),
    );
  }
}
