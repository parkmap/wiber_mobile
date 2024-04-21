// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BucketListImpl _$$BucketListImplFromJson(Map<String, dynamic> json) =>
    _$BucketListImpl(
      list: (json['list'] as List<dynamic>)
          .map((e) => Bucket.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int? ?? 0,
      nextPage: json['nextPage'] as int?,
    );

Map<String, dynamic> _$$BucketListImplToJson(_$BucketListImpl instance) =>
    <String, dynamic>{
      'list': instance.list,
      'totalCount': instance.totalCount,
      'nextPage': instance.nextPage,
    };
