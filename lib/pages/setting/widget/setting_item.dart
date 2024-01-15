import 'package:flutter/material.dart';
import 'package:dovemusic/widget/ink_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 16:04
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingItem extends StatelessWidget {
  String title;
  Widget content;
  GestureTapCallback onTap;

  SettingItem(
      {super.key,
      required this.title,
      required this.content,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWidget(
      radius: 8,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.grey[100],
        alignment: Alignment.center,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                maxLines: 1,
              ),
            ),
            content,
          ],
        ),
      ),
    );
  }
}
