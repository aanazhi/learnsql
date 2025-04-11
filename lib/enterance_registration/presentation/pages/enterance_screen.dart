import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';

import '../../../config/config.dart';

class EnteranceScreen extends ConsumerStatefulWidget {
  const EnteranceScreen({super.key});

  @override
  ConsumerState<EnteranceScreen> createState() => _EnteranceState();
}

class _EnteranceState extends ConsumerState<EnteranceScreen> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formEntKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    final loginFilled = ref.watch(loginEntProvider);
    final passwordFilled = ref.watch(passwordEntProvider);

    bool allFieldsFilled = loginFilled && passwordFilled;

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

              ref.read(loginEntProvider.notifier).state = false;
              ref.read(passwordEntProvider.notifier).state = false;
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formEntKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150),
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
                          color:
                              loginFilled
                                  ? AppColors.activeColor
                                  : AppColors.withOpacityColor,
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
                      ref.read(loginEntProvider.notifier).state =
                          value.isNotEmpty;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 17),
              Center(
                child: SizedBox(
                  width: 340,
                  height: 55,
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    cursorColor: AppColors.activeColor,
                    decoration: InputDecoration(
                      hintText: 'Пароль',
                      hintStyle: textStyle.titleMedium,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              passwordFilled
                                  ? AppColors.activeColor
                                  : AppColors.withOpacityColor,
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
                      ref.read(passwordEntProvider.notifier).state =
                          value.isNotEmpty;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgetPassword');
                },
                child: Text('Забыли пароль?', style: textStyle.displaySmall),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 27),
                child: ElevatedButton(
                  onPressed:
                      allFieldsFilled
                          ? () async {
                            if (_formEntKey.currentState != null &&
                                _formEntKey.currentState!.validate()) {
                              final data = {
                                'username': _loginController.text,
                                'password': _passwordController.text,
                              };
                              try {
                                await ref.read(enterProvider(data).future);

                                Navigator.pushReplacementNamed(
                                  context,
                                  '/allCoursesFirst',
                                );

                                if (kDebugMode) {
                                  print('Enterance successful');
                                }
                              } catch (error, stackTrace) {
                                if (kDebugMode) {
                                  print(
                                    'Enterance failed: $error, $stackTrace',
                                  );
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.error_outline_rounded,
                                          size: 22,
                                          color: AppColors.backgroundColor,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Неправильный логин или пароль',
                                          style: textStyle.labelMedium,
                                        ),
                                      ],
                                    ),
                                    backgroundColor: AppColors.googleColor,
                                  ),
                                );
                              }
                            }
                          }
                          : null,

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        allFieldsFilled
                            ? AppColors.activeColor
                            : AppColors.backgroundColor,
                    minimumSize: const Size(311, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side: BorderSide(
                        color:
                            allFieldsFilled
                                ? AppColors.activeColor
                                : AppColors.backgroundColor,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    'Войти',
                    style: textStyle.titleMedium?.copyWith(
                      color:
                          allFieldsFilled
                              ? AppColors.backgroundColor
                              : AppColors.withOpacityColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: ElevatedButton(
                  onPressed: () async {
                    await ref.read(oauthServiceProvider).signInWithGoogle();
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, '/allCoursesFirst');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    minimumSize: const Size(311, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side: BorderSide(color: AppColors.googleColor, width: 2),
                    ),
                  ),
                  child: Text(
                    'Войти через аккаунт GOOGLE',
                    style: textStyle.displaySmall?.copyWith(
                      color: AppColors.googleColor,
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
