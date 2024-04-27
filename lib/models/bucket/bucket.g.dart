// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BucketImpl _$$BucketImplFromJson(Map<String, dynamic> json) => _$BucketImpl(
      id: json['_id'] as String? ?? '',
      title: json['title'] as String,
      body: json['body'] as String,
      category: json['category'] as String,
      isCompleted: json['isCompleted'] as bool,
      endDate: json['endDate'] as String,
    );

Map<String, dynamic> _$$BucketImplToJson(_$BucketImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'category': instance.category,
      'isCompleted': instance.isCompleted,
      'endDate': instance.endDate,
    };
