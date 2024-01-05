import 'dart:io';

import 'package:larkmusic/config/assets_image.dart';
import 'package:larkmusic/generated/l10n.dart';
import 'package:larkmusic/manager/audio_manager.dart';
import 'package:system_tray/system_tray.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 18:17
/// @Email gstory0404@gmail.com
/// @Description: 系统托盘管理类

class TrayManager {
  factory TrayManager() => _getInstance();

  static TrayManager get instance => _getInstance();
  static TrayManager? _instance;

  static TrayManager _getInstance() {
    _instance ??= TrayManager._internal();
    return _instance!;
  }

  TrayManager._internal() {
    _init();
  }

  final SystemTray _systemTray = SystemTray();
  final Menu _menu = Menu();
  final AppWindow _appWindow = AppWindow();

  void _init(){
    _initSystemTray();
  }

  //系统托盘
  Future<void> _initSystemTray() async {
    String _iconPath =
    Platform.isWindows ? AssetsImages.logo : AssetsImages.logo;
    await _systemTray.initSystemTray(
        title: "", iconPath: _iconPath, toolTip: S.current.appName);
    await _menu.buildFrom([
      MenuItemLabel(label: S.current.appName,onClicked: (menuItem){
        _appWindow.show();
      }),
      MenuSeparator(),
      MenuItemLabel(
          label: S.current.lastMusic,
          image: AssetsImages.icTrayPre,
          onClicked: (menuItem) {
            AudioManager.instance.previous();
          }),
      MenuItemLabel(
          label: S.current.pauseOrPlay,
          image: AssetsImages.icTrayPlay,
          onClicked: (menuItem) {
            AudioManager.instance.play();
          }),
      MenuItemLabel(
          label: S.current.nextMusic,
          image: AssetsImages.icTrayNext,
          onClicked: (menuItem) {
            AudioManager.instance.next();
          }),
      MenuSeparator(),
      MenuItemLabel(
          label: S.current.exit,
          image: AssetsImages.icTrayExit,
          onClicked: (menuItem) {
            exit(0);
          }),
    ]);
    await _systemTray.setContextMenu(_menu);
    _systemTray.registerSystemTrayEventHandler((eventName) {
      if (eventName == kSystemTrayEventClick) {
        //左键显示应用
        _appWindow.show();
      } else if (eventName == kSystemTrayEventRightClick) {
        //右键显示菜单
        _systemTray.popUpContextMenu();
      } else if (eventName == kSystemTrayEventDoubleClick) {

      }
    });
  }
}