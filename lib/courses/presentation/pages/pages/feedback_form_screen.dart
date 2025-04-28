import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/presentation/widgets/all_widgets.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/all_widgets.dart';

class FeedbackFormScreen extends ConsumerStatefulWidget {
  const FeedbackFormScreen({super.key});

  @override
  ConsumerState<FeedbackFormScreen> createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends ConsumerState<FeedbackFormScreen> {
  final _themeController = TextEditingController();
  final _messageController = TextEditingController();

  final _formFbKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _themeController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleFB() async {
    FocusScope.of(context).unfocus();

    if (_formFbKey.currentState != null &&
        _formFbKey.currentState!.validate()) {
      final data = {
        'subject': _themeController.text,
        'message': _messageController.text,
      };
      try {
        await ref.read(addFeedbackProvider(data).future);
        _clearFormField();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AuthSnackBar(
              message: 'Ваше сообщение успешно отправлено!',
              iconColor: AppColors.backgroundColor,
              icon: Icons.check_circle_rounded,
            ),
            backgroundColor: AppColors.greenColor,
          ),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AuthSnackBar(
              message: 'Произошла ошибка, уже работаем над этим!',
              iconColor: AppColors.backgroundColor,
              icon: Icons.error_outline_rounded,
            ),
            backgroundColor: AppColors.googleColor,
          ),
        );
      }
    }
  }

  void _resetAllProviders() {
    ref.read(themeFbProvider.notifier).state = false;
    ref.read(messageFbProvider.notifier).state = false;
  }

  void _clearFormField() {
    _themeController.clear();
    _messageController.clear();
    _resetAllProviders();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final widthButt = size.width * 0.6;

    final themeFilled = ref.watch(themeFbProvider);
    final messageFilled = ref.watch(messageFbProvider);
    final allFieldsFilled = themeFilled && messageFilled;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(27, 59, 27, 70),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.inActiveColor, width: 2),
            ),
            child: Column(
              children: [
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    'Форма обратной связи',
                    style: textStyle.bodyMedium?.copyWith(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(33, 34, 28, 33),
                  child: Text(
                    'Для улучшения качества сервиса, вы можете отправить нам пожелания, рекомендации, которые мы обязательно рассмотрим. Спасибо!',
                    style: textStyle.bodySmall?.copyWith(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Form(
                  key: _formFbKey,
                  child: Column(
                    children: [
                      Center(
                        child: CustomTextFormField(
                          width: widthButt,
                          height: 57,
                          controller: _themeController,
                          hintText: 'Тема',
                          isFilled: themeFilled,
                          onChanged: (value) {
                            ref.read(themeFbProvider.notifier).state =
                                value.isNotEmpty;
                          },
                        ),
                      ),
                      const SizedBox(height: 34),
                      Center(
                        child: CustomTextFormField(
                          width: widthButt,
                          height: widthButt,
                          maxLines: 7,
                          controller: _messageController,
                          hintText: 'Текст сообщения',
                          isFilled: messageFilled,
                          onChanged: (value) {
                            ref.read(messageFbProvider.notifier).state =
                                value.isNotEmpty;
                          },
                        ),
                      ),
                      const SizedBox(height: 19),
                      Center(
                        child: AuthButton(
                          width: widthButt,
                          height: 55,
                          isFilled: allFieldsFilled,
                          text: 'Отправить',
                          onPressed: allFieldsFilled ? _handleFB : null,
                        ),
                      ),
                      const SizedBox(height: 19),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
