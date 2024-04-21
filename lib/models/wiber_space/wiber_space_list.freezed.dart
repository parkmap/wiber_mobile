// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wiber_space_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WiberSpaceList _$WiberSpaceListFromJson(Map<String, dynamic> json) {
  return _WiberSpaceList.fromJson(json);
}

/// @nodoc
mixin _$WiberSpaceList {
  List<WiberSpace> get list => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int? get nextPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WiberSpaceListCopyWith<WiberSpaceList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WiberSpaceListCopyWith<$Res> {
  factory $WiberSpaceListCopyWith(
          WiberSpaceList value, $Res Function(WiberSpaceList) then) =
      _$WiberSpaceListCopyWithImpl<$Res, WiberSpaceList>;
  @useResult
  $Res call({List<WiberSpace> list, int totalCount, int? nextPage});
}

/// @nodoc
class _$WiberSpaceListCopyWithImpl<$Res, $Val extends WiberSpaceList>
    implements $WiberSpaceListCopyWith<$Res> {
  _$WiberSpaceListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? totalCount = null,
    Object? nextPage = freezed,
  }) {
    return _then(_value.copyWith(
      list: null == list
          ? _value.list
          : list // ignore: cast_nullable_to_non_nullable
              as List<WiberSpace>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      nextPage: freezed == nextPage
          ? _value.nextPage
          : nextPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WiberSpaceListImplCopyWith<$Res>
    implements $WiberSpaceListCopyWith<$Res> {
  factory _$$WiberSpaceListImplCopyWith(_$WiberSpaceListImpl value,
          $Res Function(_$WiberSpaceListImpl) then) =
      __$$WiberSpaceListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<WiberSpace> list, int totalCount, int? nextPage});
}

/// @nodoc
class __$$WiberSpaceListImplCopyWithImpl<$Res>
    extends _$WiberSpaceListCopyWithImpl<$Res, _$WiberSpaceListImpl>
    implements _$$WiberSpaceListImplCopyWith<$Res> {
  __$$WiberSpaceListImplCopyWithImpl(
      _$WiberSpaceListImpl _value, $Res Function(_$WiberSpaceListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? totalCount = null,
    Object? nextPage = freezed,
  }) {
    return _then(_$WiberSpaceListImpl(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<WiberSpace>,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      nextPage: freezed == nextPage
          ? _value.nextPage
          : nextPage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WiberSpaceListImpl extends _WiberSpaceList {
  _$WiberSpaceListImpl(
      {required final List<WiberSpace> list,
      this.totalCount = 0,
      this.nextPage})
      : _list = list,
        super._();

  factory _$WiberSpaceListImpl.fromJson(Map<String, dynamic> json) =>
      _$$WiberSpaceListImplFromJson(json);

  final List<WiberSpace> _list;
  @override
  List<WiberSpace> get list {
    if (_list is EqualUnmodifiableListView) return _list;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_list);
  }

  @override
  @JsonKey()
  final int totalCount;
  @override
  final int? nextPage;

  @override
  String toString() {
    return 'WiberSpaceList(list: $list, totalCount: $totalCount, nextPage: $nextPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WiberSpaceListImpl &&
            const DeepCollectionEquality().equals(other._list, _list) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.nextPage, nextPage) ||
                other.nextPage == nextPage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_list), totalCount, nextPage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WiberSpaceListImplCopyWith<_$WiberSpaceListImpl> get copyWith =>
      __$$WiberSpaceListImplCopyWithImpl<_$WiberSpaceListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WiberSpaceListImplToJson(
      this,
    );
  }
}

abstract class _WiberSpaceList extends WiberSpaceList {
  factory _WiberSpaceList(
      {required final List<WiberSpace> list,
      final int totalCount,
      final int? nextPage}) = _$WiberSpaceListImpl;
  _WiberSpaceList._() : super._();

  factory _WiberSpaceList.fromJson(Map<String, dynamic> json) =
      _$WiberSpaceListImpl.fromJson;

  @override
  List<WiberSpace> get list;
  @override
  int get totalCount;
  @override
  int? get nextPage;
  @override
  @JsonKey(ignore: true)
  _$$WiberSpaceListImplCopyWith<_$WiberSpaceListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
