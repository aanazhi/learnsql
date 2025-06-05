import 'package:json_annotation/json_annotation.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/request_entity.dart';

part 'request_model.g.dart';

@JsonSerializable()
class SolutionResponseModel {
  final String? status;
  @JsonKey(name: 'next_task')
  final int? nextTask;
  @JsonKey(name: 'student_result')
  final List<dynamic>? studentResult;
  @JsonKey(name: 'ref_result')
  final List<dynamic>? refResult;
  final double? progres;
  final String? message;

  SolutionResponseModel({
    this.status = 'error',
    this.nextTask,
    this.studentResult,
    this.refResult,
    this.progres,
    this.message,
  });

  factory SolutionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SolutionResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SolutionResponseModelToJson(this);

  SolutionResponseEntity toEntity() {
    return SolutionResponseEntity(
      status: status ?? 'error',
      nextTask: nextTask,
      studentResult: _parseResult(studentResult),
      refResult: _parseResult(refResult),
      progres: progres,
      message: message,
    );
  }

  List<QueryResult>? _parseResult(List<dynamic>? result) {
    if (result == null) return null;

    final queryResults = <QueryResult>[];
    for (var item in result) {
      if (item is List && item.length == 2) {
        final query = item[0] is String ? item[0] : '';
        final rowsData = item[1];

        final List<List<String>> rows = [];
        if (rowsData is List) {
          for (var row in rowsData) {
            if (row is List) {
              rows.add(row.map((e) => e.toString()).toList());
            }
          }
        }

        queryResults.add(QueryResult(query: query, rows: rows));
      }
    }
    return queryResults.isNotEmpty ? queryResults : null;
  }

  bool get isSuccess => status == 'ok';
  bool get isError => status == 'error';
}

class QueryResult {
  final String query;
  final List<List<String>> rows;

  QueryResult({required this.query, required this.rows});
}
