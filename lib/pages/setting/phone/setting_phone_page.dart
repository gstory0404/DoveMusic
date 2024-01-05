import 'package:flutter/material.dart';
import 'package:larkmusic/pages/setting/widget/setting_content.dart';
import 'package:larkmusic/widget/background_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 15:43
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingPhonePage extends StatelessWidget {
  const SettingPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackGroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.songList),
        ),
        backgroundColor: Colors.white60,
        body: SettingContent(),
      ),
    );
  }
}
