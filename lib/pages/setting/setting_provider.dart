import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/13 15:43
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SettingState {
  final String appVersion;

  SettingState({
    required this.appVersion,
  });

  SettingState.initial() : appVersion = "";

  SettingState copyWith({
    String? appVersion,
  }) {
    return SettingState(
      appVersion: appVersion ?? this.appVersion,
    );
  }
}

final settingProvider =
    StateNotifierProvider.autoDispose<SettingViewModel, SettingState>((ref) {
  return SettingViewModel();
});

class SettingViewModel extends StateNotifier<SettingState> {
  SettingViewModel() : super(SettingState.initial()) {
    init();
  }

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    state = state.copyWith(appVersion: packageInfo.version);
  }
}
