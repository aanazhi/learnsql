// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThemeModel _$ThemeModelFromJson(Map<String, dynamic> json) => ThemeModel(
  id: (json['id'] as num).toInt(),
  number: json['number'] as String,
  topicName: json['topic_name'] as String,
  content: json['content'] as String,
  section: (json['section'] as num).toInt(),
  themesForTopic:
      (json['themes_for_topic'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
);

Map<String, dynamic> _$ThemeModelToJson(ThemeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'topic_name': instance.topicName,
      'content': instance.content,
      'section': instance.section,
      'themes_for_topic': instance.themesForTopic,
    };
