import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/setting/widget/setting_content.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 15:43
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingDesktopPage extends ConsumerWidget {
  SettingDesktopPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SettingContent(),
    );
  }
}
