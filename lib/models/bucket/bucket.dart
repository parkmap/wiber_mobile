import 'package:freezed_annotation/freezed_annotation.dart';

part 'bucket.g.dart';
part 'bucket.freezed.dart';

@freezed
class Bucket with _$Bucket {
  const Bucket._();

  factory Bucket({
    @Default('') String id,
    required String title,
    required String body,
    required String category,
    required bool isCompleted,
    @Default("") String endDate,
  }) = _Bucket;

  factory Bucket.fromJson(Map<String, dynamic> json) => _$BucketFromJson(json);
}
