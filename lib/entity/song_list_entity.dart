import 'package:larkmusic/entity/music_entity.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/29 16:01
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SongListEntity {
  int? id;
  String? name;
  String? userName;
  String? desc;
  int? userId;
  String? picture;
  List<MusicEntity>? list;

  SongListEntity({this.id, this.name, this.userName, this.desc,this.userId,this.picture, this.list});

  SongListEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    picture = json['picture'];
    userName = json['user_name'];
    userId = json['user_id'];
    if (json['list'] != null) {
      list = <MusicEntity>[];
      json['list'].forEach((v) {
        list!.add(MusicEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['picture'] = this.picture;
    data['user_name'] = this.userName;
    data['user_id'] = this.userId;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}