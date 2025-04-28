import 'package:flutter/material.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/all_widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.backgroundColor,
        title: Container(
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 70),
          child: Image.asset('assets/images/logo.png', height: 57, width: 207),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text('Мобильное приложение', style: textStyle.displayMedium),
            TextOnMainPage(
              text: 'для изучения SQL',
              top: 16,
              textStyles: textStyle.displayMedium!,
            ),
            TextOnMainPage(
              text: 'Курсы для тренировки',
              top: 40,
              textStyles: textStyle.titleLarge!,
            ),
            TextOnMainPage(
              text: 'умений написания',
              top: 10,
              textStyles: textStyle.titleLarge!,
            ),
            TextOnMainPage(
              text: 'SQL-запросов',
              top: 10,
              textStyles: textStyle.titleLarge!,
            ),
            ButtonsOnMainPage(
              onPressed: () {
                Navigator.pushNamed(context, '/registrationAll');
              },
              top: 33,
              text: 'Зарегистрироваться',
            ),
            ButtonsOnMainPage(
              onPressed: () {
                Navigator.pushNamed(context, '/enterance');
              },
              top: 27,
              text: 'Войти',
            ),
            const WhySql(),
            const Studying(),
            const Cources(),
          ],
        ),
      ),
    );
  }
}
