import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/pages/home/home_provider.dart';
import 'package:larkmusic/pages/singerlist/singer_list_page.dart';
import 'package:larkmusic/widget/ink_widget.dart';

import '../../../generated/l10n.dart';
import 'home_singer_item.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/30 14:20
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class HomeSinger extends ConsumerWidget {
  HomeSinger({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final singerList = ref.watch(homeProvider.select((value) => value.singerList));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
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
                    S.current.singer,
                    style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black),
                  )
                ],
              ),
              InkWidget(
                onTap: () {
                  SingerListPage.go(context);
                },
                child: Text("${S.current.more} >"),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.centerLeft,
            height: 110,
            child: ListView(
              shrinkWrap: true,
              //沿竖直方向上布局
              scrollDirection: Axis.horizontal,
              // padding: const EdgeInsets.symmetric(horizontal: 10),
              //每个子组件的宽度
              itemExtent: 100,
              children: singerList
                      ?.map((e) => HomeSingerItem(
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
