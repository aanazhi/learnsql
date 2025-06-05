import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/presentation/pages/pages/full_screen_image_screen.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';

class DbInfoScreen extends ConsumerWidget {
  final int taskId;
  const DbInfoScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final taskAsync = ref.watch(oneTaskProvider(taskId));

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: SizedBox(
          width: 130,
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
                  'К заданию',
                  style: textStyle.bodyMedium?.copyWith(
                    color: AppColors.activeColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: taskAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Ошибка: $error')),
        data: (task) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(32, 15, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Описание базы данных',
                    style: textStyle.bodyLarge?.copyWith(
                      color: AppColors.checkColor,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _buildHtmlContent(task.databaseDescription!, textStyle),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (_) =>
                                FullScreenImage(imageUrl: task.databaseImage!),
                      ),
                    );
                  },
                  child: Image.network(
                    task.databaseImage!,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHtmlContent(String html, TextTheme textStyle) {
    final cleanedHtml = html
        .replaceAll('&nbsp;', ' ')
        .replaceAll('\r', '')
        .replaceAll('\t', '    ');

    final lines = cleanedHtml.split('\n');
    final widgets = <Widget>[];

    for (var line in lines) {
      if (line.trim().isEmpty) continue;

      if (line.contains('<h4>Таблицы базы данных:</h4>')) {
        widgets.add(
          Text(
            'Таблицы базы данных:',
            style: textStyle.titleSmall?.copyWith(color: AppColors.blackColor),
          ),
        );
        continue;
      }

      if (line.contains('<strong>') && line.contains('Таблица содержит') ||
          line.contains('Таблица отражает')) {
        final text = line.replaceAll(RegExp(r'<[^>]*>'), '').trim();

        final splitIndex = text.indexOf(' ');
        final firstWord =
            splitIndex == -1 ? text : text.substring(0, splitIndex);
        final restText = splitIndex == -1 ? '' : text.substring(splitIndex + 1);

        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: firstWord,
                    style: textStyle.labelLarge?.copyWith(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: restText.isNotEmpty ? ' $restText' : '',
                    style: textStyle.labelLarge?.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        continue;
      }

      if (line.contains('<li>')) {
        final text = line.replaceAll(RegExp(r'<[^>]*>'), '').trim();
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              '• $text',
              style: textStyle.labelLarge?.copyWith(
                color: AppColors.blackColor,
              ),
            ),
          ),
        );
      } else {
        final text = line.replaceAll(RegExp(r'<[^>]*>'), '').trim();
        if (text.isNotEmpty && !text.startsWith('<')) {
          widgets.add(
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                text,
                style: textStyle.labelLarge?.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
            ),
          );
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
