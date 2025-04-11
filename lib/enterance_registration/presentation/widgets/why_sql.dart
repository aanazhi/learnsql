import 'package:flutter/material.dart';
import '../../../config/config.dart';

class WhySql extends StatelessWidget {
  const WhySql({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        SizedBox(height: 59),
        Center(
          child: Image.asset(
            'assets/images/db_picture.png',
            height: 119,
            width: 120,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Почему именно SQL?',
            style: textStyle.displayMedium?.copyWith(
              color: AppColors.textMediumColor,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.checkColor,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 8,
              width: 140,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: Text('Большинство современных', style: textStyle.bodyLarge),
        ),
        Text(
          'сервисов и приложений имеют',
          style: textStyle.bodyLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
        Text(
          'системы хранения данных.',
          style: textStyle.bodyLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
        Text(
          'Во многих из них используются',
          style: textStyle.bodyLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
        Text(
          'реляционные системы управления',
          style: textStyle.bodyLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
        Text(
          'БД, для которых SQL – это ',
          style: textStyle.bodyLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
        Text(
          'базовый язык для работы с',
          style: textStyle.bodyLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
        Text(
          'данными.',
          style: textStyle.bodyLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
        SizedBox(height: 34),
        Center(
          child: Image.asset(
            'assets/images/db_picture_2.png',
            height: 119,
            width: 120,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Зачем изучать базы',
            style: textStyle.displayMedium?.copyWith(
              color: AppColors.textMediumColor,
            ),
          ),
        ),
        Text(
          'данных?',
          style: textStyle.displayMedium?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.starColor,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 8,
              width: 140,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
          child: Text(
            'Умение работать с базами данных',
            style: textStyle.bodyLarge?.copyWith(
              color: AppColors.textMediumColor,
            ),
          ),
        ),
        Text(
          '– это один из ключевых навыков',
          style: textStyle.bodyLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
        Text(
          'любого backend-разработчика и',
          style: textStyle.bodyLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
        Text(
          'аналитика данных.',
          style: textStyle.bodyLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
      ],
    );
  }
}
