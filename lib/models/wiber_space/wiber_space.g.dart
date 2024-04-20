// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiber_space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WiberSpace _$$_WiberSpaceFromJson(Map<String, dynamic> json) =>
    _$_WiberSpace(
      id: json['_id'] as String? ?? '',
      title: json['title'] as String,
      isFavorite: json['isFavorite'] as bool,
      maxCount: json['maxCount'] as int,
      completeCount: json['completeCount'] as int,
      owner: json['owner'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_WiberSpaceToJson(_$_WiberSpace instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'isFavorite': instance.isFavorite,
      'maxCount': instance.maxCount,
      'completeCount': instance.completeCount,
      'owner': instance.owner,
      'participants': instance.participants,
    };
