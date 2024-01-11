import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:larkmusic/pages/console/console_provider.dart';
import 'package:larkmusic/widget/ink_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/12/28 14:28
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SyncDialog extends StatelessWidget {
  SyncDialog({super.key});

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.syncMusic),
      titleTextStyle: const TextStyle(fontSize: 20, color: Colors.black),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Container(
          width: kIsWeb ||
                  Platform.isFuchsia ||
                  Platform.isWindows ||
                  Platform.isMacOS ||
                  Platform.isLinux
              ? MediaQuery.of(context).size.width / 3
              : MediaQuery.of(context).size.width / 2,
          height: kIsWeb ||
                  Platform.isFuchsia ||
                  Platform.isWindows ||
                  Platform.isMacOS ||
                  Platform.isLinux
              ? MediaQuery.of(context).size.width / 3
              : MediaQuery.of(context).size.width / 2,
          child: Consumer(
            builder: (context, ref, _) {
              final syncLogs =
                  ref.watch(consoleProvider.select((value) => value.syncLogs));
              ref.listen(consoleProvider, (previous, next) {
                if (scrollController.hasClients) {
                  scrollController
                      .jumpTo(scrollController.position.maxScrollExtent);
                }
              });
              return ListView.builder(
                controller: scrollController,
                itemCount: syncLogs.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    child: Text(
                      syncLogs[index],
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                    ),
                  );
                },
              );
            },
          )),
      actions: <Widget>[
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor)),
          child:
              Text(S.current.sure, style: const TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
