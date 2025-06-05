import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/theme/app_theme.dart';
import 'package:learnsql/courses/presentation/pages/pages/materials_pages/one_theme_screen.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';

class ListOfThemesScreen extends ConsumerWidget {
  final int themeId;
  const ListOfThemesScreen({super.key, required this.themeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final themeNumber = ref.watch(courseIdProvider);
    final materialsAsync = ref.watch(materialsProvider(themeNumber));

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: SizedBox(
          width: 170,
          height: 35,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.backgroundColor,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: AppColors.inActiveColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: AppColors.activeColor,
                  size: 24,
                ),
                Text(
                  'К списку тем',
                  style: textStyle.bodyMedium?.copyWith(
                    color: AppColors.activeColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: materialsAsync.when(
        data: (materialsEntity) {
          final section = materialsEntity.sections.firstWhere(
            (section) => section.id == themeId,
          );

          print('section - ${section.topicsOfThisSection.first.topicName}');

          final topics = section.topicsOfThisSection;

          if (topics.isEmpty) {
            return Center(
              child: Text(
                'В этом разделе пока нет тем',
                style: textStyle.titleMedium?.copyWith(
                  color: AppColors.checkColor,
                ),
              ),
            );
          }

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
                          children: List.generate(topics.length, (index) {
                            final topic = topics[index];
                            final isLast = index == topics.length - 1;

                            String displayText = topic.topicName.trim();
                            if (displayText.isNotEmpty &&
                                !displayText.endsWith('.')) {
                              displayText += '.';
                            }
                            return Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => OneThemeScreen(
                                                    themeId: topic.id,
                                                  ),
                                            ),
                                          );

                                          if (kDebugMode) {
                                            print(
                                              'Selected topic: ${topic.topicName}',
                                            );
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
      ),
    );
  }
}
