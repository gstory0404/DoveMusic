import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/home/widget/home_music_item.dart';
import 'package:larkmusic/pages/home/home_provider.dart';
import 'package:larkmusic/pages/recently/recently_page.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/25 18:43
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class HomeRecently extends ConsumerWidget {
  HomeRecently({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestMusicList = ref.watch(homeProvider.select((value) => value.latestMusicList));
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    width: 4,
                    height: 20,
                    margin:
                    const EdgeInsets.only(right: 10),
                  ),
                  Text(
                    S.current.recent,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black),
                  )
                ],
              ),
              InkWell(
                child: Text("${S.current.more} >"),
                onTap: (){
                  RecentlyPage.go(context);
                },
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: 100,
            child: ListView(
              shrinkWrap: true,
              //沿竖直方向上布局
              scrollDirection: Axis.horizontal,
              //每个子组件的宽度
              itemExtent: 80,
              children: latestMusicList
                      ?.map((e) => HomeMusicItem(
                            entity: e,
                          ))
                      .toList() ??
                  [],
            ),
          )
        ],
      ),
    );
  }
}
