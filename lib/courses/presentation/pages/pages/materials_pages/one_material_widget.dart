import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:url_launcher/url_launcher.dart';

class OneMaterialWidget extends ConsumerWidget {
  final String text1;
  final List<String> textWithNames;
  final List<String> urlTexts;

  const OneMaterialWidget({
    super.key,
    required this.text1,
    required this.textWithNames,
    required this.urlTexts,
  });

  String _ensureHttp(String url) {
    if (url.isEmpty) return url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      return 'https://$url';
    }
    return url;
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      final processedUrl = _ensureHttp(url.trim());
      final parsedUrl = Uri.parse(processedUrl);

      debugPrint('Пытаемся открыть URL: $parsedUrl');

      await launchUrl(parsedUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Ошибка при открытии ссылки: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Не удалось открыть ссылку: ${e.toString()}'),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(38, 38, 54, 34),
          child: Text(
            text1,
            style: textStyle.titleLarge?.copyWith(color: AppColors.checkColor),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(38, 0, 0, 28),
          alignment: Alignment.centerLeft,
          child: Text(
            'Полезные ссылки:',
            style: textStyle.bodySmall?.copyWith(fontSize: 18),
          ),
        ),
        ...List.generate(textWithNames.length, (index) {
          return Container(
            padding: const EdgeInsets.fromLTRB(38, 0, 54, 28),
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${textWithNames[index]}\n',
                    style: textStyle.bodySmall?.copyWith(fontSize: 18),
                  ),
                  TextSpan(
                    text: urlTexts[index],
                    style: textStyle.labelLarge?.copyWith(
                      color: AppColors.activeColor,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.activeColor,
                    ),
                    recognizer:
                        TapGestureRecognizer()
                          ..onTap = () => _launchURL(context, urlTexts[index]),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

