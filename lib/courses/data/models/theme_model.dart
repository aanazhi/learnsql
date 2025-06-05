import 'package:json_annotation/json_annotation.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/theme_entity.dart';

part 'theme_model.g.dart';

@JsonSerializable()
class ThemeModel {
  final int id;
  final String number;

  @JsonKey(name: 'topic_name')
  final String topicName;

  final String content;
  final int section;

  @JsonKey(name: 'themes_for_topic')
  final List<int> themesForTopic;

  factory ThemeModel.fromJson(Map<String, dynamic> json) =>
      _$ThemeModelFromJson(json);

  ThemeModel({
    required this.id,
    required this.number,
    required this.topicName,
    required this.content,
    required this.section,
    required this.themesForTopic,
  });

  Map<String, dynamic> toJson() => _$ThemeModelToJson(this);

  ThemeEntity toEntity() {
    return ThemeEntity(
      id: id,
      number: number,
      topicName: topicName,
      content: content,
      section: section,
      themesForTopic: themesForTopic,
    );
  }
}
