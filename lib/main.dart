import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/cources/presentation/all_courses_screen.dart';
import 'package:learnsql/enterance_registration/presentation/pages/forget_password_screen.dart';
import 'package:learnsql/enterance_registration/presentation/pages/oauth_screen.dart';
import 'package:learnsql/enterance_registration/presentation/pages/registration_students_second_screen.dart';

import 'enterance_registration/presentation/pages/enterance_screen.dart';
import 'enterance_registration/presentation/pages/main_screen.dart';
import 'enterance_registration/presentation/pages/registration_all_screen.dart';
import 'enterance_registration/presentation/pages/registration_students_first_screen.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      initialRoute: '/mainPage',
      routes: {
        '/mainPage': (context) => MainScreen(),
        '/enterance': (context) => EnteranceScreen(),
        '/registrationAll': (context) => RegistrationAllScreen(),
        '/registrationStudent': (context) => RegistrationStudentsFirstScreen(),
        '/registrationSecondStudent':
            (context) => RegistrationStudentsSecondScreen(),
        '/forgetPassword': (context) => ForgetPasswordScreen(),
        '/allCoursesFirst': (context) => AllCoursesScreen(),
        '/googleAuth': (context) => OAuthScreen(),
      },
    );
  }
}
