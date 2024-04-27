// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faq.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaqImpl _$$FaqImplFromJson(Map<String, dynamic> json) => _$FaqImpl(
      id: json['_id'] as String? ?? '',
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      subTitle: json['subTitle'] as String,
      contentText: json['contentText'] as String,
      expanded: json['expanded'] as bool,
    );

Map<String, dynamic> _$$FaqImplToJson(_$FaqImpl instance) => <String, dynamic>{
      '_id': instance.id,
      'imageUrl': instance.imageUrl,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'contentText': instance.contentText,
      'expanded': instance.expanded,
    };
