// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'faq.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Faq _$FaqFromJson(Map<String, dynamic> json) {
  return _Faq.fromJson(json);
}

/// @nodoc
mixin _$Faq {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get subTitle => throw _privateConstructorUsedError;
  String get contentText => throw _privateConstructorUsedError;
  bool get expanded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FaqCopyWith<Faq> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FaqCopyWith<$Res> {
  factory $FaqCopyWith(Faq value, $Res Function(Faq) then) =
      _$FaqCopyWithImpl<$Res, Faq>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String imageUrl,
      String title,
      String subTitle,
      String contentText,
      bool expanded});
}

/// @nodoc
class _$FaqCopyWithImpl<$Res, $Val extends Faq> implements $FaqCopyWith<$Res> {
  _$FaqCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? title = null,
    Object? subTitle = null,
    Object? contentText = null,
    Object? expanded = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subTitle: null == subTitle
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String,
      contentText: null == contentText
          ? _value.contentText
          : contentText // ignore: cast_nullable_to_non_nullable
              as String,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FaqImplCopyWith<$Res> implements $FaqCopyWith<$Res> {
  factory _$$FaqImplCopyWith(_$FaqImpl value, $Res Function(_$FaqImpl) then) =
      __$$FaqImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String imageUrl,
      String title,
      String subTitle,
      String contentText,
      bool expanded});
}

/// @nodoc
class __$$FaqImplCopyWithImpl<$Res> extends _$FaqCopyWithImpl<$Res, _$FaqImpl>
    implements _$$FaqImplCopyWith<$Res> {
  __$$FaqImplCopyWithImpl(_$FaqImpl _value, $Res Function(_$FaqImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = null,
    Object? title = null,
    Object? subTitle = null,
    Object? contentText = null,
    Object? expanded = null,
  }) {
    return _then(_$FaqImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subTitle: null == subTitle
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String,
      contentText: null == contentText
          ? _value.contentText
          : contentText // ignore: cast_nullable_to_non_nullable
              as String,
      expanded: null == expanded
          ? _value.expanded
          : expanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FaqImpl extends _Faq {
  _$FaqImpl(
      {@JsonKey(name: '_id') this.id = '',
      required this.imageUrl,
      required this.title,
      required this.subTitle,
      required this.contentText,
      required this.expanded})
      : super._();

  factory _$FaqImpl.fromJson(Map<String, dynamic> json) =>
      _$$FaqImplFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String imageUrl;
  @override
  final String title;
  @override
  final String subTitle;
  @override
  final String contentText;
  @override
  final bool expanded;

  @override
  String toString() {
    return 'Faq(id: $id, imageUrl: $imageUrl, title: $title, subTitle: $subTitle, contentText: $contentText, expanded: $expanded)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FaqImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subTitle, subTitle) ||
                other.subTitle == subTitle) &&
            (identical(other.contentText, contentText) ||
                other.contentText == contentText) &&
            (identical(other.expanded, expanded) ||
                other.expanded == expanded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, imageUrl, title, subTitle, contentText, expanded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FaqImplCopyWith<_$FaqImpl> get copyWith =>
      __$$FaqImplCopyWithImpl<_$FaqImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FaqImplToJson(
      this,
    );
  }
}

abstract class _Faq extends Faq {
  factory _Faq(
      {@JsonKey(name: '_id') final String id,
      required final String imageUrl,
      required final String title,
      required final String subTitle,
      required final String contentText,
      required final bool expanded}) = _$FaqImpl;
  _Faq._() : super._();

  factory _Faq.fromJson(Map<String, dynamic> json) = _$FaqImpl.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String get imageUrl;
  @override
  String get title;
  @override
  String get subTitle;
  @override
  String get contentText;
  @override
  bool get expanded;
  @override
  @JsonKey(ignore: true)
  _$$FaqImplCopyWith<_$FaqImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
