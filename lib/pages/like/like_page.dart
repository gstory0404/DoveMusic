import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/routes/app_pages.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/17 11:22
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class LikePage extends StatefulWidget {

  const LikePage({Key? key}) : super(key: key);

  @override
  State<LikePage> createState() => _LikePageState();

  static void go(BuildContext context){
    context.pushNamed(RouterPage.like);
  }
}

class _LikePageState extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("喜欢"),
    );
  }
}
