import 'package:collection/collection.dart';

class TasksEntity {
  final int count;
  final List<ResultTasksEntity> results;

  TasksEntity({required this.count, required this.results});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksEntity &&
          runtimeType == other.runtimeType &&
          count == other.count &&
          const ListEquality().equals(results, other.results);

  @override
  int get hashCode => const ListEquality().hash(results);
}

class ResultTasksEntity {
  final int id;
  final String status;
  final int userCouse;
  final TaskInSetEntity taskInSet;
  final String? solution;

  ResultTasksEntity({
    required this.id,
    required this.status,
    required this.userCouse,
    required this.taskInSet,
    required this.solution,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultTasksEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class TaskInSetEntity {
  final int id;
  final int task;

  TaskInSetEntity({required this.id, required this.task});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskInSetEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
