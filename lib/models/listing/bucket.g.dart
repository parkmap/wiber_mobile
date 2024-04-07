// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bucket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Bucket _$$_BucketFromJson(Map<String, dynamic> json) => _$_Bucket(
      title: json['title'] as String,
      body: json['body'] as String,
      category: json['category'] as String,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$$_BucketToJson(_$_Bucket instance) => <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'category': instance.category,
      'isCompleted': instance.isCompleted,
    };
