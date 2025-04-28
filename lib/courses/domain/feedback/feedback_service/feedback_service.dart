import 'package:learnsql/courses/data/remote_data/feedback_api.dart';

abstract class FeedbackService {
  Future<void> feedbackAdd({required String subject, required String message});
}

class FeedbackServiceImpl implements FeedbackService {
  final FeedbackApi _feedbackApi;

  FeedbackServiceImpl({required FeedbackApi feedbackApi})
    : _feedbackApi = feedbackApi;

  @override
  Future<void> feedbackAdd({
    required String subject,
    required String message,
  }) async {
    await _feedbackApi.feedbackAdd(subject: subject, message: message);
  }
}
