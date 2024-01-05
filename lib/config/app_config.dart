import 'dart:io';

import 'package:flutter/foundation.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/14 09:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AppConfig {
  //一次获取最大数量
  static int maxSize = (kIsWeb ||
          Platform.isFuchsia ||
          Platform.isWindows ||
          Platform.isMacOS ||
          Platform.isLinux)
      ? 30
      : 20;

  //是否开发模式
  static bool isDebug = true;
}
