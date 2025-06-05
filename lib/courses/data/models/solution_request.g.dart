// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'solution_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolutionRequestModel _$SolutionRequestModelFromJson(
  Map<String, dynamic> json,
) => SolutionRequestModel(
  solution: json['solution'] as String,
  taskId: (json['task_id'] as num).toInt(),
  status: (json['status'] as num).toInt(),
  id: (json['id'] as num).toInt(),
);

Map<String, dynamic> _$SolutionRequestModelToJson(
  SolutionRequestModel instance,
) => <String, dynamic>{
  'solution': instance.solution,
  'task_id': instance.taskId,
  'status': instance.status,
  'id': instance.id,
};
