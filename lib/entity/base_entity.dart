import 'package:larkmusic/entity/album_entity.dart';
import 'package:larkmusic/entity/login_entity.dart';
import 'package:larkmusic/entity/search_entity.dart';
import 'package:larkmusic/entity/singer_entity.dart';
import 'package:larkmusic/entity/song_list_entity.dart';

import '../../entity/music_entity.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/23 15:51
/// @Email gstory0404@gmail.com
/// @Description: 数据基类

class BaseEntity<T> {
  int? code;
  String? message;
  T? data;

  BaseEntity({required this.code, this.message, this.data});

  BaseEntity.fromJson(dynamic json) {
    code = json["code"];
    message = json["msg"];
    if (code == 1) {
      data = _fromJsonAsT(json["data"]);
    }
  }

  //泛型解析
  T? _fromJsonAsT(dynamic data) {
    // if(T is LoginEntity){
    //   return LoginEntity.fromJson(data) as T?;
    // }else if(T is List<MusicEntity>){
    //   return List.from(data as List)
    //       .map((x) => MusicEntity.fromJson(x))
    //       .toList()
    //       .cast<MusicEntity>() as T?;
    // }else if(T is List<SongListEntity>){
    //   return List.from(data as List)
    //       .map((x) => SongListEntity.fromJson(x))
    //       .toList()
    //       .cast<SongListEntity>() as T?;
    // }else if(T is SongListEntity){
    //   return SongListEntity.fromJson(data) as T?;
    // }else if(T is List<AlbumEntity>){
    //   return SongListEntity.fromJson(data) as T?;
    // }else if(T is AlbumEntity){
    //   return AlbumEntity.fromJson(data) as T?;
    // }else if(T is List<SingerEntity>){
    //   return List.from(data as List)
    //       .map((x) => SingerEntity.fromJson(x))
    //       .toList()
    //       .cast<SingerEntity>() as T?;
    // }else if(T is SingerEntity){
    //   return SingerEntity.fromJson(data) as T?;
    // }else if(T is SearchEntity){
    //   return SearchEntity.fromJson(data) as T?;
    // }else{
    //   return data as T?;
    // }
    switch (T) {
      //登录
      case LoginEntity:
        return LoginEntity.fromJson(data) as T?;
      //歌曲列表
      case const (List<MusicEntity>):
        return List.from(data as List)
            .map((x) => MusicEntity.fromJson(x))
            .toList()
            .cast<MusicEntity>() as T?;
      //歌单列表
      case const (List<SongListEntity>):
        return List.from(data as List)
            .map((x) => SongListEntity.fromJson(x))
            .toList()
            .cast<SongListEntity>() as T?;
      //歌单详情
      case SongListEntity:
        return SongListEntity.fromJson(data) as T?;
      //专辑列表
      case const (List<AlbumEntity>):
        return List.from(data as List)
            .map((x) => AlbumEntity.fromJson(x))
            .toList()
            .cast<AlbumEntity>() as T?;
      //专辑详情
      case AlbumEntity:
        return AlbumEntity.fromJson(data) as T?;
      //歌手列表
      case const (List<SingerEntity>):
        return List.from(data as List)
            .map((x) => SingerEntity.fromJson(x))
            .toList()
            .cast<SingerEntity>() as T?;
      //歌手详情
      case SingerEntity:
        return SingerEntity.fromJson(data) as T?;
      //搜索
      case SearchEntity:
        return SearchEntity.fromJson(data) as T?;
      default:
        return data as T?;
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = code;
    map["message"] = message;
    map["data"] = data;
    return map;
  }
}
