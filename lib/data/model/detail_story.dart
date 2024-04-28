import 'package:story_app/data/model/story.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'detail_story.g.dart';
part 'detail_story.freezed.dart';

@freezed
class DetailStory with _$DetailStory {
  // bool? error;
  // String? message;
  // ListStory? story;

  // DetailStory({this.error, this.message, this.story});
  const factory DetailStory({
    bool? error,
    String? message,
    ListStory? story,
  }) = _DetailStory;

  factory DetailStory.fromJson(Map<String, dynamic> json) =>
      _$DetailStoryFromJson(json);
}
