import 'package:dio/dio.dart';
import 'package:learnsql/courses/data/model/courses_model.dart';
import 'package:talker/talker.dart';

abstract class CoursesApi {
  Future<CoursesModel>? getAllCouses();
  Future<void> addCourse({required int course});
  Future<dynamic>? getJoinedCourses();
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
}
