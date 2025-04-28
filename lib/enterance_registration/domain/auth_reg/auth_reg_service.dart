import 'package:learnsql/enterance_registration/data/remote_data/auth_reg/auth_reg_api.dart';
import 'package:learnsql/enterance_registration/domain/auth_reg_entity/response_entity.dart';

abstract class AuthRegService {
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
  Future<ResponseEntity> logIn({
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

class AuthRegServiceImpl implements AuthRegService {
  final AuthRegApi _authRegApi;

  AuthRegServiceImpl({required AuthRegApi authRegApi})
    : _authRegApi = authRegApi;

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
    return await _authRegApi.register(
      username: username,
      email: email,
      name: name,
      surname: surname,
      password: password,
      organisation: organisation,
      period: period,
      groupNumber: groupNumber,
      isuNumber: isuNumber,
    );
  }

  @override
  Future<ResponseEntity> logIn({
    required String username,
    required String password,
  }) async {
    final responseModel = await _authRegApi.logIn(
      username: username,
      password: password,
    );

    return ResponseEntity(
      accessToken: responseModel.accessToken,
      refreshToken: responseModel.refreshToken,
    );
  }

  @override
  Future<List<String>> getOrganization() async {
    return await _authRegApi.getOrganization();
  }

  @override
  Future<List<String>> getPeriod() async {
    return await _authRegApi.getPeriod();
  }

  @override
  Future<List<String>> getGroup({
    required String university,
    required String period,
  }) async {
    return await _authRegApi.getGroup(university: university, period: period);
  }

  @override
  Future<Map<String, dynamic>> resetPassword() async {
    return await _authRegApi.resetPassword();
  }

  @override
  Future<Map<String, String>?> getGoogleAccountData() async {
    return await _authRegApi.getGoogleAccountData();
  }
}
