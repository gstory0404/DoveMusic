import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/config/assets_image.dart';
import 'package:larkmusic/pages/console/console_page.dart';
import 'package:larkmusic/pages/setting/setting_provider.dart';
import 'package:larkmusic/pages/setting/widget/setting_item.dart';
import 'package:larkmusic/pages/setting/widget/setting_language_dialog.dart';
import 'package:larkmusic/utils/sp/sp_manager.dart';
import 'package:larkmusic/widget/icon_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/l10n.dart';
import '../../../manager/locale_provider.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 16:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingContent extends StatelessWidget {
  SettingContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          //管理
          SPManager().getUserInfo().purview == 1
              ? Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      //控制台
                      SettingItem(
                        title: S.current.console,
                        content:
                            IconWidget(icon: Icons.chevron_right, size: 16),
                        onTap: () {
                          ConsolePage.go(context);
                        },
                      ),
                    ],
                  ),
                )
              : Container(),
          //app设置
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                SettingItem(
                  title: S.current.theme,
                  content: IconWidget(icon: Icons.chevron_right, size: 16),
                  onTap: () {},
                ),
                Container(
                  color: Colors.grey,
                  height: 0.5,
                  width: MediaQuery.of(context).size.width,
                ),
                SettingItem(
                  title: S.current.playbackSetting,
                  content: IconWidget(icon: Icons.chevron_right, size: 16),
                  onTap: () {},
                ),
                Container(
                  color: Colors.grey,
                  height: 0.5,
                  width: MediaQuery.of(context).size.width,
                ),
                Consumer(builder: (context, ref, _) {
                  var locale =
                      ref.watch(localeProvider.select((value) => value));
                  return SettingItem(
                    title: S.current.language,
                    content: Text(LocaleUtil.getLocaleName(locale)),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SettingLanguageDialog();
                          });
                    },
                  );
                }),
              ],
            ),
          ),
          // 项目
          Container(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                //app版本
                Consumer(builder: (context, ref, _) {
                  return SettingItem(
                    title: S.current.appVersion,
                    content: Text(
                        "v${ref.watch(settingProvider.select((value) => value.appVersion))}"),
                    onTap: () async {
                      await launchUrl(Uri.parse("https://github.com/gstory0404/LarkMusic/releases"));
                    },
                  );
                }),
                Container(
                  color: Colors.grey,
                  height: 0.5,
                  width: MediaQuery.of(context).size.width,
                ),
                //项目主页
                SettingItem(
                  title: S.current.appHome,
                  content: const Text("https://github.com/gstory0404/LarkMusic"),
                  onTap: ()  async {
                    await launchUrl(Uri.parse("https://github.com/gstory0404/LarkMusic"));
                  },
                ),
                Container(
                  color: Colors.grey,
                  height: 0.5,
                  width: MediaQuery.of(context).size.width,
                ),
                //开源协议
                Consumer(builder: (context, ref, _) {
                  return SettingItem(
                    title: S.current.protocol,
                    content: IconWidget(icon: Icons.chevron_right, size: 16),
                    onTap: () {
                      showLicensePage(
                        context: context,
                        applicationIcon: Image.asset(
                          AssetsImages.logo,
                          height: 100,
                          width: 100,
                        ),
                        applicationName: S.current.appName,
                        applicationVersion:  "v${ref.watch(settingProvider.select((value) => value.appVersion))}",
                        applicationLegalese: S.current.appDesc,
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
