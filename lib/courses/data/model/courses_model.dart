import 'package:json_annotation/json_annotation.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/courses_entity.dart';

part 'courses_model.g.dart';

@JsonSerializable()
class CoursesModel {
  final int count;
  final dynamic next;
  final dynamic previous;
  final List<ResultModel> results;

  CoursesModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory CoursesModel.fromJson(Map<String, dynamic> json) =>
      _$CoursesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoursesModelToJson(this);

  CoursesListEntity toEntity() {
    return CoursesListEntity(
      count: count,
      next: next.toString(),
      previous: previous.toString(),
      results: results.map((res) => res.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class ResultModel {
  final int id;
  final String title;
  final String description;
  final List<String> themes;
  final String type;
  final int difficulty;

  @JsonKey(name: 'database_type')
  final dynamic databaseType;

  ResultModel({
    required this.id,
    required this.title,
    required this.description,
    required this.themes,
    required this.type,
    required this.difficulty,
    required this.databaseType,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultModelToJson(this);

  ResultEntity toEntity() {
    return ResultEntity(
      id: id,
      title: title,
      description: description,
      themes: themes,
      type: type,
      difficulty: difficulty,
      databaseType: databaseType.toString(),
    );
  }
}
