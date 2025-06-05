// ignore_for_file: avoid_redundant_argument_values

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learnsql/courses/data/models/courses_model.dart';
import 'package:learnsql/courses/data/models/materials_model.dart';
import 'package:learnsql/courses/data/models/one_task_model.dart';
import 'package:learnsql/courses/data/models/request_model.dart';
import 'package:learnsql/courses/data/models/solution_request.dart';
import 'package:learnsql/courses/data/models/tasks_model.dart';
import 'package:learnsql/courses/data/models/theme_model.dart';
import 'package:talker/talker.dart';

abstract class CoursesApi {
  Future<CoursesModel>? getAllCouses();
  Future<void> addCourse({required int course});
  Future<dynamic>? getJoinedCourses();
  Future<TasksModel> getTasks({required int id});
  Future<MaterialsModel> getMaterials({required int id});
  Future<ThemeModel> getTheme({required int id});
  Future<OneTaskModel> getOneTask({required int id});
  Future<SolutionResponseModel> executeSolution({
    required String solution,
    required int taskId,
    required int status,
    required int id,
  });
}

class CoursesApiImpl implements CoursesApi {
  final Dio _dio;
  final Talker _talker;

  CoursesApiImpl({required Dio dio, required Talker talker})
    : _dio = dio,
      _talker = talker;

  @override
  Future<CoursesModel>? getAllCouses() async {
    const endpoint = 'api/courses/';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🚀 Fetching courses from $endpoint');

      final response = await _dio.get(endpoint);
      final responseData = response.data;

      _talker.log(
        '✅ Courses fetched successfully (${stopwatch.elapsedMilliseconds}ms)',
      );

      _talker.log('📅 All courses - ${CoursesModel.fromJson(responseData)} ');

      return CoursesModel.fromJson(responseData);
    } on DioException catch (e) {
      _talker.error('❌ Failed to fetch courses (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to fetch courses', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<void> addCourse({required int course}) async {
    const endpoint = 'api/student-course/';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🚀 Added courses from $endpoint');

      final requestData = {'course': course.toString()};

      await _dio.post(endpoint, data: requestData);

      _talker.log(
        '✅ Courses added successfully (${stopwatch.elapsedMilliseconds}ms)',
      );
    } on DioException catch (e) {
      _talker.error('❌ Failed to add courses (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to add courses', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<dynamic>? getJoinedCourses() async {
    const endpoint = 'api/student-course/';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🚀 Fetching my courses from $endpoint');

      final response = await _dio.get(endpoint);
      final responseData = response.data;

      _talker.log(
        '✅ My courses fetched successfully (${stopwatch.elapsedMilliseconds}ms)',
      );

      return responseData;
    } on DioException catch (e) {
      _talker.error('❌ Failed to fetch my courses (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to fetch my courses', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<TasksModel> getTasks({required int id}) async {
    final endpoint = 'api/individualroutetasks/$id/';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🚀 Fetching tasks from $endpoint');

      final response = await _dio.get(endpoint);
      final responseData = response.data;

      _talker.log(
        '✅ Tasks fetched successfully (${stopwatch.elapsedMilliseconds}ms)',
      );

      _talker.log('📅 All tasks - ${TasksModel.fromJson(responseData)} ');

      return TasksModel.fromJson(responseData);
    } on DioException catch (e) {
      _talker.error('❌ Failed to fetch tasks (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to fetch tasks', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<MaterialsModel> getMaterials({required int id}) async {
    final endpoint = 'api/sectionsofmethodologicalmaterials/$id/';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🚀 Fetching materials from $endpoint');

      final response = await _dio.get(endpoint);
      final responseData = response.data;

      _talker.log(
        '✅ Materials fetched successfully (${stopwatch.elapsedMilliseconds}ms)',
      );

      final materials =
          (responseData as List)
              .map((json) => SectionModel.fromJson(json))
              .toList();

      _talker.log('📅 All materials - $materials');

      return MaterialsModel(sections: materials);
    } on DioException catch (e) {
      _talker.error('❌ Failed to fetch tasks (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to fetch tasks', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<ThemeModel> getTheme({required int id}) async {
    final endpoint = 'api/topicsofsection/detail/$id';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🚀 Fetching themes from $endpoint');

      final response = await _dio.get(endpoint);
      final responseData = response.data;

      _talker.log(
        '✅ Themes fetched successfully (${stopwatch.elapsedMilliseconds}ms)',
      );

      _talker.log('📅 All themes - ${ThemeModel.fromJson(responseData)} ');

      return ThemeModel.fromJson(responseData);
    } on DioException catch (e) {
      _talker.error('❌ Failed to fetch themes (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to fetch themes', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<OneTaskModel> getOneTask({required int id}) async {
    final endpoint = 'api/tasks/$id/';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🚀 Getting one task from $endpoint');

      final response = await _dio.get(endpoint);
      final responseData = response.data;

      _talker.log(
        '✅ One task getted successfully (${stopwatch.elapsedMilliseconds}ms)',
      );

      return OneTaskModel.fromJson(responseData);
    } on DioException catch (e) {
      _talker.error('❌ Failed to fetch one task (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to fetch one task', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<SolutionResponseModel> executeSolution({
    required String solution,
    required int taskId,
    required int status,
    required int id,
  }) async {
    const endpoint = 'api/student-course/do-task/';
    final stopwatch = Stopwatch()..start();

    try {
      final request = SolutionRequestModel(
        solution: solution,
        taskId: taskId,
        status: status,
        id: id,
      );
      final myRequest = request.toJson();
      final response = await _dio.put(
        endpoint,
        data: myRequest,
     
        
      );

      return SolutionResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.data is Map) {
          if (e.response!.data.containsKey('ref_result')) {
            return SolutionResponseModel.fromJson(e.response!.data);
          }
          return SolutionResponseModel(
            status: 'error',
            message:
                e.response!.data['message'] ?? 'Неизвестная ошибка сервера',
          );
        }
        return SolutionResponseModel(
          status: 'error',
          message: e.response!.data?.toString() ?? 'Ошибка без сообщения',
        );
      }
      return SolutionResponseModel(
        status: 'error',
        message: e.message ?? 'Ошибка сети',
      );
    } catch (e) {
      return SolutionResponseModel(
        status: 'error',
        message: 'Неизвестная ошибка: ${e.toString()}',
      );
    } finally {
      stopwatch.stop();
      debugPrint('Request took ${stopwatch.elapsedMilliseconds}ms');
    }
  }
}
