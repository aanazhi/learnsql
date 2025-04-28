import 'package:flutter/material.dart';
import 'package:learnsql/config/config.dart';

class Cources extends StatelessWidget {
  const Cources({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        Text('Курсы', style: textStyle.displayLarge),
        const SizedBox(height: 25),
        const CorcesOnCources(text: 'Оператор SELECT'),
        const SizedBox(height: 25),
        const CorcesOnCources(text: 'Data Manipulation Language'),
        const SizedBox(height: 50),
      ],
    );
  }
}

class CorcesOnCources extends StatelessWidget {
  final String text;
  const CorcesOnCources({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.inActiveColor, width: 2),
      ),
      height: 76,
      width: 340,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 23, 0, 0),
        child: Text(text, style: textStyle.titleLarge?.copyWith(fontSize: 23)),
      ),
    );
  }
}
