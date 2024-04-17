import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@freezed
class User with _$User {
  const User._();

  factory User({
    @JsonKey(name: '_id') @Default('') String id,
    required String nickname,
    required String profileImageUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
