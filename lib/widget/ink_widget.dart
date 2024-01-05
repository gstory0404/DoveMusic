import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 18:16
/// @Email gstory0404@gmail.com
/// @Description: 带点击的widget

class InkWidget extends StatelessWidget {
  Widget child;
  GestureTapCallback? onTap;
  Function(Offset offset)? onLongPress;
  ValueChanged<bool>? onHover;
  Color? color;
  bool isCheck;
  double radius;

  InkWidget(
      {super.key,
      required this.child,
      this.onTap,
      this.onLongPress,
      this.onHover,
      this.color,
      this.radius = 10.0,
      this.isCheck = false});

  Offset offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        color: Colors.transparent,
        //设置背景
        child: InkResponse(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          //点击或者toch控件高亮时显示的控件在控件上层,水波纹下层
          hoverColor:  Colors.black12,
          //点击或者toch控件高亮的shape形状
          highlightShape: BoxShape.rectangle,
          // splashColor: Theme.of(context).colorScheme.surface,
          //true表示要剪裁水波纹响应的界面   false不剪裁  如果控件是圆角不剪裁的话水波纹是矩形
          containedInkWell: true,
          onTap: onTap,
          onHover: onHover,
          onLongPress: (){
            if(onLongPress != null){
              onLongPress!(offset);
            }
          },
          onSecondaryTapDown: (details){
            if(onLongPress != null){
              onLongPress!(details.globalPosition);
            }
          },
          onTapDown: (details){
            offset = details.globalPosition;
          },
          child: child,
        ),
      ),
    );
  }
}
