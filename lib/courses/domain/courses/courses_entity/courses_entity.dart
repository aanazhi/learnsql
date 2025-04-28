import 'package:collection/collection.dart';

class CoursesListEntity {
  final int count;
  final String next;
  final String previous;
  final List<ResultEntity> results;

  CoursesListEntity({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CoursesListEntity &&
          runtimeType == other.runtimeType &&
          count == other.count &&
          const ListEquality().equals(results, other.results);

  @override
  int get hashCode => const ListEquality().hash(results);
}

class ResultEntity {
  final int id;
  final String title;
  final String description;
  final List<String> themes;
  final String type;
  final int difficulty;
  final String databaseType;

  ResultEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.themes,
    required this.type,
    required this.difficulty,
    required this.databaseType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
