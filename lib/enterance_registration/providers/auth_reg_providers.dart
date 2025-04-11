import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/constants/app_constants.dart';
import 'package:learnsql/enterance_registration/data/auth_reg_api.dart';
import 'package:learnsql/enterance_registration/data/oauth_api.dart';
import 'package:learnsql/enterance_registration/domain/auth_reg_service.dart';
import 'package:learnsql/enterance_registration/domain/oath_service.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 5),
      headers: {
        'Content-Type': AppConstants.headers,
        'Accept': AppConstants.headers,
      },
    ),
  );
});

final authRegApiProvider = Provider<AuthRegApi>((ref) {
  final dio = ref.read(dioProvider);
  return AuthRegApiImpl(dio: dio);
});

final authRegServiceProvider = Provider<AuthRegService>((ref) {
  final authRegApi = ref.read(authRegApiProvider);
  return AuthRegServiceImpl(authRegApi: authRegApi);
});

final registerAllProvider = FutureProvider.family<dynamic, Map<String, String>>(
  (ref, data) async {
    final authService = ref.read(authRegApiProvider);
    final username = data['username'] ?? '';
    final email = data['email'] ?? '';
    final firstName = data['first_name'] ?? '';
    final lastName = data['last_name'] ?? '';
    final password = data['password'] ?? '';

    return await authService.register(
      username,
      email,
      firstName,
      lastName,
      password,
    );
  },
);

final enterProvider = FutureProvider.family<dynamic, Map<String, String>>((
  ref,
  data,
) async {
  final authService = ref.read(authRegApiProvider);
  final username = data['username'] ?? '';
  final password = data['password'] ?? '';

  return await authService.logIn(username, password);
});

final loginRegAllProvider = StateProvider<bool>((ref) => false);
final emailRegAllProvider = StateProvider<bool>((ref) => false);
final nameRegAllProvider = StateProvider<bool>((ref) => false);
final surnameRegAllProvider = StateProvider<bool>((ref) => false);
final passwordRegAllProvider = StateProvider<bool>((ref) => false);

final loginEntProvider = StateProvider<bool>((ref) => false);
final passwordEntProvider = StateProvider<bool>((ref) => false);

final dropdownOrgProvider = FutureProvider<List<String>>((ref) async {
  final authService = ref.read(authRegApiProvider);

  return await authService.getOrganization();
});

final selectedOrgProvider = StateProvider<String>((ref) => '');

final dropdownPeriodProvider = FutureProvider<List<String>>((ref) async {
  final authService = ref.read(authRegApiProvider);

  return await authService.getPeriod();
});

final selectedPeriodProvider = StateProvider<String>((ref) => '');

final dropdownGroupProvider = FutureProvider<List<String>>((ref) async {
  final authService = ref.read(authRegApiProvider);
  final university = ref.read(selectedOrgProvider);
  final period = ref.read(selectedPeriodProvider);

  try {
    final response = await authService.getGroup(university, period);
    return response;
  } catch (error) {
    rethrow;
  }
});

final selecteGroupProvider = StateProvider<String>((ref) => '');

final organizationProvider = StateProvider<bool>((ref) => false);
final periodProvider = StateProvider<bool>((ref) => false);

final groupProvider = StateProvider<bool>((ref) => false);
final numberProvider = StateProvider<bool>((ref) => false);

final selecteNumberProvider = StateProvider<String>((ref) => '');

final oauthApiProvider = Provider<OauthApi>((ref) => OauthApiImpl());

final oauthServiceProvider = Provider<OauthService>((ref) {
  final oauthApi = ref.read(oauthApiProvider);
  return OauthServiceImpl(oauthApi: oauthApi);
});

final accessTokenProvider = StateProvider<String?>((ref) => null);

final resetPasswordProvider = FutureProvider<dynamic>((ref) async {
  final authService = ref.read(authRegApiProvider);

  return await authService.resetPassword();
});

final resetPasswordFieldProvider = StateProvider<bool>((ref) => false);
