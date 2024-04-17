// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wiber_space_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WiberSpaceList _$$_WiberSpaceListFromJson(Map<String, dynamic> json) =>
    _$_WiberSpaceList(
      list: (json['list'] as List<dynamic>)
          .map((e) => WiberSpace.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int? ?? 0,
      nextPage: json['nextPage'] as int?,
    );

Map<String, dynamic> _$$_WiberSpaceListToJson(_$_WiberSpaceList instance) =>
    <String, dynamic>{
      'list': instance.list,
      'totalCount': instance.totalCount,
      'nextPage': instance.nextPage,
    };
