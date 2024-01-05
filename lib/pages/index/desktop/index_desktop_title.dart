import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/config/assets_image.dart';
import 'package:larkmusic/pages/mine/mine_page.dart';
import 'package:larkmusic/pages/search/search_page.dart';
import 'package:larkmusic/pages/setting/setting_page.dart';
import 'package:larkmusic/widget/icon_widget.dart';
import 'package:larkmusic/widget/ink_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/26 16:12
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexDesktopTitle extends StatelessWidget {
  const IndexDesktopTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          IconWidget(
            icon: Icons.arrow_back_ios_new_outlined,
            iconColor: Colors.white,
            size: 20,
            onPress: () {
              if (context.canPop()) context.pop();
            },
          ),
          const SizedBox(width: 20),
          InkWidget(
            onTap: (){
              SearchPage.go(context);
            },
            radius: 20,
            child: Container(
              alignment: Alignment.center,
              height: 26,
              width: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.search_outlined,
                    color: Colors.black,
                    size: 18,
                  ),
                  Text(
                    S.current.searchMusic,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          //头像
          InkWell(
            onTap: () {
              MinePage.go(context);
            },
            child: FadeInImage(
              width: 30,
              height: 30,
              fit: BoxFit.fitWidth,
              image: Image.memory(const Base64Decoder().convert("")).image,
              placeholderFit: BoxFit.fill,
              placeholder: const AssetImage(
                AssetsImages.logoPlaceholder,
              ),
              imageErrorBuilder: (context, error, stack) {
                return Image.asset(
                  AssetsImages.iconUser,
                  width: 30,
                  height: 30,
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              SettingPage.go(context);
            },
            icon: Icon(
              Icons.settings_outlined,
              color: Theme.of(context).colorScheme.surface,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
