class ThemeEntity {
  final int id;
  final String number;
  final String topicName;
  final String content;
  final int section;
  final List<int> themesForTopic;

  ThemeEntity({
    required this.id,
    required this.number,
    required this.topicName,
    required this.content,
    required this.section,
    required this.themesForTopic,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThemeEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
