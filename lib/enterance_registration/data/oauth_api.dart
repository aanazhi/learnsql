import 'package:url_launcher/url_launcher.dart';
import 'package:learnsql/config/config.dart';

abstract class OauthApi {
  Future<void> signInWithGoogle();
}

class OauthApiImpl implements OauthApi {
  @override
  Future<void> signInWithGoogle() async {
    final authorizationUrl = Uri.parse(
      '${AppConstants.authorizationEndpoint}?client_id=${AppConstants.clientIdGoogle}&redirect_uri=${Uri.encodeComponent(AppConstants.redirectUri)}&response_type=token&scope=${Uri.encodeComponent(AppConstants.scope)}',
    );

    print('Authorization URL: $authorizationUrl');

    if (await canLaunchUrl(authorizationUrl)) {
      await launchUrl(authorizationUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Не удалось запустить URL: $authorizationUrl';
    }
  }
}
