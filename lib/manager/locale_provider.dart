import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dovemusic/utils/sp/sp_manager.dart';

import '../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/16 15:39
/// @Email gstory0404@gmail.com
/// @Description: APP Provider

///多语言管理
final localeProvider = StateProvider((ref) {
  return SPManager.instance.getLocale();
});

class LocaleUtil{
  static String getLocaleName(int index) {
    switch (index) {
      case 0:
        return S.current.english;
      case 1:
        return S.current.simplifiedChinese;
      default:
        return "unknown";
    }
  }
}

