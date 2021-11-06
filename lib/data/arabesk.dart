class Arabesk {
  int? id;
  String? title;
  String? description;
  int? duration;
  bool? public;
  bool? isLovedTrack;
  bool? collaborative;
  int? nbTracks;
  int? fans;
  String? link;
  String? share;
  String? picture;
  String? pictureSmall;
  String? pictureMedium;
  String? pictureBig;
  String? pictureXl;
  String? checksum;
  String? tracklist;
  String? creationDate;
  String? md5Image;
  String? pictureType;
  Creator? creator;
  String? type;
  Tracks? tracks;

  Arabesk(
      {this.id,
      this.title,
      this.description,
      this.duration,
      this.public,
      this.isLovedTrack,
      this.collaborative,
      this.nbTracks,
      this.fans,
      this.link,
      this.share,
      this.picture,
      this.pictureSmall,
      this.pictureMedium,
      this.pictureBig,
      this.pictureXl,
      this.checksum,
      this.tracklist,
      this.creationDate,
      this.md5Image,
      this.pictureType,
      this.creator,
      this.type,
      this.tracks});

  Arabesk.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["title"] is String) this.title = json["title"];
    if (json["description"] is String) this.description = json["description"];
    if (json["duration"] is int) this.duration = json["duration"];
    if (json["public"] is bool) this.public = json["public"];
    if (json["is_loved_track"] is bool)
      this.isLovedTrack = json["is_loved_track"];
    if (json["collaborative"] is bool)
      this.collaborative = json["collaborative"];
    if (json["nb_tracks"] is int) this.nbTracks = json["nb_tracks"];
    if (json["fans"] is int) this.fans = json["fans"];
    if (json["link"] is String) this.link = json["link"];
    if (json["share"] is String) this.share = json["share"];
    if (json["picture"] is String) this.picture = json["picture"];
    if (json["picture_small"] is String)
      this.pictureSmall = json["picture_small"];
    if (json["picture_medium"] is String)
      this.pictureMedium = json["picture_medium"];
    if (json["picture_big"] is String) this.pictureBig = json["picture_big"];
    if (json["picture_xl"] is String) this.pictureXl = json["picture_xl"];
    if (json["checksum"] is String) this.checksum = json["checksum"];
    if (json["tracklist"] is String) this.tracklist = json["tracklist"];
    if (json["creation_date"] is String)
      this.creationDate = json["creation_date"];
    if (json["md5_image"] is String) this.md5Image = json["md5_image"];
    if (json["picture_type"] is String) this.pictureType = json["picture_type"];
    if (json["creator"] is Map)
      this.creator =
          json["creator"] == null ? null : Creator.fromJson(json["creator"]);
    if (json["type"] is String) this.type = json["type"];
    if (json["tracks"] is Map)
      this.tracks =
          json["tracks"] == null ? null : Tracks.fromJson(json["tracks"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["title"] = this.title;
    data["description"] = this.description;
    data["duration"] = this.duration;
    data["public"] = this.public;
    data["is_loved_track"] = this.isLovedTrack;
    data["collaborative"] = this.collaborative;
    data["nb_tracks"] = this.nbTracks;
    data["fans"] = this.fans;
    data["link"] = this.link;
    data["share"] = this.share;
    data["picture"] = this.picture;
    data["picture_small"] = this.pictureSmall;
    data["picture_medium"] = this.pictureMedium;
    data["picture_big"] = this.pictureBig;
    data["picture_xl"] = this.pictureXl;
    data["checksum"] = this.checksum;
    data["tracklist"] = this.tracklist;
    data["creation_date"] = this.creationDate;
    data["md5_image"] = this.md5Image;
    data["picture_type"] = this.pictureType;
    if (this.creator != null) data["creator"] = this.creator!.toJson();
    data["type"] = this.type;
    if (this.tracks != null) data["tracks"] = this.tracks!.toJson();
    return data;
  }
}

class Tracks {
  List<Data>? data;

  Tracks({this.data});

  Tracks.fromJson(Map<String, dynamic> json) {
    if (json["data"] is List)
      this.data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null)
      data["data"] = this.data!.map((e) => e.toJson()).toList();
    return data;
  }
}

class Data {
  int? id;
  bool? readable;
  String? title;
  String? titleShort;
  String? titleVersion;
  String? link;
  int? duration;
  int? rank;
  bool? explicitLyrics;
  int? explicitContentLyrics;
  int? explicitContentCover;
  String? preview;
  String? md5Image;
  int? timeAdd;
  Artist? artist;
  Album? album;
  String? type;

  Data(
      {this.id,
      this.readable,
      this.title,
      this.titleShort,
      this.titleVersion,
      this.link,
      this.duration,
      this.rank,
      this.explicitLyrics,
      this.explicitContentLyrics,
      this.explicitContentCover,
      this.preview,
      this.md5Image,
      this.timeAdd,
      this.artist,
      this.album,
      this.type});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["readable"] is bool) this.readable = json["readable"];
    if (json["title"] is String) this.title = json["title"];
    if (json["title_short"] is String) this.titleShort = json["title_short"];
    if (json["title_version"] is String)
      this.titleVersion = json["title_version"];
    if (json["link"] is String) this.link = json["link"];
    if (json["duration"] is int) this.duration = json["duration"];
    if (json["rank"] is int) this.rank = json["rank"];
    if (json["explicit_lyrics"] is bool)
      this.explicitLyrics = json["explicit_lyrics"];
    if (json["explicit_content_lyrics"] is int)
      this.explicitContentLyrics = json["explicit_content_lyrics"];
    if (json["explicit_content_cover"] is int)
      this.explicitContentCover = json["explicit_content_cover"];
    if (json["preview"] is String) this.preview = json["preview"];
    if (json["md5_image"] is String) this.md5Image = json["md5_image"];
    if (json["time_add"] is int) this.timeAdd = json["time_add"];
    if (json["artist"] is Map)
      this.artist =
          json["artist"] == null ? null : Artist.fromJson(json["artist"]);
    if (json["album"] is Map)
      this.album = json["album"] == null ? null : Album.fromJson(json["album"]);
    if (json["type"] is String) this.type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["readable"] = this.readable;
    data["title"] = this.title;
    data["title_short"] = this.titleShort;
    data["title_version"] = this.titleVersion;
    data["link"] = this.link;
    data["duration"] = this.duration;
    data["rank"] = this.rank;
    data["explicit_lyrics"] = this.explicitLyrics;
    data["explicit_content_lyrics"] = this.explicitContentLyrics;
    data["explicit_content_cover"] = this.explicitContentCover;
    data["preview"] = this.preview;
    data["md5_image"] = this.md5Image;
    data["time_add"] = this.timeAdd;
    if (this.artist != null) data["artist"] = this.artist!.toJson();
    if (this.album != null) data["album"] = this.album!.toJson();
    data["type"] = this.type;
    return data;
  }
}

class Album {
  int? id;
  String? title;
  String? cover;
  String? coverSmall;
  String? coverMedium;
  String? coverBig;
  String? coverXl;
  String? md5Image;
  String? tracklist;
  String? type;

  Album(
      {this.id,
      this.title,
      this.cover,
      this.coverSmall,
      this.coverMedium,
      this.coverBig,
      this.coverXl,
      this.md5Image,
      this.tracklist,
      this.type});

  Album.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["title"] is String) this.title = json["title"];
    if (json["cover"] is String) this.cover = json["cover"];
    if (json["cover_small"] is String) this.coverSmall = json["cover_small"];
    if (json["cover_medium"] is String) this.coverMedium = json["cover_medium"];
    if (json["cover_big"] is String) this.coverBig = json["cover_big"];
    if (json["cover_xl"] is String) this.coverXl = json["cover_xl"];
    if (json["md5_image"] is String) this.md5Image = json["md5_image"];
    if (json["tracklist"] is String) this.tracklist = json["tracklist"];
    if (json["type"] is String) this.type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["title"] = this.title;
    data["cover"] = this.cover;
    data["cover_small"] = this.coverSmall;
    data["cover_medium"] = this.coverMedium;
    data["cover_big"] = this.coverBig;
    data["cover_xl"] = this.coverXl;
    data["md5_image"] = this.md5Image;
    data["tracklist"] = this.tracklist;
    data["type"] = this.type;
    return data;
  }
}

class Artist {
  int? id;
  String? name;
  String? link;
  String? tracklist;
  String? type;

  Artist({this.id, this.name, this.link, this.tracklist, this.type});

  Artist.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["name"] is String) this.name = json["name"];
    if (json["link"] is String) this.link = json["link"];
    if (json["tracklist"] is String) this.tracklist = json["tracklist"];
    if (json["type"] is String) this.type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["link"] = this.link;
    data["tracklist"] = this.tracklist;
    data["type"] = this.type;
    return data;
  }
}

class Creator {
  int? id;
  String? name;
  String? tracklist;
  String? type;

  Creator({this.id, this.name, this.tracklist, this.type});

  Creator.fromJson(Map<String, dynamic> json) {
    if (json["id"] is int) this.id = json["id"];
    if (json["name"] is String) this.name = json["name"];
    if (json["tracklist"] is String) this.tracklist = json["tracklist"];
    if (json["type"] is String) this.type = json["type"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["tracklist"] = this.tracklist;
    data["type"] = this.type;
    return data;
  }
}
