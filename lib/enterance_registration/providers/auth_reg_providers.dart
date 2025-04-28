import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/constants/app_constants.dart';

import 'package:learnsql/enterance_registration/data/local_data/access_token_local_data_source/access_token_local_data_source.dart';
import 'package:learnsql/enterance_registration/data/local_data/error_local_data_source/error_local_data_source.dart';
import 'package:learnsql/enterance_registration/data/local_data/refresh_token_local_data_source/refresh_token_local_data_source.dart';
import 'package:learnsql/enterance_registration/data/remote_data/auth_reg/auth_reg_api.dart';
import 'package:learnsql/enterance_registration/domain/auth_reg/auth_reg_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

// Core Providers
final talkerProvider = Provider<Talker>((ref) {
  throw UnimplementedError('Talker should be overridden in main()');
});

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': AppConstants.headers,
        'Accept': AppConstants.headers,
      },
    ),
  );
});

final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) {
  return SharedPreferences.getInstance();
});

// Data Source Providers
final accessTokenLocalDataProvider = FutureProvider<AccessTokenLocalDataSource>(
  (ref) async {
    final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
    final talker = ref.watch(talkerProvider);

    return AccessTokenLocalDataSourceImpl(
      sharedPreferences: sharedPreferences,
      talker: talker,
    );
  },
);

final errorLocalDataProvider = FutureProvider<ErrorLocalDataSource>((
  ref,
) async {
  final sharedPreferences = await ref.watch(sharedPreferencesProvider.future);
  final talker = ref.watch(talkerProvider);

  return ErrorLocalDataSourceImpl(
    sharedPreferences: sharedPreferences,
    talker: talker,
  );
});

final refreshTokenLocalDataProvider =
    FutureProvider<RefreshTokenLocalDataSource>((ref) async {
      final sharedPreferences = await ref.watch(
        sharedPreferencesProvider.future,
      );
      final talker = ref.watch(talkerProvider);

      return RefreshTokenLocalDataSourceImpl(
        sharedPreferences: sharedPreferences,
        talker: talker,
      );
    });

// API Service Providers
final authRegApiProvider = FutureProvider<AuthRegApi>((ref) async {
  final dio = ref.read(dioProvider);
  final accessTokenLocalDataSource = await ref.watch(
    accessTokenLocalDataProvider.future,
  );
  final refreshTokenLocalDataSource = await ref.watch(
    refreshTokenLocalDataProvider.future,
  );
  final talker = ref.watch(talkerProvider);
  final errorLocalDataSource = await ref.watch(errorLocalDataProvider.future);

  return AuthRegApiImpl(
    dio: dio,
    accessTokenLocalDataSource: accessTokenLocalDataSource,
    refreshTokenLocalDataSource: refreshTokenLocalDataSource,
    errorLocalDataSource: errorLocalDataSource,
    talker: talker,
  );
});

final authRegServiceProvider = FutureProvider<AuthRegService>((ref) async {
  final authRegApi = await ref.read(authRegApiProvider.future);
  return AuthRegServiceImpl(authRegApi: authRegApi);
});

// Auth Operation Providers
final registerAllProvider =
    FutureProvider.family<dynamic, Map<String, dynamic>>((ref, data) async {
      final authService = await ref.watch(authRegApiProvider.future);
      return authService.register(
        username: data['username'] ?? '',
        email: data['email'] ?? '',
        name: data['first_name'] ?? '',
        surname: data['last_name'] ?? '',
        password: data['password'] ?? '',
        organisation: data['organisation'],
        period: data['period'],
        groupNumber: data['group_number'] as int?,
        isuNumber: data['isu_number'] as int?,
      );
    });

final enterProvider = FutureProvider.family<dynamic, Map<String, String>>((
  ref,
  data,
) async {
  final authService = await ref.watch(authRegApiProvider.future);
  final username = data['username'] ?? '';
  final password = data['password'] ?? '';

  return await authService.logIn(username: username, password: password);
});

final resetPasswordProvider = FutureProvider<dynamic>((ref) async {
  final authService = await ref.watch(authRegApiProvider.future);

  return await authService.resetPassword();
});

// UI State Providers
// Registration Fields
final loginRegAllProvider = StateProvider<bool>((ref) => false);
final emailRegAllProvider = StateProvider<bool>((ref) => false);
final nameRegAllProvider = StateProvider<bool>((ref) => false);
final surnameRegAllProvider = StateProvider<bool>((ref) => false);
final passwordRegAllProvider = StateProvider<bool>((ref) => false);

// Login Fields
final loginEntProvider = StateProvider<bool>((ref) => false);
final passwordEntProvider = StateProvider<bool>((ref) => false);

// Dropdown Data Providers
final dropdownOrgProvider = FutureProvider<List<String>>((ref) async {
  final authService = await ref.watch(authRegApiProvider.future);

  return await authService.getOrganization();
});

final dropdownPeriodProvider = FutureProvider<List<String>>((ref) async {
  final authService = await ref.watch(authRegApiProvider.future);

  return await authService.getPeriod();
});

final dropdownGroupProvider = FutureProvider<List<String>>((ref) async {
  final authService = await ref.watch(authRegApiProvider.future);
  final university = ref.read(selectedOrgProvider);
  final period = ref.read(selectedPeriodProvider);

  return authService.getGroup(university: university, period: period);
});

// Selected Values Providers
final selectedUsernameProvider = StateProvider<String>((ref) => '');
final selectedEmailProvider = StateProvider<String>((ref) => '');
final selectedFirstNameProvider = StateProvider<String>((ref) => '');
final selectedLastNameProvider = StateProvider<String>((ref) => '');
final selectedPasswordProvider = StateProvider<String>((ref) => '');
final selectedOrgProvider = StateProvider<String>((ref) => '');
final selectedPeriodProvider = StateProvider<String>((ref) => '');
final selectedGroupProvider = StateProvider<int?>((ref) => null);
final selectedNumberProvider = StateProvider<int?>((ref) => null);

// Validation State Providers
final organizationProvider = StateProvider<bool>((ref) => false);
final periodProvider = StateProvider<bool>((ref) => false);
final groupProvider = StateProvider<bool>((ref) => false);
final numberProvider = StateProvider<bool>((ref) => false);
final resetPasswordFieldProvider = StateProvider<bool>((ref) => false);

// Token and Local Providers
final accessTokenProvider = StateProvider<String?>((ref) => null);
final googleTokenProvider = StateProvider<String?>((ref) => null);
final registrationErrorProvider = StateProvider<Map<String, dynamic>?>(
  (ref) => null,
);

// Check Providers
final isCheckedStudentProvider = StateProvider<bool>((ref) => false);

// Debug Providers
final debugDraggableProvider = StateProvider<Offset>((ref) {
  return const Offset(30, 30);
});
