import 'package:flutter/material.dart';
import 'package:learnsql/config/config.dart';

class WhySql extends StatelessWidget {
  const WhySql({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        InfoSection(
          imagePath: 'assets/images/db_picture.png',
          title: 'Почему именно SQL?',
          dividerColor: AppColors.checkColor,
          descriptionLines: [
            'Большинство современных',
            'сервисов и приложений имеют',
            'системы хранения данных.',
            'Во многих из них используются',
            'реляционные системы управления',
            'БД, для которых SQL – это',
            'базовый язык для работы с',
            'данными.',
          ],
        ),
        SizedBox(height: 34),
        InfoSection(
          imagePath: 'assets/images/db_picture_2.png',
          title: 'Зачем изучать базы\nданных?',
          dividerColor: AppColors.starColor,
          descriptionLines: [
            'Умение работать с базами данных',
            '– это один из ключевых навыков',
            'любого backend-разработчика и',
            'аналитика данных.',
          ],
        ),
      ],
    );
  }
}

class InfoSection extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color dividerColor;
  final List<String> descriptionLines;

  const InfoSection({
    super.key,
    required this.imagePath,
    required this.title,
    required this.dividerColor,
    required this.descriptionLines,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 59),
        Center(child: Image.asset(imagePath, height: 119, width: 120)),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            title,
            style: textStyle.displayMedium?.copyWith(
              color: AppColors.textMediumColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: dividerColor,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 8,
              width: 140,
            ),
          ),
        ),
        ...descriptionLines.map(
          (line) => Text(
            line,
            style: textStyle.bodyLarge?.copyWith(
              color: AppColors.textMediumColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class InfoTextBlock extends StatelessWidget {
  final List<String> lines;

  const InfoTextBlock({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children:
          lines
              .map(
                (line) => Text(
                  line,
                  style: textStyle.bodyLarge?.copyWith(
                    color: AppColors.textMediumColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
              .toList(),
    );
  }
}
