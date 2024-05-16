import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wiber_mobile/models/user/user.dart';

part 'wiber_space.g.dart';
part 'wiber_space.freezed.dart';

@freezed
class WiberSpace with _$WiberSpace {
  const WiberSpace._();

  factory WiberSpace({
    @JsonKey(name: 'space_id') @Default('') String id,
    required String title,
    @Default(false) bool isFavorite,
    @Default(0) int maxCount,
    @Default(0) int completeCount,
    @Default("") String owner,
    required List<User> members,
  }) = _WiberSpace;

  factory WiberSpace.fromJson(Map<String, dynamic> json) =>
      _$WiberSpaceFromJson(json);
}
