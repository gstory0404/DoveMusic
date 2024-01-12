import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/net_api.dart';
import '../../entity/song_list_entity.dart';
import '../../net/lm_http.dart';
import '../../utils/toast/toast_util.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/19 14:44
/// @Email gstory0404@gmail.com
/// @Description: index Provider

class IndexModel {
  final String name;

  IndexModel({required this.name});

  IndexModel.initial() : name = "";

  IndexModel copyWith({
    String? name,
  }) {
    return IndexModel(
      name: name ?? this.name,
    );
  }
}

final indexProvider =
    StateNotifierProvider.autoDispose<IndexViewModel, IndexModel>((ref) {
  return IndexViewModel();
});

class IndexViewModel extends StateNotifier<IndexModel> {
  IndexViewModel() : super(IndexModel.initial()) {}
}
