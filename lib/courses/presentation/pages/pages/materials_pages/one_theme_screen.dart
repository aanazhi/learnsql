import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/presentation/pages/pages/materials_pages/one_material_widget.dart';
import 'package:learnsql/courses/presentation/pages/pages/materials_pages/parser_content.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';

class OneThemeScreen extends ConsumerWidget {
  final int themeId;

  const OneThemeScreen({super.key, required this.themeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsyncValue = ref.watch(themesProvider(themeId));
    final textStyle = Theme.of(context).textTheme;

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
                  'Ко всем темам',
                  style: textStyle.bodyMedium?.copyWith(
                    color: AppColors.activeColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: themeAsyncValue.when(
        data: (theme) {
          final parsedData = parseContent(theme.content);

          return SingleChildScrollView(
            child: OneMaterialWidget(
              text1: theme.topicName,
              textWithNames: parsedData.textWithNames,
              urlTexts: parsedData.urlTexts,
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Ошибка загрузки: $error')),
      ),
    );
  }
}
