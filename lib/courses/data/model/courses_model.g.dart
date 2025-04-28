// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursesModel _$CoursesModelFromJson(Map<String, dynamic> json) => CoursesModel(
  count: (json['count'] as num).toInt(),
  next: json['next'],
  previous: json['previous'],
  results:
      (json['results'] as List<dynamic>)
          .map((e) => ResultModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$CoursesModelToJson(CoursesModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) => ResultModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  themes: (json['themes'] as List<dynamic>).map((e) => e as String).toList(),
  type: json['type'] as String,
  difficulty: (json['difficulty'] as num).toInt(),
  databaseType: json['database_type'],
);

Map<String, dynamic> _$ResultModelToJson(ResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'themes': instance.themes,
      'type': instance.type,
      'difficulty': instance.difficulty,
      'database_type': instance.databaseType,
    };
