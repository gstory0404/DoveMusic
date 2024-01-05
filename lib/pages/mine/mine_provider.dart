import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/utils/sp/sp_manager.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 11:42
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MineState {
  final int userId;
  final String userName;
  final String userAccount;

  MineState({
    required this.userId,
    required this.userName,
    required this.userAccount,
  });

  MineState.initial()
      : userId = 0,
        userName = "",
        userAccount = "";

  MineState copyWith({
    int? userId,
    String? userName,
    String? userAccount,
  }) {
    return MineState(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAccount: userAccount ?? this.userAccount,
    );
  }
}

final mineProvider = StateNotifierProvider<MineViewModel, MineState>((ref) {
  return MineViewModel();
});

class MineViewModel extends StateNotifier<MineState> {
  MineViewModel() : super(MineState.initial()) {
    state = state.copyWith(
        userId: SPManager.instance.getUserInfo().userId,
        userName: SPManager.instance.getAccount(),
        userAccount: SPManager.instance.getAccount());
  }
}
