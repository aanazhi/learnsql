import 'package:dio/dio.dart';
import 'package:talker/talker.dart';

class TalkerDioInterceptor extends Interceptor {
  final Talker _talker;

  TalkerDioInterceptor({required Talker talker}) : _talker = talker;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _talker.log('[Dio] Request to ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _talker.log(
      '[Dio] Response from ${response.requestOptions.uri} '
      '(${response.statusCode})',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _talker.error('[Dio] Error', err, err.stackTrace);
    super.onError(err, handler);
  }
}
