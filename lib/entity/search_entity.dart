import 'package:larkmusic/entity/album_entity.dart';
import 'package:larkmusic/entity/singer_entity.dart';
import 'package:larkmusic/entity/song_list_entity.dart';

import 'music_entity.dart';

/// @Author: gstory
/// @CreateDate: 2024/1/3 16:03
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class SearchEntity {
  List<MusicEntity>? musicList;
  List<AlbumEntity>? albumList;
  List<SingerEntity>? singerList;
  List<SongListEntity>? songListList;

  SearchEntity(
      {required this.musicList,
      required this.albumList,
      required this.singerList,
      required this.songListList});

  SearchEntity.fromJson(Map<String, dynamic> json) {
    if (json['musics'] != null) {
      musicList = <MusicEntity>[];
      json['musics'].forEach((v) {
        musicList?.add(MusicEntity.fromJson(v));
      });
    }
    if (json['albums'] != null) {
      albumList = <AlbumEntity>[];
      json['albums'].forEach((v) {
        albumList?.add(AlbumEntity.fromJson(v));
      });
    }
    if (json['artists'] != null) {
      singerList = <SingerEntity>[];
      json['artists'].forEach((v) {
        singerList?.add(SingerEntity.fromJson(v));
      });
    }
    if (json['songLists'] != null) {
      songListList = <SongListEntity>[];
      json['songLists'].forEach((v) {
        songListList?.add(SongListEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (musicList != null) {
      data['musics'] = musicList!.map((v) => v.toJson()).toList();
    }
    if (musicList != null) {
      data['albums'] = albumList!.map((v) => v.toJson()).toList();
    }
    if (musicList != null) {
      data['artists'] = singerList!.map((v) => v.toJson()).toList();
    }
    if (musicList != null) {
      data['songLists'] = songListList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
