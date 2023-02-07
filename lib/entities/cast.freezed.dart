// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Cast _$CastFromJson(Map<String, dynamic> json) {
  return _Cast.fromJson(json);
}

/// @nodoc
mixin _$Cast {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get profile_path => throw _privateConstructorUsedError;
  String get character => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CastCopyWith<Cast> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CastCopyWith<$Res> {
  factory $CastCopyWith(Cast value, $Res Function(Cast) then) =
      _$CastCopyWithImpl<$Res, Cast>;
  @useResult
  $Res call({int id, String name, String? profile_path, String character});
}

/// @nodoc
class _$CastCopyWithImpl<$Res, $Val extends Cast>
    implements $CastCopyWith<$Res> {
  _$CastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profile_path = freezed,
    Object? character = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profile_path: freezed == profile_path
          ? _value.profile_path
          : profile_path // ignore: cast_nullable_to_non_nullable
              as String?,
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CastCopyWith<$Res> implements $CastCopyWith<$Res> {
  factory _$$_CastCopyWith(_$_Cast value, $Res Function(_$_Cast) then) =
      __$$_CastCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? profile_path, String character});
}

/// @nodoc
class __$$_CastCopyWithImpl<$Res> extends _$CastCopyWithImpl<$Res, _$_Cast>
    implements _$$_CastCopyWith<$Res> {
  __$$_CastCopyWithImpl(_$_Cast _value, $Res Function(_$_Cast) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? profile_path = freezed,
    Object? character = null,
  }) {
    return _then(_$_Cast(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profile_path: freezed == profile_path
          ? _value.profile_path
          : profile_path // ignore: cast_nullable_to_non_nullable
              as String?,
      character: null == character
          ? _value.character
          : character // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Cast implements _Cast {
  const _$_Cast(
      {required this.id,
      required this.name,
      required this.profile_path,
      required this.character});

  factory _$_Cast.fromJson(Map<String, dynamic> json) => _$$_CastFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String? profile_path;
  @override
  final String character;

  @override
  String toString() {
    return 'Cast(id: $id, name: $name, profile_path: $profile_path, character: $character)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Cast &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profile_path, profile_path) ||
                other.profile_path == profile_path) &&
            (identical(other.character, character) ||
                other.character == character));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, profile_path, character);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CastCopyWith<_$_Cast> get copyWith =>
      __$$_CastCopyWithImpl<_$_Cast>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CastToJson(
      this,
    );
  }
}

abstract class _Cast implements Cast {
  const factory _Cast(
      {required final int id,
      required final String name,
      required final String? profile_path,
      required final String character}) = _$_Cast;

  factory _Cast.fromJson(Map<String, dynamic> json) = _$_Cast.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get profile_path;
  @override
  String get character;
  @override
  @JsonKey(ignore: true)
  _$$_CastCopyWith<_$_Cast> get copyWith => throw _privateConstructorUsedError;
}
