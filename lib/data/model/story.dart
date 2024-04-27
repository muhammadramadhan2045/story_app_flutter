class Story {
  bool? error;
  String? message;
  List<ListStory>? listStory;

  Story({this.error, this.message, this.listStory});

  Story.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['listStory'] != null) {
      listStory = <ListStory>[];
      json['listStory'].forEach((v) {
        listStory!.add(ListStory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    if (listStory != null) {
      data['listStory'] = listStory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListStory {
  String? id;
  String? name;
  String? description;
  String? photoUrl;
  String? createdAt;
  double? lat;
  double? lon;

  ListStory(
      {this.id,
        this.name,
        this.description,
        this.photoUrl,
        this.createdAt,
        this.lat,
        this.lon});

  ListStory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    photoUrl = json['photoUrl'];
    createdAt = json['createdAt'];
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['photoUrl'] = photoUrl;
    data['createdAt'] = createdAt;
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}
