import 'package:collection/collection.dart';

class GroupEntity {
  final int count;
  final List<ListGroupEntity> results;

  GroupEntity({required this.count, required this.results});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupEntity &&
          runtimeType == other.runtimeType &&
          count == other.count &&
          const ListEquality().equals(results, other.results);

  @override
  int get hashCode => const ListEquality().hash(results);
}

class ListGroupEntity {
  final int id;
  final String title;
  final String period;
  final String organization;

  ListGroupEntity({
    required this.id,
    required this.title,
    required this.period,
    required this.organization,
  });
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListGroupEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
