// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddStory _$AddStoryFromJson(Map<String, dynamic> json) {
  return _AddStory.fromJson(json);
}

/// @nodoc
mixin _$AddStory {
  bool? get error => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddStoryCopyWith<AddStory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddStoryCopyWith<$Res> {
  factory $AddStoryCopyWith(AddStory value, $Res Function(AddStory) then) =
      _$AddStoryCopyWithImpl<$Res, AddStory>;
  @useResult
  $Res call({bool? error, String? message});
}

/// @nodoc
class _$AddStoryCopyWithImpl<$Res, $Val extends AddStory>
    implements $AddStoryCopyWith<$Res> {
  _$AddStoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddStoryImplCopyWith<$Res>
    implements $AddStoryCopyWith<$Res> {
  factory _$$AddStoryImplCopyWith(
          _$AddStoryImpl value, $Res Function(_$AddStoryImpl) then) =
      __$$AddStoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? error, String? message});
}

/// @nodoc
class __$$AddStoryImplCopyWithImpl<$Res>
    extends _$AddStoryCopyWithImpl<$Res, _$AddStoryImpl>
    implements _$$AddStoryImplCopyWith<$Res> {
  __$$AddStoryImplCopyWithImpl(
      _$AddStoryImpl _value, $Res Function(_$AddStoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
  }) {
    return _then(_$AddStoryImpl(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddStoryImpl implements _AddStory {
  const _$AddStoryImpl({this.error, this.message});

  factory _$AddStoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddStoryImplFromJson(json);

  @override
  final bool? error;
  @override
  final String? message;

  @override
  String toString() {
    return 'AddStory(error: $error, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddStoryImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AddStoryImplCopyWith<_$AddStoryImpl> get copyWith =>
      __$$AddStoryImplCopyWithImpl<_$AddStoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddStoryImplToJson(
      this,
    );
  }
}

abstract class _AddStory implements AddStory {
  const factory _AddStory({final bool? error, final String? message}) =
      _$AddStoryImpl;

  factory _AddStory.fromJson(Map<String, dynamic> json) =
      _$AddStoryImpl.fromJson;

  @override
  bool? get error;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$AddStoryImplCopyWith<_$AddStoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
