// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bucket.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bucket _$BucketFromJson(Map<String, dynamic> json) {
  return _Bucket.fromJson(json);
}

/// @nodoc
mixin _$Bucket {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BucketCopyWith<Bucket> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BucketCopyWith<$Res> {
  factory $BucketCopyWith(Bucket value, $Res Function(Bucket) then) =
      _$BucketCopyWithImpl<$Res, Bucket>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String title,
      String body,
      String category,
      bool isCompleted});
}

/// @nodoc
class _$BucketCopyWithImpl<$Res, $Val extends Bucket>
    implements $BucketCopyWith<$Res> {
  _$BucketCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? category = null,
    Object? isCompleted = null,
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
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BucketCopyWith<$Res> implements $BucketCopyWith<$Res> {
  factory _$$_BucketCopyWith(_$_Bucket value, $Res Function(_$_Bucket) then) =
      __$$_BucketCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String title,
      String body,
      String category,
      bool isCompleted});
}

/// @nodoc
class __$$_BucketCopyWithImpl<$Res>
    extends _$BucketCopyWithImpl<$Res, _$_Bucket>
    implements _$$_BucketCopyWith<$Res> {
  __$$_BucketCopyWithImpl(_$_Bucket _value, $Res Function(_$_Bucket) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? category = null,
    Object? isCompleted = null,
  }) {
    return _then(_$_Bucket(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Bucket extends _Bucket {
  _$_Bucket(
      {@JsonKey(name: '_id') this.id = '',
      required this.title,
      required this.body,
      required this.category,
      required this.isCompleted})
      : super._();

  factory _$_Bucket.fromJson(Map<String, dynamic> json) =>
      _$$_BucketFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String title;
  @override
  final String body;
  @override
  final String category;
  @override
  final bool isCompleted;

  @override
  String toString() {
    return 'Bucket(id: $id, title: $title, body: $body, category: $category, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Bucket &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, body, category, isCompleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BucketCopyWith<_$_Bucket> get copyWith =>
      __$$_BucketCopyWithImpl<_$_Bucket>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BucketToJson(
      this,
    );
  }
}

abstract class _Bucket extends Bucket {
  factory _Bucket(
      {@JsonKey(name: '_id') final String id,
      required final String title,
      required final String body,
      required final String category,
      required final bool isCompleted}) = _$_Bucket;
  _Bucket._() : super._();

  factory _Bucket.fromJson(Map<String, dynamic> json) = _$_Bucket.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get title;
  @override
  String get body;
  @override
  String get category;
  @override
  bool get isCompleted;
  @override
  @JsonKey(ignore: true)
  _$$_BucketCopyWith<_$_Bucket> get copyWith =>
      throw _privateConstructorUsedError;
}
