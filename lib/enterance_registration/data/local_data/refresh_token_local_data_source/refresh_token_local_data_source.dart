import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker/talker.dart';

abstract class RefreshTokenLocalDataSource {
  Future<void> setRefreshToken(String refreshToken);
  Future<String?> getRefreshToken();
}

class RefreshTokenLocalDataSourceImpl implements RefreshTokenLocalDataSource {
  static const _cashKey = 'refresh_token';

  final SharedPreferences _sharedPreferences;
  final Talker _talker;

  RefreshTokenLocalDataSourceImpl({
    required SharedPreferences sharedPreferences,
    required Talker talker,
  }) : _sharedPreferences = sharedPreferences,
       _talker = talker;

  @override
  Future<String?> getRefreshToken() async {
    try {
      final token = _sharedPreferences.getString(_cashKey);

      _talker.log('🔑 Retrieved refresh token from local storage: $token');

      return token;
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to get refresh token', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> setRefreshToken(String refreshToken) async {
    try {
      await _sharedPreferences.setString(_cashKey, refreshToken);

      _talker.log('💾 Saved refresh token to local storage');
    } catch (e, stackTrace) {
      _talker.error('❌ Failed to set refresh token', e, stackTrace);
      rethrow;
    }
  }
}
