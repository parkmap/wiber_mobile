// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bucket_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BucketList _$BucketListFromJson(Map<String, dynamic> json) {
  return _BucketList.fromJson(json);
}

/// @nodoc
mixin _$BucketList {
  List<Bucket> get list => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  int? get nextPage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BucketListCopyWith<BucketList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BucketListCopyWith<$Res> {
  factory $BucketListCopyWith(
          BucketList value, $Res Function(BucketList) then) =
      _$BucketListCopyWithImpl<$Res, BucketList>;
  @useResult
  $Res call({List<Bucket> list, int totalCount, int? nextPage});
}

/// @nodoc
class _$BucketListCopyWithImpl<$Res, $Val extends BucketList>
    implements $BucketListCopyWith<$Res> {
  _$BucketListCopyWithImpl(this._value, this._then);

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
              as List<Bucket>,
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
abstract class _$$BucketListImplCopyWith<$Res>
    implements $BucketListCopyWith<$Res> {
  factory _$$BucketListImplCopyWith(
          _$BucketListImpl value, $Res Function(_$BucketListImpl) then) =
      __$$BucketListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Bucket> list, int totalCount, int? nextPage});
}

/// @nodoc
class __$$BucketListImplCopyWithImpl<$Res>
    extends _$BucketListCopyWithImpl<$Res, _$BucketListImpl>
    implements _$$BucketListImplCopyWith<$Res> {
  __$$BucketListImplCopyWithImpl(
      _$BucketListImpl _value, $Res Function(_$BucketListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? list = null,
    Object? totalCount = null,
    Object? nextPage = freezed,
  }) {
    return _then(_$BucketListImpl(
      list: null == list
          ? _value._list
          : list // ignore: cast_nullable_to_non_nullable
              as List<Bucket>,
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
class _$BucketListImpl extends _BucketList {
  _$BucketListImpl(
      {required final List<Bucket> list, this.totalCount = 0, this.nextPage})
      : _list = list,
        super._();

  factory _$BucketListImpl.fromJson(Map<String, dynamic> json) =>
      _$$BucketListImplFromJson(json);

  final List<Bucket> _list;
  @override
  List<Bucket> get list {
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
    return 'BucketList(list: $list, totalCount: $totalCount, nextPage: $nextPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BucketListImpl &&
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
  _$$BucketListImplCopyWith<_$BucketListImpl> get copyWith =>
      __$$BucketListImplCopyWithImpl<_$BucketListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BucketListImplToJson(
      this,
    );
  }
}

abstract class _BucketList extends BucketList {
  factory _BucketList(
      {required final List<Bucket> list,
      final int totalCount,
      final int? nextPage}) = _$BucketListImpl;
  _BucketList._() : super._();

  factory _BucketList.fromJson(Map<String, dynamic> json) =
      _$BucketListImpl.fromJson;

  @override
  List<Bucket> get list;
  @override
  int get totalCount;
  @override
  int? get nextPage;
  @override
  @JsonKey(ignore: true)
  _$$BucketListImplCopyWith<_$BucketListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
