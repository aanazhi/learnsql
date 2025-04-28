import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/enterance_registration/data/local_data/access_token_local_data_source/access_token_local_data_source.dart';
import 'package:learnsql/enterance_registration/data/local_data/error_local_data_source/error_local_data_source.dart';
import 'package:learnsql/enterance_registration/data/local_data/refresh_token_local_data_source/refresh_token_local_data_source.dart';
import 'package:learnsql/enterance_registration/data/remote_data/response_model_token/response_model.dart';
import 'package:talker/talker.dart';

abstract class AuthRegApi {
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String name,
    required String surname,
    required String password,
    String? organisation,
    String? period,
    int? groupNumber,
    int? isuNumber,
  });
  Future<ResponseModel> logIn({
    required String username,
    required String password,
  });
  Future<Map<String, String>?> getGoogleAccountData();
  Future<Map<String, dynamic>> resetPassword();
  Future<List<String>> getOrganization();
  Future<List<String>> getPeriod();
  Future<List<String>> getGroup({
    required String university,
    required String period,
  });
}

class AuthRegApiImpl implements AuthRegApi {
  final AccessTokenLocalDataSource _accessTokenLocalDataSource;
  final RefreshTokenLocalDataSource _refreshTokenLocalDataSource;
  final ErrorLocalDataSource _errorLocalDataSource;
  final Dio _dio;
  final GoogleSignIn _googleSignIn;
  final Talker _talker;

  AuthRegApiImpl({
    required Dio dio,
    required AccessTokenLocalDataSource accessTokenLocalDataSource,
    required RefreshTokenLocalDataSource refreshTokenLocalDataSource,
    required ErrorLocalDataSource errorLocalDataSource,
    required Talker talker,
  }) : _dio = dio,
       _talker = talker,
       _accessTokenLocalDataSource = accessTokenLocalDataSource,
       _refreshTokenLocalDataSource = refreshTokenLocalDataSource,
       _errorLocalDataSource = errorLocalDataSource,
       _googleSignIn = GoogleSignIn(
         clientId:
             '781734866323-bncl308f0i4g1artqqrcng8mb15dhvbf.apps.googleusercontent.com',
         scopes: ['email', 'profile'],
         hostedDomain: '',
         forceCodeForRefreshToken: true,
       );

  @override
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String name,
    required String surname,
    required String password,
    String? organisation,
    String? period,
    int? groupNumber,
    int? isuNumber,
  }) async {
    const endpoint = 'auth/users/';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log(
        '🚀 Register request started with username: $username and email: $email',
      );

      final requestData = {
        'username': username,
        'email': email,
        'first_name': name,
        'last_name': surname,
        'password': password,
        'organisation': organisation,
        'period': period,
        'group_number': groupNumber,
        'isu_number': isuNumber,
      };

      final response = await _dio.post<Map<String, dynamic>>(
        endpoint,
        data: requestData,
      );
      _talker.log('✅ Register successful (${stopwatch.elapsedMilliseconds}ms)');

      await _errorLocalDataSource.clearError();

      return response.data!;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        final errorData = e.response?.data;
        if (errorData is Map<String, dynamic>) {
          await _errorLocalDataSource.setErrorLocal(errorData);
          _talker.log('⚠️ Registration validation errors saved: $errorData');
        }
      }

      _talker.error('❌ Register failed (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Register failed', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<ResponseModel> logIn({
    required String username,
    required String password,
  }) async {
    const endpoint = 'social_auth_v2/token/';
    final stopwatch = Stopwatch()..start();

    try {
      _talker.log('🔑 Login request started with username: $username');

      final requestData = {
        'password': password,
        'username': username,
        'grant_type': 'password',
        'client_id': AppConstants.clientId,
        'client_secret': AppConstants.clientSecret,
      };

      final response = await _dio.post<Map<String, dynamic>>(
        endpoint,
        data: requestData,
      );

      final responseModel = ResponseModel.fromJson(response.data!);

      await Future.wait([
        _accessTokenLocalDataSource.setAccessToken(responseModel.accessToken),
        _refreshTokenLocalDataSource.setRefreshToken(
          responseModel.refreshToken,
        ),
      ]);

      _talker.log('✅ LogIn success (${stopwatch.elapsedMilliseconds}ms)');

      return responseModel;
    } on DioException catch (e) {
      _talker.error('❌ LogIn failed (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ LogIn failed', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<List<String>> getOrganization() async {
    const endpoint = 'api/student-groups/get_choise_values/?field=organization';
    final stopwatch = Stopwatch()..start();

    try {
      final response = await _dio.get(endpoint);

      final responseData = response.data;

      final List<dynamic> dataList = jsonDecode(responseData);
      final List<String> orgList =
          dataList.map((item) => item.toString()).toList();

      _talker.log(
        '🏛️ Organizations fetched (${stopwatch.elapsedMilliseconds}ms)',
      );

      return orgList;
    } on DioException catch (e) {
      _talker.error('❌ Failed to fetch organizations (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to fetch organizations', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<List<String>> getPeriod() async {
    const endpoint = 'api/student-groups/get_choise_values/?field=period';
    final stopwatch = Stopwatch()..start();

    try {
      final response = await _dio.get(endpoint);
      final responseData = response.data;

      final List<dynamic> dataList = jsonDecode(responseData);
      final List<String> periods =
          dataList.map((item) => item.toString()).toList();

      _talker.log('📅 Periods fetched (${stopwatch.elapsedMilliseconds}ms)');

      return periods;
    } on DioException catch (e) {
      _talker.error('❌ Failed to fetch periods (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to fetch periods', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<List<String>> getGroup({
    required String university,
    required String period,
  }) async {
    final endpoint =
        'api/student-groups/?period=$period&organization=$university';
    final stopwatch = Stopwatch()..start();

    try {
      final response = await _dio.get(endpoint);
      final responseData = response.data;

      final List<dynamic> dataList = responseData['results'];
      final List<String> groupList =
          dataList.map((item) => item['title'].toString()).toList();

      _talker.log('👥 Groups fetched (${stopwatch.elapsedMilliseconds}ms)');

      return groupList;
    } on DioException catch (e) {
      _talker.error('❌ Failed to fetch groups (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to fetch groups', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<Map<String, dynamic>> resetPassword() async {
    const endpoint = 'auth/users/reset_password/';
    final stopwatch = Stopwatch()..start();

    try {
      final response = await _dio.post<Map<String, dynamic>>(endpoint);

      _talker.log(
        '🔄 Password reset initiated (${stopwatch.elapsedMilliseconds}ms)',
      );

      return response.data!;
    } on DioException catch (e) {
      _talker.error('❌ Password reset failed (Dio)', e, e.stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      _talker.error('❌ Password reset failed', e, stackTrace);
      rethrow;
    } finally {
      stopwatch.stop();
    }
  }

  @override
  Future<Map<String, String>?> getGoogleAccountData() async {
    try {
      // Попытка входа
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Обработка данных пользователя
      final email = googleUser.email;
      final displayName = googleUser.displayName ?? '';

      final names = displayName.split(' ');
      final firstName = names.isNotEmpty ? names.first : '';
      final lastName = names.length > 1 ? names.sublist(1).join(' ') : '';

      return {
        'email': email,
        'username': email.split('@').first,
        'first_name': firstName,
        'last_name': lastName,
        'display_name': displayName,
      };
    } catch (e, stackTrace) {
      debugPrint('Google Sign-In Error: $e\n$stackTrace');

      return null;
    }
  }
}
