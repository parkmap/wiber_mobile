// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiber_space.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WiberSpaceImpl _$$WiberSpaceImplFromJson(Map<String, dynamic> json) =>
    _$WiberSpaceImpl(
      id: json['space_id'] as String? ?? '',
      title: json['title'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      maxCount: json['maxCount'] as int? ?? 0,
      completeCount: json['completeCount'] as int? ?? 0,
      owner: json['owner'] as String? ?? "",
      members: (json['members'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WiberSpaceImplToJson(_$WiberSpaceImpl instance) =>
    <String, dynamic>{
      'space_id': instance.id,
      'title': instance.title,
      'isFavorite': instance.isFavorite,
      'maxCount': instance.maxCount,
      'completeCount': instance.completeCount,
      'owner': instance.owner,
      'members': instance.members,
    };
