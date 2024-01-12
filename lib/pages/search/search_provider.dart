import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:larkmusic/config/net_api.dart';
import 'package:larkmusic/entity/music_entity.dart';
import 'package:larkmusic/entity/search_entity.dart';
import 'package:larkmusic/utils/log/log_util.dart';

import '../../config/app_config.dart';
import '../../net/lm_http.dart';
import '../../utils/toast/toast_util.dart';
import '../../widget/status_widget.dart';

/// @Author: gstory
/// @CreateDate: 2023/11/10 17:30
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchState {
  SearchEntity? searchEntity;
  StatusType status;
  late EasyRefreshController controller = EasyRefreshController(
      controlFinishRefresh: true, controlFinishLoad: false);

  SearchState({required this.searchEntity, required this.status});

  SearchState.initial()
      : searchEntity = null,
        status = StatusType.MAIN;

  SearchState copyWith({
    SearchEntity? searchEntity,
    StatusType? status,
  }) {
    return SearchState(
      searchEntity: searchEntity ?? this.searchEntity,
      status: status ?? this.status,
    );
  }
}

final searchProvider =
    StateNotifierProvider<SearchViewModel, SearchState>((ref) {
  return SearchViewModel();
});

class SearchViewModel extends StateNotifier<SearchState> {
  int page = 1;

  SearchViewModel() : super(SearchState.initial()){
    // getSearchList("");
  }

  //最新入库
  void getSearchList(String key) {
    state = state.copyWith(status: StatusType.LOADING);
    LMHttp.instance.post<SearchEntity>(NetApi.search,
        data: {"key": key, "page": page, "size": AppConfig.maxSize},
        success: (data) {
      state.controller.finishRefresh(IndicatorResult.success);
      state = state.copyWith(searchEntity: data, status: StatusType.MAIN);
    }, fail: (code, message) {
      state.controller.finishRefresh(IndicatorResult.fail);
      state = state.copyWith(status: StatusType.ERROR);
      ToastUtils.show("$code $message");
      LogUtil.d("search fail --> $code $message");
    });
  }
}
