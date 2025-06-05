import 'package:json_annotation/json_annotation.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/materials_entity.dart';

part 'materials_model.g.dart';

@JsonSerializable()
class MaterialsModel {
  final List<SectionModel> sections;

  MaterialsModel({required this.sections});

  factory MaterialsModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaterialsModelToJson(this);

  MaterialsEntity toEntity() {
    return MaterialsEntity(
      sections: sections.map((s) => s.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class SectionModel {
  final int id;
  final String number;
  @JsonKey(name: 'section_name')
  final String sectionName;
  final String definition;
  final List<int> course;
  @JsonKey(name: 'topics_of_this_section')
  final List<TopicModel> topicsOfThisSection;

  SectionModel({
    required this.id,
    required this.number,
    required this.sectionName,
    required this.definition,
    required this.course,
    required this.topicsOfThisSection,
  });

  factory SectionModel.fromJson(Map<String, dynamic> json) =>
      _$SectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SectionModelToJson(this);

  SectionEntity toEntity() {
    return SectionEntity(
      id: id,
      number: number,
      sectionName: sectionName,
      definition: definition,
      course: course,
      topicsOfThisSection:
          topicsOfThisSection.map((topic) => topic.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class TopicModel {
  final int id;
  @JsonKey(name: 'topic_name')
  final String topicName;
  final int section;

  TopicModel({
    required this.id,
    required this.topicName,
    required this.section,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopicModelToJson(this);

  TopicsOfThisSectionEntity toEntity() {
    return TopicsOfThisSectionEntity(
      id: id,
      topicName: topicName,
      section: section,
    );
  }
}
