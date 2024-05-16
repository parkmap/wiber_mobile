// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wiber_space.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WiberSpace _$WiberSpaceFromJson(Map<String, dynamic> json) {
  return _WiberSpace.fromJson(json);
}

/// @nodoc
mixin _$WiberSpace {
  @JsonKey(name: 'space_id')
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  int get maxCount => throw _privateConstructorUsedError;
  int get completeCount => throw _privateConstructorUsedError;
  String get owner => throw _privateConstructorUsedError;
  List<User> get members => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiberSpaceCopyWith<WiberSpace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiberSpaceCopyWith<$Res> {
  factory $WiberSpaceCopyWith(
          WiberSpace value, $Res Function(WiberSpace) then) =
      _$WiberSpaceCopyWithImpl<$Res, WiberSpace>;
  @useResult
  $Res call(
      {@JsonKey(name: 'space_id') String id,
      String title,
      bool isFavorite,
      int maxCount,
      int completeCount,
      String owner,
      List<User> members});
}

/// @nodoc
class _$WiberSpaceCopyWithImpl<$Res, $Val extends WiberSpace>
    implements $WiberSpaceCopyWith<$Res> {
  _$WiberSpaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? isFavorite = null,
    Object? maxCount = null,
    Object? completeCount = null,
    Object? owner = null,
    Object? members = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCount: null == maxCount
          ? _value.maxCount
          : maxCount // ignore: cast_nullable_to_non_nullable
              as int,
      completeCount: null == completeCount
          ? _value.completeCount
          : completeCount // ignore: cast_nullable_to_non_nullable
              as int,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<User>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WiberSpaceImplCopyWith<$Res>
    implements $WiberSpaceCopyWith<$Res> {
  factory _$$WiberSpaceImplCopyWith(
          _$WiberSpaceImpl value, $Res Function(_$WiberSpaceImpl) then) =
      __$$WiberSpaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'space_id') String id,
      String title,
      bool isFavorite,
      int maxCount,
      int completeCount,
      String owner,
      List<User> members});
}

/// @nodoc
class __$$WiberSpaceImplCopyWithImpl<$Res>
    extends _$WiberSpaceCopyWithImpl<$Res, _$WiberSpaceImpl>
    implements _$$WiberSpaceImplCopyWith<$Res> {
  __$$WiberSpaceImplCopyWithImpl(
      _$WiberSpaceImpl _value, $Res Function(_$WiberSpaceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? isFavorite = null,
    Object? maxCount = null,
    Object? completeCount = null,
    Object? owner = null,
    Object? members = null,
  }) {
    return _then(_$WiberSpaceImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      maxCount: null == maxCount
          ? _value.maxCount
          : maxCount // ignore: cast_nullable_to_non_nullable
              as int,
      completeCount: null == completeCount
          ? _value.completeCount
          : completeCount // ignore: cast_nullable_to_non_nullable
              as int,
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as String,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<User>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WiberSpaceImpl extends _WiberSpace {
  _$WiberSpaceImpl(
      {@JsonKey(name: 'space_id') this.id = '',
      required this.title,
      this.isFavorite = false,
      this.maxCount = 0,
      this.completeCount = 0,
      this.owner = "",
      required final List<User> members})
      : _members = members,
        super._();

  factory _$WiberSpaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiberSpaceImplFromJson(json);

  @override
  @JsonKey(name: 'space_id')
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final bool isFavorite;
  @override
  @JsonKey()
  final int maxCount;
  @override
  @JsonKey()
  final int completeCount;
  @override
  @JsonKey()
  final String owner;
  final List<User> _members;
  @override
  List<User> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'WiberSpace(id: $id, title: $title, isFavorite: $isFavorite, maxCount: $maxCount, completeCount: $completeCount, owner: $owner, members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiberSpaceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.maxCount, maxCount) ||
                other.maxCount == maxCount) &&
            (identical(other.completeCount, completeCount) ||
                other.completeCount == completeCount) &&
            (identical(other.owner, owner) || other.owner == owner) &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, isFavorite, maxCount,
      completeCount, owner, const DeepCollectionEquality().hash(_members));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiberSpaceImplCopyWith<_$WiberSpaceImpl> get copyWith =>
      __$$WiberSpaceImplCopyWithImpl<_$WiberSpaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiberSpaceImplToJson(
      this,
    );
  }
}

abstract class _WiberSpace extends WiberSpace {
  factory _WiberSpace(
      {@JsonKey(name: 'space_id') final String id,
      required final String title,
      final bool isFavorite,
      final int maxCount,
      final int completeCount,
      final String owner,
      required final List<User> members}) = _$WiberSpaceImpl;
  _WiberSpace._() : super._();

  factory _WiberSpace.fromJson(Map<String, dynamic> json) =
      _$WiberSpaceImpl.fromJson;

  @override
  @JsonKey(name: 'space_id')
  String get id;
  @override
  String get title;
  @override
  bool get isFavorite;
  @override
  int get maxCount;
  @override
  int get completeCount;
  @override
  String get owner;
  @override
  List<User> get members;
  @override
  @JsonKey(ignore: true)
  _$$WiberSpaceImplCopyWith<_$WiberSpaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
