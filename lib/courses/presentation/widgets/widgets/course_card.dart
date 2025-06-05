import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';

class CourseCard extends ConsumerWidget {
  final int id;
  final String title;
  final String title2;
  final int difficulty;
  final List<String> themes;
  final bool isJoined;
  final VoidCallback onJoinPressed;
  const CourseCard({
    super.key,
    required this.id,
    required this.title,
    required this.title2,
    required this.difficulty,
    required this.themes,
    required this.isJoined,
    required this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.inActiveColor, width: 2.0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(12, 22, 16, 18),
                alignment: Alignment.centerLeft,
                child: Text(title, style: textStyle.bodyLarge),
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 7, 23),
                    child: Text(
                      'Сложность курса:',
                      style: textStyle.bodyMedium,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 4, 23),
                        child: Icon(
                          Icons.star,
                          color:
                              index < difficulty
                                  ? AppColors.starColor
                                  : AppColors.greyColor,
                        ),
                      );
                    }),
                  ),
                ],
              ),

              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 5, 0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Выбор заданий в курсе:',
                        style: textStyle.bodyMedium,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(12, 0, 5, 23),
                    alignment: Alignment.centerLeft,
                    child: Text(title2, style: textStyle.bodySmall),
                  ),

                  if (themes.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 0, 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Темы курса:', style: textStyle.bodyMedium),
                          const SizedBox(height: 5),
                          ...themes.map(
                            (theme) => Padding(
                              padding: const EdgeInsets.fromLTRB(6, 0, 6, 5),
                              child: Text(theme, style: textStyle.labelSmall),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 9, 0, 10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.activeColor,
                        minimumSize: const Size(180, 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      onPressed:
                          isJoined
                              ? () {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pushNamed(
                                  '/tasks',
                                  arguments: {'courseId': id},
                                );
                              }
                              : onJoinPressed,
                      child:
                          isJoined
                              ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'НА СТРАНИЦУ КУРСА',
                                    style: textStyle.labelMedium,
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: AppColors.backgroundColor,
                                  ),
                                ],
                              )
                              : Text(
                                'ПРИСОЕДИНИТЬСЯ',
                                style: textStyle.labelMedium,
                              ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
