import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';

import '../../../config/config.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  ConsumerState<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  final _loginController = TextEditingController();

  final _formResetPasswordKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final resetPasswordFilled = ref.watch(resetPasswordFieldProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: AppColors.activeColor),
            iconSize: 30,
            onPressed: () {
              Navigator.pop(context);

              ref.read(resetPasswordFieldProvider.notifier).state = false;
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formResetPasswordKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 210),
              Center(
                child: SizedBox(
                  width: 340,
                  height: 55,
                  child: TextFormField(
                    controller: _loginController,
                    decoration: InputDecoration(
                      hintText: 'Логин',
                      hintStyle: textStyle.titleMedium,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.inActiveColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.activeColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      ref.read(resetPasswordFieldProvider.notifier).state =
                          value.isNotEmpty;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: ElevatedButton(
                  onPressed:
                      resetPasswordFilled
                          ? () async {
                            if (_formResetPasswordKey.currentState != null &&
                                _formResetPasswordKey.currentState!
                                    .validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.error_outline_rounded,
                                        size: 21,
                                        color: AppColors.backgroundColor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Произошла ошибка, уже работаем над этим!',
                                        style: textStyle.labelMedium,
                                      ),
                                    ],
                                  ),
                                  backgroundColor: AppColors.googleColor,
                                ),
                              );
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/mainPage',
                                (Route<dynamic> route) => false,
                              );

                              ref
                                  .read(resetPasswordFieldProvider.notifier)
                                  .state = false;
                              ref.read(loginEntProvider.notifier).state = false;
                              ref.read(passwordEntProvider.notifier).state =
                                  false;
                            }
                          }
                          : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        resetPasswordFilled
                            ? AppColors.activeColor
                            : AppColors.backgroundColor,
                    minimumSize: const Size(311, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side: BorderSide(
                        color:
                            resetPasswordFilled
                                ? AppColors.activeColor
                                : AppColors.backgroundColor,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    'Восстановить пароль',
                    style: textStyle.titleMedium?.copyWith(
                      color:
                          resetPasswordFilled
                              ? AppColors.backgroundColor
                              : AppColors.withOpacityColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
