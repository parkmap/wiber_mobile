import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wiber_mobile/models/listing/bucket.dart';

part 'bucket_list.freezed.dart';
part 'bucket_list.g.dart';

@freezed
class BucketList with _$BucketList {
  const BucketList._();
  factory BucketList(
      {required List<Bucket> list,
      @Default(0) int totalCount,
      int? nextPage}) = _BucketList;

  bool get isEmpty => list.isEmpty;

  factory BucketList.fromJson(Map<String, dynamic> json) =>
      _$BucketListFromJson(json);
}
