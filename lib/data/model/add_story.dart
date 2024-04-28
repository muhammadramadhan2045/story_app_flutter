import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_story.g.dart';
part 'add_story.freezed.dart';

@freezed
class AddStory with _$AddStory {
  const factory AddStory({
    bool? error,
    String? message,
  }) = _AddStory;

  factory AddStory.fromJson(Map<String, dynamic> json) =>
      _$AddStoryFromJson(json);
}
