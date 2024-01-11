import 'package:flutter/material.dart';
import 'package:larkmusic/config/assets_image.dart';
import 'package:larkmusic/widget/ink_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/12/26 14:22
/// @Email gstory0404@gmail.com
/// @Description: 状态widget

// class StatusType {
//   static const int LOADING = 1; //加载中
//   static const int EMPTY = 2; //无数据
//   static const int ERROR = 3; //错误
//   static const int MAIN = 4; //显示内容
// }

enum StatusType {
  LOADING,
  EMPTY,
  ERROR,
  MAIN,
}

class StatusWidget extends StatelessWidget {
  StatusType status = StatusType.MAIN;
  Widget child;
  VoidCallback? replay;

  StatusWidget({
    super.key,
    required this.status,
    required this.child,
    this.replay,
  });

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case StatusType.LOADING:
        return _loadingWidget(context);
      case StatusType.EMPTY:
        return _emptyWidget();
      case StatusType.ERROR:
        return _errorWidget();
      default:
        return Container(
          child: child,
        );
    }
  }

  _loadingWidget(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fourRotatingDots(
        color: Theme.of(context).primaryColor,
        size: 50,
      ),
    );
  }

  _emptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsImages.icEmpty,
            width: 150,
            height: 150,
          ),
          Text(
            S.current.emptyTips,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          )
        ],
      ),
    );
  }

  _errorWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AssetsImages.icError,
            width: 150,
            height: 150,
          ),
          Text(
            S.current.errorTips,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          const SizedBox(height: 10),
          InkWidget(onTap: replay, child: Text(S.current.retry))
        ],
      ),
    );
  }
}
