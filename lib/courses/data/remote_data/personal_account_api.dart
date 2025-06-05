import 'package:dio/dio.dart';
import 'package:learnsql/courses/data/models/group_model.dart';
import 'package:learnsql/courses/data/models/personal_model.dart';
import 'package:talker/talker.dart';

abstract class PersonalAccountApi {
  Future<PersonalModel>? getPersonalData();
  Future<GroupModel>? getGroupData();
  Future<PersonalModel>? patchPersonalData({required FormData formData});
}

class PersonalAccountApiImpl implements PersonalAccountApi {
  final Dio _dio;
  final Talker _talker;

  PersonalAccountApiImpl({required Dio dio, required Talker talker})
    : _dio = dio,
      _talker = talker;

  @override
  Future<PersonalModel>? getPersonalData() async {
    const endpoint = 'auth/users/me';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🚀 Fetching personal data from $endpoint');

      final response = await _dio.get(endpoint);
      final responseData = response.data;

      _talker.log(
        '✅ Personal data fetched successfully (${stopwatch.elapsedMilliseconds}ms)',
      );
      return PersonalModel.fromJson(responseData);
    } on DioException catch (e) {
      _talker.error('❌ Failed to get personal data (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to get personal data', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<GroupModel>? getGroupData() async {
    const endpoint = 'api/student-groups';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🚀 Fetching groups from $endpoint');

      final response = await _dio.get(endpoint);
      final responseData = response.data;

      _talker.log(
        '✅ Groups fetched successfully (${stopwatch.elapsedMilliseconds}ms)',
      );
      return GroupModel.fromJson(responseData);
    } on DioException catch (e) {
      _talker.error('❌ Failed to get groups (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to get groups', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<PersonalModel>? patchPersonalData({required FormData formData}) async {
    const endpoint = 'auth/users/me/';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log(
        '🚀 Patching personal data from $endpoint with data:  ${formData.fields}',
      );

      final response = await _dio.patch(
        endpoint,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      _talker.log(
        '✅ Personal data patched successfully (${stopwatch.elapsedMilliseconds}ms)',
      );
      return PersonalModel.fromJson(response.data);
    } on DioException catch (e) {
      _talker.error('❌ Failed to patch personal data (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to patch personal data', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }
}
