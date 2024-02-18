import 'package:dovemusic/utils/log/log_util.dart';
import 'package:flutter/material.dart';
import 'package:dovemusic/config/assets_image.dart';
import 'package:dovemusic/generated/l10n.dart';
import 'package:dovemusic/pages/index/index_page.dart';
import 'package:dovemusic/pages/login/login_page.dart';
import 'package:dovemusic/utils/sp/sp_manager.dart';
import 'package:dovemusic/widget/background_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../manager/audio_manager.dart';
import '../../net/dv_http.dart';

/// @Author: gstory
/// @CreateDate: 2024/1/11 14:24
/// @Email gstory0404@gmail.com
/// @Description: 启动页

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    initCache();
  }

  Future<void> initCache() async {
    await SPManager.instance.init();
    //初始化
    DMHttp.instance.init(baseUrl: SPManager.instance.getHost());
    AudioManager.instance;
    if (SPManager.instance.isLogin()) {
      IndexPage.go(context);
    } else {
      LoginPage.go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsImages.logo,
                width: 60,
                height: 60,
              ),
              const SizedBox(height: 10),
              Text(
                S.current.appName,
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 100),
              LoadingAnimationWidget.fourRotatingDots(
                color: Theme.of(context).primaryColor,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
