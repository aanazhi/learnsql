import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';

import 'package:learnsql/courses/providers/courses_providers.dart';

class ListOfMaterialsScreen extends ConsumerWidget {
  final int courseId;
  const ListOfMaterialsScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final materialsAsync = ref.watch(materialsProvider(courseId));
    ref.read(courseIdProvider.notifier).state = courseId;

    return materialsAsync.when(
      data: (materialsEntity) {
        final sectionsName = materialsEntity.sections;

        return SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 24),
                  width: 345,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: AppColors.inActiveColor,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(sectionsName.length, (index) {
                          final section = sectionsName[index].sectionName;
                          final isLast = index == sectionsName.length - 1;

                          String displayText = section.trim();
                          if (displayText.isNotEmpty &&
                              !displayText.endsWith('.')) {
                            displayText += '.';
                          }
                          return Column(
                            children: [
                              SizedBox(
                                height: 200,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          '/themes',
                                          arguments: {
                                            'themeId': sectionsName[index].id,
                                          },
                                        );
                                        if (kDebugMode) {
                                          print(
                                            'themeId: ${sectionsName[index].id}',
                                          );
                                          print('materials: $section');
                                        }
                                      },
                                      child: Text(
                                        displayText,
                                        style: textStyle.titleSmall?.copyWith(
                                          color: AppColors.checkColor,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (!isLast)
                                const Divider(
                                  thickness: 2,
                                  color: AppColors.inActiveColor,
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
      error:
          (error, _) => Center(
            child: Text(
              'Произошла ошибка, уже работаем над этим!',
              style: textStyle.labelMedium,
            ),
          ),
      loading:
          () => const Center(
            child: CircularProgressIndicator(color: AppColors.activeColor),
          ),
    );
  }
}
