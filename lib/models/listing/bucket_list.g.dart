// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BucketList _$$_BucketListFromJson(Map<String, dynamic> json) =>
    _$_BucketList(
      list: (json['list'] as List<dynamic>)
          .map((e) => Bucket.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int? ?? 0,
      nextPage: json['nextPage'] as int?,
    );

Map<String, dynamic> _$$_BucketListToJson(_$_BucketList instance) =>
    <String, dynamic>{
      'list': instance.list,
      'totalCount': instance.totalCount,
      'nextPage': instance.nextPage,
    };
