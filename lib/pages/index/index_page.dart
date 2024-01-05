import 'package:flutter/material.dart';
import 'package:larkmusic/pages/base/base_page.dart';
import 'package:larkmusic/pages/index/phone/index_mobile_page.dart';

import 'desktop/index_desktop_page.dart';

/// @Author: gstory
/// @CreateDate: 2023/4/26 18:03
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class IndexPage extends BasePage {

  Widget? child;

  IndexPage({super.key, this.child});


  @override
  Widget desktop() {
    return IndexDesktopPage(child: child,);
  }

  @override
  Widget phone() {
    return const IndexMobilePage();
  }
}
