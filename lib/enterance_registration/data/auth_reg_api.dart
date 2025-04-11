import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:learnsql/config/config.dart';

abstract class AuthRegApi {
  Future<dynamic> register(
    String username,
    String email,
    String name,
    String surname,
    String password,
  );
  Future<dynamic> logIn(String username, String password);
  Future<dynamic> resetPassword();
  Future<List<String>> getOrganization();
  Future<List<String>> getPeriod();
  Future<List<String>> getGroup(String university, String group);
}

class AuthRegApiImpl implements AuthRegApi {
  final Dio _dio;

  AuthRegApiImpl({required Dio dio}) : _dio = dio;

  @override
  Future<dynamic> register(
    String username,
    String email,
    String name,
    String surname,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        'auth/users/',
        data: {
          'username': username,
          'email': email,
          'first_name': name,
          'last_name': surname,
          'password': password,
        },
      );
      return response.data;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<dynamic> logIn(String username, String password) async {
    try {
      final response = await _dio.post(
        'social_auth_v2/token/',
        data: {
          'password': password,
          'username': username,
          'grant_type': 'password',
          'client_id': AppConstants.clientId,
          'client_secret': AppConstants.clientSecret,
        },
      );
      if (kDebugMode) {
        print('Response data: ${response.data}');
      }

      return response.data['access_token'];
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getOrganization() async {
    try {
      final response = await _dio.get(
        'api/student-groups/get_choise_values/?field=organization',
      );
      if (kDebugMode) {
        print('Response data: ${response.data}');
      }

      final responseData = response.data;

      final List<dynamic> dataList = jsonDecode(responseData);
      final List<String> orgList =
          dataList.map((item) => item.toString()).toList();

      return orgList;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getPeriod() async {
    try {
      final response = await _dio.get(
        'api/student-groups/get_choise_values/?field=period',
      );
      if (kDebugMode) {
        print('Response data: ${response.data}');
      }

      final responseData = response.data;

      final List<dynamic> dataList = jsonDecode(responseData);
      final List<String> orgList =
          dataList.map((item) => item.toString()).toList();

      return orgList;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getGroup(String university, String group) async {
    try {
      final response = await _dio.get(
        'api/student-groups/?period=$group&organization=$university',
      );

      if (kDebugMode) {
        print('Response data: ${response.data}');
      }

      final responseData = response.data;

      final List<dynamic> dataList = responseData['results'];
      final List<String> orgList =
          dataList.map((item) => item['title'].toString()).toList();

      print('orgList - $orgList');

      return orgList;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<dynamic> resetPassword() async {
    try {
      final response = await _dio.post('auth/users/reset_password/');
      if (kDebugMode) {
        print('Response data: ${response.data}');
      }

      final responseData = response.data;
      final dataList = jsonDecode(responseData);
      return dataList;
    } catch (error) {
      rethrow;
    }
  }
}
