import 'package:larkmusic/entity/music_entity.dart';

/// @Author: gstory
/// @CreateDate: 2023/6/16 17:10
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SingerEntity {
  int? id;
  String? name;
  String? picture;
  List<MusicEntity>? list;

  SingerEntity({this.id, this.name, this.picture, this.list});

  SingerEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];

    picture = json['picture'];
    if (json['list'] != null) {
      list = <MusicEntity>[];
      json['list'].forEach((v) {
        list!.add(MusicEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['picture'] = picture;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
