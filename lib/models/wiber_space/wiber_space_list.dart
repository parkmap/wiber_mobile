import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wiber_mobile/models/wiber_space/wiber_space.dart';

part 'wiber_space_list.freezed.dart';
part 'wiber_space_list.g.dart';

@freezed
class WiberSpaceList with _$WiberSpaceList {
  const WiberSpaceList._();
  factory WiberSpaceList(
      {required List<WiberSpace> list,
      @Default(0) int totalCount,
      int? nextPage}) = _WiberSpaceList;

  bool get isEmpty => list.isEmpty;

  factory WiberSpaceList.fromJson(Map<String, dynamic> json) =>
      _$WiberSpaceListFromJson(json);
}
