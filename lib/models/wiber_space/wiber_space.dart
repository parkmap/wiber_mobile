import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wiber_mobile/models/user/user.dart';

part 'wiber_space.g.dart';
part 'wiber_space.freezed.dart';

@freezed
class WiberSpace with _$WiberSpace {
  const WiberSpace._();

  factory WiberSpace({
    @JsonKey(name: '_id') @Default('') String id,
    required String title,
    required bool isFavorite,
    required int maxCount,
    required int completeCount,
    required String owner,
    required List<User> participants,
  }) = _WiberSpace;

  factory WiberSpace.fromJson(Map<String, dynamic> json) =>
      _$WiberSpaceFromJson(json);
}
