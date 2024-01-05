import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/24 17:49
/// @Email gstory0404@gmail.com
/// @Description: Toast消息工具

class ToastUtils {
  static void show(String msg) {
    showToast(
      msg,
      duration: const Duration(seconds: 1),
      position: ToastPosition.bottom,
      backgroundColor: Colors.black.withOpacity(0.8),
      radius: 10.0,
      textStyle: const TextStyle(fontSize: 13.0,color: Colors.white),
    );
  }
}
