import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dovemusic/config/net_api.dart';
import 'package:dovemusic/net/dv_http.dart';
import 'package:dovemusic/utils/encrypt/encrypt_utils.dart';
import 'package:dovemusic/utils/sp/sp_manager.dart';
import 'package:dovemusic/utils/toast/toast_util.dart';
import 'package:dovemusic/widget/input_widget.dart';

import '../../../generated/l10n.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 14:14
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class UpdatePsdDialog extends StatefulWidget {
  const UpdatePsdDialog({super.key});

  @override
  State<UpdatePsdDialog> createState() => _UpdatePsdDialogState();
}

class _UpdatePsdDialogState extends State<UpdatePsdDialog> {
  String? _psd;
  String? _newPsd;
  String? _surePsd;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.changePsd),
      titleTextStyle: const TextStyle(fontSize: 20),
      content: Wrap(
        children: [
          Column(
            children: [
              InputWidget(
                lable: S.current.enterOldPsd,
                icon: const Icon(Icons.password_outlined),
                minWidth: 300,
                maxWidth: 300,
                onChanged: (value) {
                  _psd = value;
                },
              ),
              const SizedBox(
                height: 14,
              ),
              InputWidget(
                lable: S.current.enterNewPsd,
                icon: const Icon(Icons.password_outlined),
                minWidth: 300,
                maxWidth: 300,
                onChanged: (value) {
                  _newPsd = value;
                },
              ),
              const SizedBox(
                height: 14,
              ),
              InputWidget(
                lable: S.current.enterSurePsd,
                icon: const Icon(Icons.password_outlined),
                minWidth: 300,
                maxWidth: 300,
                onChanged: (value) {
                  _surePsd = value;
                },
              ),
            ],
          )
        ],
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              elevation: MaterialStateProperty.all(0)),
          child: Text(S.current.cancel,
              style: const TextStyle(color: Colors.black)),
          onPressed: () {
            context.pop();
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor)),
          child:
              Text(S.current.sure, style: const TextStyle(color: Colors.white)),
          onPressed: () {
            if (_psd?.isEmpty ?? true) {
              ToastUtils.show(S.current.enterOldPsd);
              return;
            }
            if (_newPsd?.isEmpty ?? true) {
              ToastUtils.show(S.current.enterNewPsd);
              return;
            }
            if (_surePsd?.isEmpty ?? true) {
              ToastUtils.show(S.current.enterSurePsd);
              return;
            }
            if (_newPsd != _surePsd) {
              ToastUtils.show(S.current.surePsdErr);
              return;
            }
            if (_newPsd == _psd) {
              ToastUtils.show(S.current.psdConsistent);
              return;
            }
            _updatePsd();
          },
        ),
      ],
    );
  }

  //登录
  void _updatePsd() {
    DMHttp.instance.post<String>(NetApi.updatePsd, data: {
      "password": EncryptUtils.strToMd5(_psd!),
      "newPassword": EncryptUtils.strToMd5(_newPsd!)
    }, success: (data) {
      SPManager.instance
          .saveAccountPass(SPManager.instance.getAccount(), _newPsd!);
      ToastUtils.show(S.current.changeSuccess);
      context.pop();
    }, fail: (code, message) {
      ToastUtils.show("$code $message");
    });
  }
}
