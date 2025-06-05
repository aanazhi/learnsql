import 'package:json_annotation/json_annotation.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/tasks_entity.dart';

part 'tasks_model.g.dart';

@JsonSerializable()
class TasksModel {
  final int count;
  final List<ResultTasksModel> results;

  TasksModel({required this.count, required this.results});

  factory TasksModel.fromJson(Map<String, dynamic> json) =>
      _$TasksModelFromJson(json);

  Map<String, dynamic> toJson() => _$TasksModelToJson(this);

  TasksEntity toEntity() {
    return TasksEntity(
      count: count,
      results: results.map((res) => res.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class ResultTasksModel {
  final int id;
  final String status;

  @JsonKey(name: 'user_course')
  final int userCourse;

  @JsonKey(name: 'task_in_set')
  final TaskInSet taskInSet;

  final String? solution;

  ResultTasksModel({
    required this.id,
    required this.status,
    required this.userCourse,
    required this.taskInSet,
    this.solution,
  });

  factory ResultTasksModel.fromJson(Map<String, dynamic> json) =>
      _$ResultTasksModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResultTasksModelToJson(this);

  ResultTasksEntity toEntity() {
    return ResultTasksEntity(
      id: id,
      status: status,
      userCouse: userCourse,
      taskInSet: taskInSet.toEntity(),
      solution: solution,
    );
  }
}

@JsonSerializable()
class TaskInSet {
  final int id;
  final int task;

  TaskInSet({required this.id, required this.task});

  factory TaskInSet.fromJson(Map<String, dynamic> json) =>
      _$TaskInSetFromJson(json);

  Map<String, dynamic> toJson() => _$TaskInSetToJson(this);

  TaskInSetEntity toEntity() {
    return TaskInSetEntity(id: id, task: task);
  }
}
