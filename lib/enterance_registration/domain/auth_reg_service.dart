import 'package:learnsql/enterance_registration/data/auth_reg_api.dart';

abstract class AuthRegService {
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

class AuthRegServiceImpl implements AuthRegService {
  final AuthRegApi _authRegApi;

  AuthRegServiceImpl({required AuthRegApi authRegApi})
    : _authRegApi = authRegApi;

  @override
  Future register(
    String username,
    String email,
    String name,
    String surname,
    String password,
  ) async {
    return await _authRegApi.register(username, email, name, surname, password);
  }

  @override
  Future<dynamic> logIn(String username, String password) async {
    return await _authRegApi.logIn(username, password);
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
  Future<List<String>> getGroup(String university, String group) async {
    return await _authRegApi.getGroup(university, group);
  }

  @override
  Future<dynamic> resetPassword() async {
    return await _authRegApi.resetPassword();
  }
}
