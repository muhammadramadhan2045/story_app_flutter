// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DetailStory _$DetailStoryFromJson(Map<String, dynamic> json) {
  return _DetailStory.fromJson(json);
}

/// @nodoc
mixin _$DetailStory {
  bool? get error => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  ListStory? get story => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DetailStoryCopyWith<DetailStory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailStoryCopyWith<$Res> {
  factory $DetailStoryCopyWith(
          DetailStory value, $Res Function(DetailStory) then) =
      _$DetailStoryCopyWithImpl<$Res, DetailStory>;
  @useResult
  $Res call({bool? error, String? message, ListStory? story});

  $ListStoryCopyWith<$Res>? get story;
}

/// @nodoc
class _$DetailStoryCopyWithImpl<$Res, $Val extends DetailStory>
    implements $DetailStoryCopyWith<$Res> {
  _$DetailStoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
    Object? story = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      story: freezed == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as ListStory?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ListStoryCopyWith<$Res>? get story {
    if (_value.story == null) {
      return null;
    }

    return $ListStoryCopyWith<$Res>(_value.story!, (value) {
      return _then(_value.copyWith(story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DetailStoryImplCopyWith<$Res>
    implements $DetailStoryCopyWith<$Res> {
  factory _$$DetailStoryImplCopyWith(
          _$DetailStoryImpl value, $Res Function(_$DetailStoryImpl) then) =
      __$$DetailStoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? error, String? message, ListStory? story});

  @override
  $ListStoryCopyWith<$Res>? get story;
}

/// @nodoc
class __$$DetailStoryImplCopyWithImpl<$Res>
    extends _$DetailStoryCopyWithImpl<$Res, _$DetailStoryImpl>
    implements _$$DetailStoryImplCopyWith<$Res> {
  __$$DetailStoryImplCopyWithImpl(
      _$DetailStoryImpl _value, $Res Function(_$DetailStoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
    Object? story = freezed,
  }) {
    return _then(_$DetailStoryImpl(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      story: freezed == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as ListStory?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DetailStoryImpl implements _DetailStory {
  const _$DetailStoryImpl({this.error, this.message, this.story});

  factory _$DetailStoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DetailStoryImplFromJson(json);

  @override
  final bool? error;
  @override
  final String? message;
  @override
  final ListStory? story;

  @override
  String toString() {
    return 'DetailStory(error: $error, message: $message, story: $story)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetailStoryImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.story, story) || other.story == story));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message, story);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DetailStoryImplCopyWith<_$DetailStoryImpl> get copyWith =>
      __$$DetailStoryImplCopyWithImpl<_$DetailStoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DetailStoryImplToJson(
      this,
    );
  }
}

abstract class _DetailStory implements DetailStory {
  const factory _DetailStory(
      {final bool? error,
      final String? message,
      final ListStory? story}) = _$DetailStoryImpl;

  factory _DetailStory.fromJson(Map<String, dynamic> json) =
      _$DetailStoryImpl.fromJson;

  @override
  bool? get error;
  @override
  String? get message;
  @override
  ListStory? get story;
  @override
  @JsonKey(ignore: true)
  _$$DetailStoryImplCopyWith<_$DetailStoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
