import 'package:learnsql/courses/data/models/request_model.dart';

class SolutionResponseEntity {
  final String? status;
  final int? nextTask;
  final List<QueryResult>? studentResult;
  final List<QueryResult>? refResult;
  final double? progres;
  final String? message;

  SolutionResponseEntity({
    this.status,
    this.nextTask,
    this.studentResult,
    this.refResult,
    this.progres,
    this.message,
  });

  bool get isSuccess => status == 'ok';
  bool get isError => status == 'error';
}
