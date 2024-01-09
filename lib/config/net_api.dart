import 'package:larkmusic/utils/sp/sp_manager.dart';

/// @Author: gstory
/// @CreateDate: 2023/5/25 15:17
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class NetApi{
  //登录
  static const String login = "/api/user/login";
  //修改密码
  static const String updatePsd = "/api/user/updatePsd";
  //随机获取歌曲
  static const String random = "/api/music/random";
  //最新入库
  static const String recently = "/api/music/recently";
  //歌曲搜索
  static const String search = "/api/music/search";
  //歌单列表
  static const String songList = "/api/songList/list";
  //我的歌单
  static const String ownSongList = "/api/songList/own";
  //创建歌单
  static const String create = "/api/songList/create";
  //歌单添加歌曲
  static const String songListAddMusic = "/api/songList/addMusic";
  //歌单详情
  static const String songListDetail = "/api/songList/detail";
  //删除歌单
  static const String songListDelete = "/api/songList/delete";
  //专辑列表
  static const String albumList = "/api/album/list";
  //专辑详情
  static const String albumDetail = "/api/album/detail";
  //歌手列表
  static const String singerList = "/api/artist/list";
  //歌手详情
  static const String singerDetail = "/api/artist/detail";
  //同步歌曲
  static const String syncMusic = "/api/admin/syncMusic";

  //播放地址
  static String playPath({required int id}){
    return "${SPManager.instance.getHost()}/play/$id";
  }
}
