import 'package:learnsql/courses/domain/courses/courses_entity/request_entity.dart';

class ExecutionResult {
  final DateTime timestamp;
  final String query;
  final SolutionResponseEntity result;

  ExecutionResult({
    required this.timestamp,
    required this.query,
    required this.result,
  });
}
