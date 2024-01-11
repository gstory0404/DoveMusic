import 'package:flutter/material.dart';
import 'package:larkmusic/widget/ink_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/17 16:16
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexDesktopItem extends StatelessWidget {
  String title;
  GestureTapCallback onTap;

  IndexDesktopItem({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: InkWidget(
          onTap: onTap,
          child: Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              title,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 13),
            ),
          ),
        ),
      ),
    );
  }
}
