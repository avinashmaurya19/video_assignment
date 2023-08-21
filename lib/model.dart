class Video {
  Play? play;

  Video({this.play});

  Video.fromJson(Map<String, dynamic> json) {
    play = json['play'] != null ? Play.fromJson(json['play']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (play != null) {
      data['play'] = play!.toJson();
    }
    return data;
  }
}

class Play {
  Hls? hls;

  Play({this.hls});

  Play.fromJson(Map<String, dynamic> json) {
    hls = json['hls'] != null ? Hls.fromJson(json['hls']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hls != null) {
      data['hls'] = hls!.toJson();
    }
    return data;
  }
}

class Hls {
  String? linkExpirationTime;
  String? link;

  Hls({this.linkExpirationTime, this.link});

  Hls.fromJson(Map<String, dynamic> json) {
    linkExpirationTime = json['link_expiration_time'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['link_expiration_time'] = linkExpirationTime;
    data['link'] = link;
    return data;
  }
}
