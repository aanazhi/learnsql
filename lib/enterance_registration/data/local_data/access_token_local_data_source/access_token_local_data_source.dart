import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

abstract class AccessTokenLocalDataSource {
  Future<void> setAccessToken(String accessToken);
  Future<String?> getAccessToken();
  Future<void> clearAccessToken();
}

class AccessTokenLocalDataSourceImpl implements AccessTokenLocalDataSource {
  static const _cashKey = 'access_token';

  final SharedPreferences _sharedPreferences;
  final Talker _talker;

  AccessTokenLocalDataSourceImpl({
    required SharedPreferences sharedPreferences,
    required Talker talker,
  }) : _sharedPreferences = sharedPreferences,
       _talker = talker;

  @override
  Future<String?> getAccessToken() async {
    try {
      final token = _sharedPreferences.getString(_cashKey);

      _talker.log('🔑 Retrieved access token from local storage: $token');

      return token;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to get access token', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> setAccessToken(String accessToken) async {
    try {
      await _sharedPreferences.setString(_cashKey, accessToken);

      _talker.log('💾 Saved access token to local storage');
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to set access token', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> clearAccessToken() async {
    try {
      _sharedPreferences.remove(_cashKey);

      _talker.log('🔑 Clear access token from local storage');
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to clear access token', e, stackTrace);
      rethrow;
    }
  }
}
