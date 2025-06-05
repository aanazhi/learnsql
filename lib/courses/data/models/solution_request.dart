import 'package:json_annotation/json_annotation.dart';

part 'solution_request.g.dart';

@JsonSerializable()
class SolutionRequestModel {
  final String solution;
  @JsonKey(name: 'task_id')
  final int taskId;
  final int status;
  final int id;

  SolutionRequestModel({
    required this.solution,
    required this.taskId,
    required this.status,
    required this.id,
  });

  factory SolutionRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SolutionRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SolutionRequestModelToJson(this);
}