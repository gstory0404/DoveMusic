/// @Author: gstory
/// @CreateDate: 2023/5/25 17:19
/// @Email gstory0404@gmail.com
/// @Description: dart类作用描述

class MusicEntity {
  int? id;
  String? name;
  String? year;
  int? artistId;
  String? artistName;
  int? albumId;
  String? albumName;
  int? genreId;
  String? genreName;
  String? picture;
  String? lyrics;
  String? path;
  int? size;

  MusicEntity(
      {this.id,
        this.name,
        this.year,
        this.artistId,
        this.artistName,
        this.albumId,
        this.albumName,
        this.genreId,
        this.genreName,
        this.picture,
        this.lyrics,
        this.path,
        this.size});

  MusicEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    artistId = json['artist_id'];
    artistName = json['artist_name'];
    albumId = json['album_id'];
    albumName = json['album_name'];
    genreId = json['genre_id'];
    genreName = json['genre_name'];
    picture = json['picture'];
    lyrics = json['lyrics'];
    path = json['path'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['year'] = year;
    data['artist_id'] = artistId;
    data['artist_name'] = artistName;
    data['album_id'] = albumId;
    data['album_name'] = albumName;
    data['genre_id'] = genreId;
    data['genre_name'] = genreName;
    data['picture'] = picture;
    data['lyrics'] = lyrics;
    data['path'] = path;
    data['size'] = size;
    return data;
  }
}