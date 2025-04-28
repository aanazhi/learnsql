import 'package:flutter/material.dart';
import 'package:learnsql/config/config.dart';

class QaCard extends StatelessWidget {
  final String question;
  final String answer;

  const QaCard({super.key, required this.question, required this.answer});
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final widthCont = size.width * 0.8;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 46, 0, 0),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.inActiveColor, width: 2),
          ),
          width: widthCont,
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 11, 11, 11),
                    child: Icon(
                      Icons.help,
                      color: AppColors.activeColor,
                      size: 25,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 11, 11, 11),
                      child: Text(
                        question,
                        style: textStyle.bodySmall?.copyWith(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 2, color: AppColors.inActiveColor),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 13, 15, 26),
                child: Text(answer, style: textStyle.labelLarge),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
