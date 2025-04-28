import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/presentation/pages/all_pages.dart';
import 'package:learnsql/enterance_registration/presentation/pages/all_pages.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = Talker();

  final container = ProviderContainer(
    overrides: [talkerProvider.overrideWithValue(talker)],
  );
  final dio = container.read(dioProvider)
    ..interceptors.add(TalkerDioInterceptor(talker: talker));

  final overrides = [
    talkerProvider.overrideWithValue(talker),
    dioProvider.overrideWithValue(dio),
  ];

  FlutterError.onError = (details) {
    talker.handle(details.exception, details.stack);
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    talker.handle(error, stackTrace);
    return true;
  };

  runApp(ProviderScope(overrides: overrides, child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      navigatorObservers: [
        NavigatorLogger(
          talker: ProviderScope.containerOf(context).read(talkerProvider),
        ),
      ],
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/mainPage',
      routes: {
        '/mainPage': (context) => const MainScreen(),
        '/enterance': (context) => const EnteranceScreen(),
        '/registrationAll': (context) => const RegistrationAllScreen(),
        '/registrationStudent':
            (context) => const RegistrationStudentsFirstScreen(),
        '/registrationSecondStudent':
            (context) => const RegistrationStudentsSecondScreen(),
        '/forgetPassword': (context) => const ForgetPasswordScreen(),
        '/allCoursesFirst': (context) => const MainOnPaScreen(),
        '/logs':
            (context) => TalkerScreen(
              talker: ProviderScope.containerOf(context).read(talkerProvider),
            ),
        '/myPersonalAccount': (context) => const MyPersonalAccountScreen(),
      },
      builder: (context, child) {
        return Material(
          child: Overlay(
            initialEntries: [
              OverlayEntry(
                builder:
                    (context) => Scaffold(
                      body: Stack(
                        children: [
                          child ?? const SizedBox(),
                          if (kDebugMode) const DraggableDebugButton(),
                        ],
                      ),
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
