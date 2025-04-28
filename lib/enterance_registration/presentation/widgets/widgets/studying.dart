import 'package:flutter/material.dart';
import 'package:learnsql/config/config.dart';

class Studying extends StatelessWidget {
  const Studying({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        const SizedBox(height: 40),
        Text('Вы научитесь', style: textStyle.displayLarge),
        const SizedBox(height: 25),
        const StydyingOnStydying(
          text: 'Понимать принципы составления запросов к базам данных.',
        ),
        const SizedBox(height: 25),
        const StydyingOnStydying(
          text: 'Составлять SQL запросы на выборку данных (select).',
        ),
        const SizedBox(height: 25),
        const StydyingOnStydying(
          text:
              'Составлять SQL запросы на изменение данных (insert, update, delete).',
        ),
        const SizedBox(height: 70),
      ],
    );
  }
}

class StydyingOnStydying extends StatelessWidget {
  final String text;
  const StydyingOnStydying({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inActiveColor, width: 2),
      ),
      height: 119,
      width: 340,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(17, 25, 15, 0),
        child: Text(
          text,
          style: textStyle.labelLarge?.copyWith(
            color: AppColors.textMediumColor,
          ),
        ),
      ),
    );
  }
}
