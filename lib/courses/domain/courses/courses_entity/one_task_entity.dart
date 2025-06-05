class OneTaskEntity {
  final int id;
  final String title;
  final String? databaseImage;
  final String? databaseDescription;
  final String taskText;
  final int difficulty;
  final int sandboxDb;
  final int owner;
  final String requiredWords;
  final String bannedWords;
  final bool shouldCheckRuntime;
  final int numberOfAttempts;
  final double allowedTimeError;
  final List<OneTaskThemeEntity> themes;

  OneTaskEntity({
    required this.id,
    required this.title,
    this.databaseImage,
    this.databaseDescription,
    required this.taskText,
    required this.difficulty,
    required this.sandboxDb,
    required this.owner,
    required this.requiredWords,
    required this.bannedWords,
    required this.shouldCheckRuntime,
    required this.numberOfAttempts,
    required this.allowedTimeError,
    required this.themes,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OneTaskEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}

class OneTaskThemeEntity {
  final OneTaskThemEntity theme;
  final double affilation;

  OneTaskThemeEntity({required this.theme, required this.affilation});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OneTaskThemeEntity &&
          runtimeType == other.runtimeType &&
          theme == other.theme;

  @override
  int get hashCode => theme.hashCode;
}

class OneTaskThemEntity {
  final int id;
  final String title;
  final List<TopicInThemeEntity> topicInThemes;

  OneTaskThemEntity({
    required this.id,
    required this.title,
    required this.topicInThemes,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OneTaskThemEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title;

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}

class TopicInThemeEntity {
  final int id;
  final String topicName;
  final int section;

  TopicInThemeEntity({
    required this.id,
    required this.topicName,
    required this.section,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TopicInThemeEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          topicName == other.topicName;

  @override
  int get hashCode => id.hashCode ^ topicName.hashCode;
}
