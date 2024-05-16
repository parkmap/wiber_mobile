import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wiber_mobile/models/user/user.dart';

part 'category.g.dart';
part 'category.freezed.dart';

@freezed
class Category with _$Category {
  const Category._();

  factory Category({
    @JsonKey(name: 'created_id') @Default('') String id,
    required String title,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
