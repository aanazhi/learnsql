import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

abstract class ErrorLocalDataSource {
  Future<void> setErrorLocal(Map<String, dynamic> errorLocal);
  Future<Map<String, dynamic>?> getError();
  Future<void> clearError();
}

class ErrorLocalDataSourceImpl implements ErrorLocalDataSource {
  static const _cashKey = 'registration_error';

  final SharedPreferences _sharedPreferences;
  final Talker _talker;

  ErrorLocalDataSourceImpl({
    required SharedPreferences sharedPreferences,
    required Talker talker,
  }) : _sharedPreferences = sharedPreferences,
       _talker = talker;

  @override
  Future<Map<String, dynamic>?> getError() async {
    try {
      final errorJson = _sharedPreferences.getString(_cashKey);

      _talker.log('🔑 Retrieved registration error from local storage');

      if (errorJson != null) {
        return json.decode(errorJson) as Map<String, dynamic>;
      }

      return null;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to get registration error', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> setErrorLocal(Map<String, dynamic> errorLocal) async {
    try {
      await _sharedPreferences.setString(_cashKey, jsonEncode(errorLocal));

      _talker.log('💾 Saved registration error to local storage');
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to save registration error', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> clearError() async {
    try {
      await _sharedPreferences.remove(_cashKey);

      _talker.log('💾 Remove registration error to local storage');
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to remove registration error', e, stackTrace);
      rethrow;
    }
  }
}
