import 'package:larkmusic/entity/music_entity.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/29 17:13
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class AlbumEntity {
  int? id;
  String? name;
  String? artist;
  String? picture;
  List<MusicEntity>? list;

  AlbumEntity({this.id, this.name, this.artist, this.picture, this.list});

  AlbumEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    artist = json['artist'];
    picture = json['picture'];
    if (json['list'] != null) {
      list = <MusicEntity>[];
      json['list'].forEach((v) {
        list!.add(new MusicEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['artist'] = this.artist;
    data['picture'] = this.picture;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}