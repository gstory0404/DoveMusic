import 'package:flutter/material.dart';
import 'package:dovemusic/entity/singer_entity.dart';
import 'package:dovemusic/pages/singer/singer_page.dart';
import 'package:dovemusic/widget/ink_widget.dart';
import 'package:dovemusic/widget/placeholder_image.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 16:51
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SingerListDesktopItem extends StatelessWidget {
  SingerEntity entity;

  SingerListDesktopItem({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWidget(
        onTap: () {
          SingerPage.go(context, entity.id);
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlaceholderImage(
                width: 60,
                height: 60,
                image: entity.picture ?? "",
              ),
              Container(
                margin: EdgeInsets.only(top: 14),
                child: Text(
                  entity.name ?? "",
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
