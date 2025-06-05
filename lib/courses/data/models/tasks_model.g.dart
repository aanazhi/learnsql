// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TasksModel _$TasksModelFromJson(Map<String, dynamic> json) => TasksModel(
  count: (json['count'] as num).toInt(),
  results:
      (json['results'] as List<dynamic>)
          .map((e) => ResultTasksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$TasksModelToJson(TasksModel instance) =>
    <String, dynamic>{'count': instance.count, 'results': instance.results};

ResultTasksModel _$ResultTasksModelFromJson(Map<String, dynamic> json) =>
    ResultTasksModel(
      id: (json['id'] as num).toInt(),
      status: json['status'] as String,
      userCourse: (json['user_course'] as num).toInt(),
      taskInSet: TaskInSet.fromJson(
        json['task_in_set'] as Map<String, dynamic>,
      ),
      solution: json['solution'] as String?,
    );

Map<String, dynamic> _$ResultTasksModelToJson(ResultTasksModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'user_course': instance.userCourse,
      'task_in_set': instance.taskInSet,
      'solution': instance.solution,
    };

TaskInSet _$TaskInSetFromJson(Map<String, dynamic> json) => TaskInSet(
  id: (json['id'] as num).toInt(),
  task: (json['task'] as num).toInt(),
);

Map<String, dynamic> _$TaskInSetToJson(TaskInSet instance) => <String, dynamic>{
  'id': instance.id,
  'task': instance.task,
};
