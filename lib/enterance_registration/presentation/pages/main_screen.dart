import 'package:flutter/material.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/cources.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/studying.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/why_sql.dart';

import '../../../config/config.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Container(
          padding: EdgeInsets.fromLTRB(0, 100, 0, 70),
          child: Image.asset('assets/images/logo.png', height: 57, width: 207),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            Text('Мобильное приложение', style: textStyle.displayMedium),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('для изучения SQL', style: textStyle.displayMedium),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Text('Курсы для тренировки', style: textStyle.titleLarge),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Text('умений написания', style: textStyle.titleLarge),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                child: Text('SQL-запросов', style: textStyle.titleLarge),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 33),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/registrationAll');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.inActiveColor,
                  minimumSize: const Size(294, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: Text(
                  'Зарегистрироваться',
                  style: textStyle.titleLarge?.copyWith(
                    color: AppColors.activeColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 27),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/enterance');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.inActiveColor,
                  minimumSize: const Size(294, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),
                child: Text(
                  'Войти',
                  style: textStyle.titleLarge?.copyWith(
                    color: AppColors.activeColor,
                  ),
                ),
              ),
            ),
            WhySql(),
            Studying(),
            Cources(),
          ],
        ),
      ),
    );
  }
}
