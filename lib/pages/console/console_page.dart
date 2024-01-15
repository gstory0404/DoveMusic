import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/pages/base/base_page.dart';
import 'package:dovemusic/pages/console/widget/console_content.dart';

import '../../generated/l10n.dart';
import '../../routes/app_pages.dart';
import '../../widget/background_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/22 11:19
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class ConsolePage extends BasePage{

  static void go(BuildContext context) {
    context.pushNamed(RouterPage.console);
  }

  @override
  Widget desktop() {
    return Scaffold(
      body: ConsoleContent(),
    );
  }

  @override
  Widget phone() {
    return BackGroundWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.console),
        ),
        body: ConsoleContent(),
      ),
    );
  }
}