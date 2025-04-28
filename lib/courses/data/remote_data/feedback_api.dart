import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

abstract class FeedbackApi {
  Future<void> feedbackAdd({required String subject, required String message});
}

class FeedbackApiImpl implements FeedbackApi {
  final Dio _dio;
  final Talker _talker;

  FeedbackApiImpl({required Dio dio, required Talker talker})
    : _dio = dio,
      _talker = talker;

  @override
  Future<void> feedbackAdd({
    required String subject,
    required String message,
  }) async {
    const endpoint = 'api/feedback/add';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🚀 Posting feedback from $endpoint');

      final requestData = {
        'subject': subject,
        'message': message,
        'user': 'undefined',
      };

      await _dio.post(endpoint, data: requestData);

      _talker.log(
        '✅ Feedback post successfully (${stopwatch.elapsedMilliseconds}ms)',
      );
    } on DioException catch (e) {
      _talker.error('❌ Failed to post feedback (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to post feedback', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }
}
