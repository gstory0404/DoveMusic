import 'dart:convert';

import 'package:crypto/crypto.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 11:22
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class EncryptUtils {

  //密码进行处理
  static String strToMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return digest.toString();
  }
}
