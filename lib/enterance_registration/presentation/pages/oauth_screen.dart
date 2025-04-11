import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../config/config.dart';

class OAuthScreen extends ConsumerWidget {
  const OAuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final WebViewController controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onNavigationRequest: (NavigationRequest request) {
                if (request.url.startsWith(AppConstants.redirectUri)) {
                  final uri = Uri.parse(request.url);
                  final token =
                      uri.fragment
                          .split('&')
                          .firstWhere(
                            (param) => param.startsWith('access_token'),
                          )
                          .split('=')[1];


                  ref.read(accessTokenProvider.notifier).state = token;

                  print('Access Token: $token');

                  Navigator.pushReplacementNamed(context, '/allCoursesFirst');
                }
                return NavigationDecision.navigate;
              },
            ),
          )
          ..loadRequest(
            Uri.parse(
              '${AppConstants.authorizationEndpoint}?client_id=${AppConstants.clientIdGoogle}&redirect_uri=${Uri.encodeComponent(AppConstants.redirectUri)}&response_type=token&scope=${Uri.encodeComponent(AppConstants.scope)}',
            ),
          );

    return Scaffold(
      appBar: AppBar(title: const Text('Вход через Google')),
      body: WebViewWidget(controller: controller),
    );
  }
}
