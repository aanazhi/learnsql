import 'package:collection/collection.dart';

class MaterialsEntity {
  final List<SectionEntity> sections;

  MaterialsEntity({required this.sections});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialsEntity &&
          runtimeType == other.runtimeType &&
          const ListEquality().equals(sections, other.sections);

  @override
  int get hashCode => const ListEquality().hash(sections);
}

class SectionEntity {
  final int id;
  final String number;
  final String sectionName;
  final String definition;
  final List<int> course;
  final List<TopicsOfThisSectionEntity> topicsOfThisSection;

  SectionEntity({
    required this.id,
    required this.number,
    required this.sectionName,
    required this.definition,
    required this.course,
    required this.topicsOfThisSection,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          const ListEquality().equals(
            topicsOfThisSection,
            other.topicsOfThisSection,
          );

  @override
  int get hashCode => const ListEquality().hash(topicsOfThisSection);
}

class TopicsOfThisSectionEntity {
  final int id;
  final String topicName;
  final int section;

  TopicsOfThisSectionEntity({
    required this.id,
    required this.topicName,
    required this.section,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicsOfThisSectionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
