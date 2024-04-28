import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'story.g.dart';
part 'story.freezed.dart';

@freezed
class Story with _$Story {
  // bool? error;
  // String? message;
  // List<ListStory>? listStory;

  // Story({this.error, this.message, this.listStory});

  const factory Story({
    bool? error,
    String? message,
    List<ListStory>? listStory,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}

@freezed
class ListStory with _$ListStory {
  // String? id;
  // String? name;
  // String? description;
  // String? photoUrl;
  // String? createdAt;
  // double? lat;
  // double? lon;

  // ListStory(
  //     {this.id,
  //     this.name,
  //     this.description,
  //     this.photoUrl,
  //     this.createdAt,
  //     this.lat,
  //     this.lon});

  const factory ListStory({
    String? id,
    String? name,
     String? description,
     String? photoUrl,
     String? createdAt,
     double? lat,
     double? lon,
  }) = _ListStory;

  factory ListStory.fromJson(Map<String, dynamic> json) =>
      _$ListStoryFromJson(json);
}
