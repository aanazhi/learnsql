import 'package:flutter/material.dart';

import '../../../config/config.dart';

class Cources extends StatelessWidget {
  const Cources({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        Text('Курсы', style: textStyle.displayLarge),
        SizedBox(height: 25),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.inActiveColor, width: 2),
          ),
          height: 76,
          width: 340,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 23, 0, 0),
            child: Text(
              'Оператор SELECT',
              style: textStyle.titleLarge?.copyWith(fontSize: 23),
            ),
          ),
        ),
        SizedBox(height: 25),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.inActiveColor, width: 2),
          ),
          height: 76,
          width: 340,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 23, 8, 0),
            child: Text(
              'Data Manipulation Language',
              style: textStyle.titleLarge?.copyWith(fontSize: 23),
            ),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
