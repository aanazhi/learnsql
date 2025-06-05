import 'package:json_annotation/json_annotation.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/one_task_entity.dart';

part 'one_task_model.g.dart';

@JsonSerializable()
class OneTaskModel {
  final int id;
  final String title;

  @JsonKey(name: 'database_image')
  final String? databaseImage;

  @JsonKey(name: 'database_description')
  final String? databaseDescription;

  @JsonKey(name: 'task_text')
  final String taskText;

  final int difficulty;

  @JsonKey(name: 'sandbox_db')
  final int sandboxDb;

  final int owner;

  @JsonKey(name: 'required_words')
  final String requiredWords;

  @JsonKey(name: 'banned_words')
  final String bannedWords;

  @JsonKey(name: 'should_check_runtime')
  final bool shouldCheckRuntime;

  @JsonKey(name: 'number_of_attempts')
  final int numberOfAttempts;

  @JsonKey(name: 'allowed_time_error')
  final double allowedTimeError;

  final List<TaskThemeModel> themes;

  OneTaskModel({
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

  factory OneTaskModel.fromJson(Map<String, dynamic> json) =>
      _$OneTaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$OneTaskModelToJson(this);

  OneTaskEntity toEntity() {
    return OneTaskEntity(
      id: id,
      title: title,
      databaseImage: databaseImage,
      databaseDescription: databaseDescription,
      taskText: taskText,
      difficulty: difficulty,
      sandboxDb: sandboxDb,
      owner: owner,
      requiredWords: requiredWords,
      bannedWords: bannedWords,
      shouldCheckRuntime: shouldCheckRuntime,
      numberOfAttempts: numberOfAttempts,
      allowedTimeError: allowedTimeError,
      themes: themes.map((theme) => theme.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class TaskThemeModel {
  final ThemesOneTaskModel theme;
  final double affilation;

  TaskThemeModel({required this.theme, required this.affilation});

  factory TaskThemeModel.fromJson(Map<String, dynamic> json) =>
      _$TaskThemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskThemeModelToJson(this);

  OneTaskThemeEntity toEntity() {
    return OneTaskThemeEntity(theme: theme.toEntity(), affilation: affilation);
  }
}

@JsonSerializable()
class ThemesOneTaskModel {
  final int id;
  final String title;

  @JsonKey(name: 'topic_in_themes')
  final List<TopicInThemeModel> topicInThemes;

  ThemesOneTaskModel({
    required this.id,
    required this.title,
    required this.topicInThemes,
  });

  factory ThemesOneTaskModel.fromJson(Map<String, dynamic> json) =>
      _$ThemesOneTaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThemesOneTaskModelToJson(this);

  OneTaskThemEntity toEntity() {
    return OneTaskThemEntity(
      id: id,
      title: title,
      topicInThemes: topicInThemes.map((topic) => topic.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class TopicInThemeModel {
  final int id;

  @JsonKey(name: 'topic_name')
  final String topicName;
  final int section;

  TopicInThemeModel({
    required this.id,
    required this.topicName,
    required this.section,
  });

  factory TopicInThemeModel.fromJson(Map<String, dynamic> json) =>
      _$TopicInThemeModelFromJson(json);

  Map<String, dynamic> toJson() => _$TopicInThemeModelToJson(this);

  TopicInThemeEntity toEntity() {
    return TopicInThemeEntity(id: id, topicName: topicName, section: section);
  }
}
