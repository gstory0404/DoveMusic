import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2023/4/26 18:15
/// @Email gstory0404@gmail.com
/// @Description: page基类
abstract class BasePage extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kIsWeb ||
        Platform.isFuchsia ||
        Platform.isWindows ||
        Platform.isMacOS ||
        Platform.isLinux) {
      return desktop();
    }
    return phone();
  }

  Widget phone();

  Widget desktop();
}
