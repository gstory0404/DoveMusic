import 'package:flutter/material.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/26 10:39
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

ThemeData themeMain = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    //主要颜色
    primarySwatch: Colors.green,
    //次要颜色
    accentColor: Colors.green[200],
    //背景颜色
    backgroundColor: Colors.white,
  ),
  brightness: Brightness.light,
  //使用Material3
  useMaterial3: true,
  //悬停颜色
  hoverColor: Colors.green[50],
  //部件获取焦点的颜色。
  focusColor: Colors.green[50],
  //部件被轻触时的颜色。
  splashColor: Colors.green[100],
  //部件被按下时的颜色。
  highlightColor: Colors.green[100],
  //部件不可用时的颜色。
  disabledColor: Colors.grey,
  //提示文字颜色
  hintColor: Colors.grey,
  //分割线主题
  dividerTheme: DividerThemeData(
    color: Colors.grey[200],
    space: 0.5,
  ),
  //Dialog主题
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(color: Colors.black),
    contentTextStyle: TextStyle(color: Colors.black),
    backgroundColor: Colors.white, //背景颜色
    shadowColor: Colors.white, //
    elevation: 0, //
  ),
  //Text主题
  textTheme: const TextTheme(titleMedium: TextStyle(color: Colors.black)),
  //card主题
  cardTheme: const CardTheme(
      color: Colors.white70, //卡片颜色
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)))),
  //TabBar主题
  tabBarTheme: const TabBarTheme(indicatorColor: Colors.white),
  //底部AppBar主题
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.white,
    shadowColor: Colors.white10,
    surfaceTintColor: Colors.black12,
    elevation: 2,
  ),
  //popupMenu主题
  popupMenuTheme: const PopupMenuThemeData(
    color: Colors.white,
    shadowColor: Colors.white10
  )
);
