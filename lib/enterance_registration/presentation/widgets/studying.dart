import 'package:flutter/material.dart';

import '../../../config/config.dart';

class Studying extends StatelessWidget {
  const Studying({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        SizedBox(height: 40),
        Text('Вы научитесь', style: textStyle.displayLarge),
        SizedBox(height: 25),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.inActiveColor, width: 2),
          ),
          height: 119,
          width: 340,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 25, 15, 0),
            child: Text(
              'Понимать принципы составления запросов к базам данных.',
              style: textStyle.labelLarge?.copyWith(
                color: AppColors.textMediumColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 25),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.inActiveColor, width: 2),
          ),
          height: 119,
          width: 340,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 25, 15, 0),
            child: Text(
              'Составлять SQL запросы на выборку данных (select).',
              style: textStyle.labelLarge?.copyWith(
                color: AppColors.textMediumColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 25),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.inActiveColor, width: 2),
          ),
          height: 119,
          width: 340,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(17, 25, 15, 0),
            child: Text(
              'Составлять SQL запросы на изменение данных (insert, update, delete).',
              style: textStyle.labelLarge?.copyWith(
                color: AppColors.textMediumColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 70),
      ],
    );
  }
}
