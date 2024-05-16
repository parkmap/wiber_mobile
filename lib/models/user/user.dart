import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  factory User({
    @JsonKey(name: '_id') @Default('') String id,
    required String nickname,
    required String profileImageUrl,
    required String refreshedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
