import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../../console/console_page.dart';

/// @Author: gstory
/// @CreateDate: 2024/1/11 18:23
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class GoSyncDialog extends StatelessWidget {

  GoSyncDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.tips),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      content: Text(S.current.goSync),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0)),
          child: Text(S.current.cancel,
              style: const TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                  Theme
                      .of(context)
                      .primaryColor)),
          child: Text(S.current.sure,
              style: const TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.of(context).pop();
            ConsolePage.go(context);
          },
        ),
      ],
    );
  }
}