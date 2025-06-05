// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SolutionResponseModel _$SolutionResponseModelFromJson(
  Map<String, dynamic> json,
) => SolutionResponseModel(
  status: json['status'] as String? ?? 'error',
  nextTask: (json['next_task'] as num?)?.toInt(),
  studentResult: json['student_result'] as List<dynamic>?,
  refResult: json['ref_result'] as List<dynamic>?,
  progres: (json['progres'] as num?)?.toDouble(),
  message: json['message'] as String?,
);

Map<String, dynamic> _$SolutionResponseModelToJson(
  SolutionResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'next_task': instance.nextTask,
  'student_result': instance.studentResult,
  'ref_result': instance.refResult,
  'progres': instance.progres,
  'message': instance.message,
};
