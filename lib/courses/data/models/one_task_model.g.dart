// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'one_task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OneTaskModel _$OneTaskModelFromJson(Map<String, dynamic> json) => OneTaskModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  databaseImage: json['database_image'] as String?,
  databaseDescription: json['database_description'] as String?,
  taskText: json['task_text'] as String,
  difficulty: (json['difficulty'] as num).toInt(),
  sandboxDb: (json['sandbox_db'] as num).toInt(),
  owner: (json['owner'] as num).toInt(),
  requiredWords: json['required_words'] as String,
  bannedWords: json['banned_words'] as String,
  shouldCheckRuntime: json['should_check_runtime'] as bool,
  numberOfAttempts: (json['number_of_attempts'] as num).toInt(),
  allowedTimeError: (json['allowed_time_error'] as num).toDouble(),
  themes:
      (json['themes'] as List<dynamic>)
          .map((e) => TaskThemeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$OneTaskModelToJson(OneTaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'database_image': instance.databaseImage,
      'database_description': instance.databaseDescription,
      'task_text': instance.taskText,
      'difficulty': instance.difficulty,
      'sandbox_db': instance.sandboxDb,
      'owner': instance.owner,
      'required_words': instance.requiredWords,
      'banned_words': instance.bannedWords,
      'should_check_runtime': instance.shouldCheckRuntime,
      'number_of_attempts': instance.numberOfAttempts,
      'allowed_time_error': instance.allowedTimeError,
      'themes': instance.themes,
    };

TaskThemeModel _$TaskThemeModelFromJson(Map<String, dynamic> json) =>
    TaskThemeModel(
      theme: ThemesOneTaskModel.fromJson(json['theme'] as Map<String, dynamic>),
      affilation: (json['affilation'] as num).toDouble(),
    );

Map<String, dynamic> _$TaskThemeModelToJson(TaskThemeModel instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'affilation': instance.affilation,
    };

ThemesOneTaskModel _$ThemesOneTaskModelFromJson(Map<String, dynamic> json) =>
    ThemesOneTaskModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      topicInThemes:
          (json['topic_in_themes'] as List<dynamic>)
              .map((e) => TopicInThemeModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$ThemesOneTaskModelToJson(ThemesOneTaskModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'topic_in_themes': instance.topicInThemes,
    };

TopicInThemeModel _$TopicInThemeModelFromJson(Map<String, dynamic> json) =>
    TopicInThemeModel(
      id: (json['id'] as num).toInt(),
      topicName: json['topic_name'] as String,
      section: (json['section'] as num).toInt(),
    );

Map<String, dynamic> _$TopicInThemeModelToJson(TopicInThemeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic_name': instance.topicName,
      'section': instance.section,
    };
