// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materials_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialsModel _$MaterialsModelFromJson(Map<String, dynamic> json) =>
    MaterialsModel(
      sections:
          (json['sections'] as List<dynamic>)
              .map((e) => SectionModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$MaterialsModelToJson(MaterialsModel instance) =>
    <String, dynamic>{'sections': instance.sections};

SectionModel _$SectionModelFromJson(Map<String, dynamic> json) => SectionModel(
  id: (json['id'] as num).toInt(),
  number: json['number'] as String,
  sectionName: json['section_name'] as String,
  definition: json['definition'] as String,
  course:
      (json['course'] as List<dynamic>).map((e) => (e as num).toInt()).toList(),
  topicsOfThisSection:
      (json['topics_of_this_section'] as List<dynamic>)
          .map((e) => TopicModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$SectionModelToJson(SectionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'section_name': instance.sectionName,
      'definition': instance.definition,
      'course': instance.course,
      'topics_of_this_section': instance.topicsOfThisSection,
    };

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
  id: (json['id'] as num).toInt(),
  topicName: json['topic_name'] as String,
  section: (json['section'] as num).toInt(),
);

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic_name': instance.topicName,
      'section': instance.section,
    };
