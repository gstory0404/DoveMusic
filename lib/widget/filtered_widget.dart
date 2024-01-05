import 'dart:ui';

import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/9 10:00
/// @Email gstory0404@gmail.com
/// @Description: 半透明遮罩层

class FilteredWidget extends StatelessWidget {
  Widget child;

  FilteredWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: child,
          ),
          Container(
            color: Colors.black26,
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }
}
