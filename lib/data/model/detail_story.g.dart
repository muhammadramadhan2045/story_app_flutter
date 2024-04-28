// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DetailStoryImpl _$$DetailStoryImplFromJson(Map<String, dynamic> json) =>
    _$DetailStoryImpl(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      story: json['story'] == null
          ? null
          : ListStory.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$DetailStoryImplToJson(_$DetailStoryImpl instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
