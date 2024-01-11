import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/manager/locale_provider.dart';
import 'package:larkmusic/utils/sp/sp_manager.dart';
import 'package:larkmusic/widget/ink_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/15 12:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingLanguageDialog extends ConsumerWidget {
  SettingLanguageDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SimpleDialog(
      title: Text(
        S.of(context).language,
        style: const TextStyle(fontSize: 20, color: Colors.black),
      ),
      titleTextStyle: const TextStyle(fontSize: 20),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      children: _getLocaleItem(),
    );
  }

  List<Widget> _getLocaleItem() {
    var items = <Widget>[];
    for (int i = 0; i < S.delegate.supportedLocales.length; i++) {
      items.add(
        Consumer(
          builder: (context, ref, _) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
              child: InkWidget(
                radius: 4,
                onTap: () {
                  SPManager.instance.saveLocale(i);
                  S.load(S.delegate.supportedLocales[i]);
                  ref.watch(localeProvider.notifier).state = i;
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocaleUtil.getLocaleName(i)),
                      ref.read(localeProvider.select((value) => value)) == i
                          ? const Icon(Icons.check, size: 16)
                          : Container()
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    return items;
  }
}
