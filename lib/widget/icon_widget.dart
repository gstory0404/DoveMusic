import 'package:flutter/material.dart';
import 'package:larkmusic/widget/ink_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/3 16:04
/// @Email gstory0404@gmail.com
/// @Description: 图标按钮

class IconWidget extends StatelessWidget {
  IconData icon;
  IconData? selectedIcon;
  Color? iconColor;
  Color? selectedColor;
  bool isSelect;
  double? size;
  VoidCallback? onPress;

  IconWidget(
      {super.key,
      required this.icon,
      this.selectedIcon,
      this.iconColor,
      this.selectedColor,
      required this.size,
      this.isSelect = false,
      this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWidget(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.all(6),
        color: Colors.transparent,
        child: isSelect
            ? Icon(
                selectedIcon,
                size: size,
                color: selectedColor,
              )
            : Icon(
                icon,
                size: size,
                color: iconColor,
              ),
      ),
    );
  }
}
