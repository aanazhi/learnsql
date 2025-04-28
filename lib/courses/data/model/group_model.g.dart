// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupModel _$GroupModelFromJson(Map<String, dynamic> json) => GroupModel(
  count: (json['count'] as num).toInt(),
  results:
      (json['results'] as List<dynamic>)
          .map((e) => ListGroupsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$GroupModelToJson(GroupModel instance) =>
    <String, dynamic>{'count': instance.count, 'results': instance.results};

ListGroupsModel _$ListGroupsModelFromJson(Map<String, dynamic> json) =>
    ListGroupsModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      period: json['period'] as String,
      organization: json['organization'] as String,
    );

Map<String, dynamic> _$ListGroupsModelToJson(ListGroupsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'period': instance.period,
      'organization': instance.organization,
    };
