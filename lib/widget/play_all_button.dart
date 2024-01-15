import 'package:flutter/material.dart';
import 'package:dovemusic/widget/ink_widget.dart';

import '../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/8 14:40
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class PlayAllButton extends StatelessWidget {
  VoidCallback? onTap;
  IconData? icon;
  String? title;

  PlayAllButton({super.key,this.title,this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWidget(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child:  Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.play_arrow,
              color: Colors.white,
              size: 13,
            ),
            Text(
              title ?? S.current.playAll,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
