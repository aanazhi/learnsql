import '../data/oauth_api.dart';

abstract class OauthService {
  Future<void> signInWithGoogle();
}

class OauthServiceImpl implements OauthService {
  final OauthApi _oauthApi;

  OauthServiceImpl({required OauthApi oauthApi}) : _oauthApi = oauthApi;
  @override
  Future<void> signInWithGoogle() async {
    await _oauthApi.signInWithGoogle();
  }
}
