import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/generated/l10n.dart';
import 'package:larkmusic/pages/home/home_page.dart';
import 'package:larkmusic/pages/login/login_provider.dart';
import 'package:larkmusic/utils/toast/toast_util.dart';
import 'package:larkmusic/widget/background_widget.dart';
import 'package:larkmusic/widget/ink_widget.dart';
import 'package:larkmusic/widget/input_widget.dart';

import '../../../config/assets_image.dart';
import '../../../utils/sp/sp_manager.dart';
import '../../index/index_page.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/24 15:11
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述 \

class LoginPhonePage extends ConsumerStatefulWidget {
  LoginPhonePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return LoginPhonePageState();
  }
}

class LoginPhonePageState extends ConsumerState<LoginPhonePage> {
  @override
  void initState() {
    super.initState();
    if (SPManager.instance.getUserInfo().token?.isNotEmpty ?? false) {
      IndexPage.go(context);
    }
    WidgetsBinding.instance.addPostFrameCallback((mag) {
      ref.watch(loginProvider.notifier).readCacheData();
      ref.read(loginProvider.notifier).addListener((state) {
        if (state.loginEntity != null && state.loginEntity?.userId != 0) {
          ToastUtils.show(S.current.loginSuccess);
          HomePage.go(context);
        } else if (state.errMsg != null) {
          ToastUtils.show("${state.errMsg}");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(loginProvider);
    return Scaffold(
      body: Stack(
        children: [
          BackGroundWidget(
            child: Container(
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
                    style: const TextStyle(fontSize: 26),
                  ),
                  const SizedBox(height: 100),
                  InputWidget(
                    lable: S.current.serviceUrl,
                    text: model.url,
                    icon: const Icon(Icons.network_check),
                    minWidth: 360,
                    maxWidth: 360,
                    onChanged: (data) {
                      ref.read(loginProvider.notifier).setHost(data);
                    },
                  ),
                  const SizedBox(height: 20),
                  InputWidget(
                    lable: S.current.account,
                    text: model.account,
                    icon: const Icon(Icons.people),
                    minWidth: 360,
                    maxWidth: 360,
                    onChanged: (data) {
                      ref.read(loginProvider.notifier).setAccount(data);
                    },
                  ),
                  const SizedBox(height: 20),
                  InputWidget(
                    lable: S.current.password,
                    text: model.password,
                    icon: const Icon(Icons.verified_user),
                    minWidth: 360,
                    maxWidth: 360,
                    onChanged: (data) {
                      ref.read(loginProvider.notifier).setPassword(data);
                    },
                  ),
                  const SizedBox(height: 60),
                  InkWidget(
                    //在最外层包裹InkWell组件
                    onTap: () async {
                      if (model.url.isEmpty) {
                        ToastUtils.show(S.current.serviceUrlNotEmpty);
                        return;
                      }
                      if (model.account.isEmpty) {
                        ToastUtils.show(S.current.accountNotEmpty);
                        return;
                      }
                      if (model.password.isEmpty) {
                        ToastUtils.show(S.current.passwordNotEmpty);
                        return;
                      }
                      ref.read(loginProvider.notifier).login();
                    },
                    radius: 30.0,
                    child: Container(
                      width: 300,
                      height: 50,
                      child: Center(
                        child: Text(S.current.login,
                            style: const TextStyle(fontSize: 14)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
