import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/all_widgets.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';
import 'package:learnsql/config/config.dart';

class RegistrationAllScreen extends ConsumerStatefulWidget {
  const RegistrationAllScreen({super.key});

  @override
  ConsumerState<RegistrationAllScreen> createState() =>
      _RegistrationAllScreenState();
}

class _RegistrationAllScreenState extends ConsumerState<RegistrationAllScreen> {
  final _loginController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formRegAllKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _loginController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    if (!_formRegAllKey.currentState!.validate()) {
      return;
    }

    try {
      ref.read(registrationErrorProvider.notifier).state = null;

      final data = {
        'username': _loginController.text,
        'email': _emailController.text,
        'first_name': _nameController.text,
        'last_name': _surnameController.text,
        'password': _passwordController.text,
        'organisation': null,
        'period': null,
        'group_number': null,
        'isu_number': null,
      };

      await ref.read(registerAllProvider(data).future);

      if (context.mounted) {
        Navigator.of(context).pop();

        _resetAllProviders();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AuthSnackBar(
              message: 'Вы успешно зарегистрированы.',
              iconColor: AppColors.backgroundColor,
              icon: Icons.check_circle_rounded,
            ),
            backgroundColor: AppColors.activeColor,
          ),
        );
      }

      if (kDebugMode) {
        print('Registration successful');
      }
    } catch (error, stackTrace) {
      final errorDataSource = await ref.read(errorLocalDataProvider.future);
      final savedError = await errorDataSource.getError();
      ref.read(registrationErrorProvider.notifier).state = savedError;

      if (kDebugMode) {
        print('Registration failed: $error, $stackTrace');
      }
    }
  }

  void _resetAllProviders() {
    ref.read(organizationProvider.notifier).state = false;
    ref.read(periodProvider.notifier).state = false;
    ref.read(groupProvider.notifier).state = false;
    ref.read(numberProvider.notifier).state = false;
    ref.read(isCheckedStudentProvider.notifier).state = false;
    ref.read(loginRegAllProvider.notifier).state = false;
    ref.read(emailRegAllProvider.notifier).state = false;
    ref.read(nameRegAllProvider.notifier).state = false;
    ref.read(surnameRegAllProvider.notifier).state = false;
    ref.read(passwordRegAllProvider.notifier).state = false;
  }

  String? _extractErrorMessage(Map<String, dynamic>? errorData) {
    if (errorData == null) return null;

    if (errorData.containsKey('error')) {
      return errorData['error'].toString();
    }

    for (final entry in errorData.entries) {
      if (entry.value is List && (entry.value as List).isNotEmpty) {
        return (entry.value as List).first.toString();
      }
      if (entry.value is String) {
        return entry.value;
      }
    }
    return 'Произошла ошибка при регистрации';
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final isStudent = ref.watch(isCheckedStudentProvider);

    final loginFilled = ref.watch(loginRegAllProvider);
    final emailFilled = ref.watch(emailRegAllProvider);
    final nameFilled = ref.watch(nameRegAllProvider);
    final surnameFilled = ref.watch(surnameRegAllProvider);
    final passwordFilled = ref.watch(passwordRegAllProvider);

    final allFieldsFilled =
        loginFilled &&
        emailFilled &&
        nameFilled &&
        surnameFilled &&
        passwordFilled;

    ref.listen<Map<String, dynamic>?>(registrationErrorProvider, (
      _,
      errorData,
    ) {
      if (errorData != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AuthSnackBar(
              message: _extractErrorMessage(errorData) ?? 'Ошибка регистрации.',
              iconColor: AppColors.backgroundColor,
              icon: Icons.error_outline_rounded,
            ),
            backgroundColor: AppColors.googleColor,
          ),
        );

        ref.read(registrationErrorProvider.notifier).state = null;
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: BackButtonAppBar(
        onPressed: () {
          Navigator.pop(context);
          _resetAllProviders();
        },
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formRegAllKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 21),
              Center(
                child: CustomTextFormField(
                  controller: _loginController,
                  hintText: 'Логин',
                  isFilled: loginFilled,
                  onChanged: (value) {
                    ref.read(loginRegAllProvider.notifier).state =
                        value.isNotEmpty;
                    ref.read(selectedUsernameProvider.notifier).state = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите логин';
                    }
                    if (value.length > 150) {
                      return 'Логин слишком длинный';
                    }
                    if (value.contains(' ')) {
                      return 'Логин не должен содержать пробелы';
                    }
                    if (value.length < 3) {
                      return 'Логин слишком короткий';
                    }
                    final hasCyrillic = RegExp(r'[а-яА-ЯёЁ]').hasMatch(value);
                    if (hasCyrillic) {
                      return 'Логин не должен содержать русские буквы';
                    }
                    final allowedChars = RegExp(r'^[a-zA-Z0-9!@#]+$');
                    if (!allowedChars.hasMatch(value)) {
                      return 'Разрешены только латинские буквы, цифры и символы !@#';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(height: 21),
              Center(
                child: CustomTextFormField(
                  controller: _emailController,
                  hintText: 'Email',
                  isFilled: emailFilled,
                  onChanged: (value) {
                    ref.read(emailRegAllProvider.notifier).state =
                        value.isNotEmpty;
                    ref.read(selectedEmailProvider.notifier).state = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите email';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Некорректный email';
                    }
                    if (value.contains(' ')) {
                      return 'Email не должен содержать пробелы';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 21),
              Center(
                child: CustomTextFormField(
                  controller: _nameController,
                  hintText: 'Имя',
                  isFilled: nameFilled,
                  onChanged: (value) {
                    ref.read(nameRegAllProvider.notifier).state =
                        value.isNotEmpty;
                    ref.read(selectedFirstNameProvider.notifier).state = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите имя';
                    }
                    if (value.startsWith(' ') || value.endsWith(' ')) {
                      return 'Пробелы в начале/конце недопустимы';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(height: 21),
              Center(
                child: CustomTextFormField(
                  controller: _surnameController,
                  hintText: 'Фамилия',
                  isFilled: surnameFilled,
                  onChanged: (value) {
                    ref.read(surnameRegAllProvider.notifier).state =
                        value.isNotEmpty;
                    ref.read(selectedLastNameProvider.notifier).state = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите фамилию';
                    }
                    if (value.startsWith(' ') || value.endsWith(' ')) {
                      return 'Пробелы в начале/конце недопустимы';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 21),
              Center(
                child: CustomTextFormField(
                  controller: _passwordController,
                  hintText: 'Пароль',
                  obscureText: true,
                  isFilled: passwordFilled,
                  onChanged: (value) {
                    ref.read(passwordRegAllProvider.notifier).state =
                        value.isNotEmpty;
                    ref.read(selectedPasswordProvider.notifier).state = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите пароль';
                    }
                    if (value.length < 6) {
                      return 'Пароль слишком короткий';
                    }
                    if (value.length > 150) {
                      return 'Пароль слишком длинный';
                    }
                    if (!RegExp(r'[!?@#|*:;]').hasMatch(value)) {
                      return 'Добавьте спецсимвол (!?@#|*:;)';
                    }
                    if (!RegExp(r'[0-9]').hasMatch(value)) {
                      return 'Добавьте минимум одну цифру';
                    }
                    if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                      return 'Добавьте минимум одну букву';
                    }
                    if (value.contains(' ')) {
                      return 'Пароль не должен содержать пробелы';
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      focusColor: AppColors.activeColor,
                      checkColor: AppColors.backgroundColor,
                      activeColor: AppColors.activeColor,
                      value: isStudent,
                      onChanged: (value) {
                        ref.read(isCheckedStudentProvider.notifier).state =
                            value ?? false;
                      },
                    ),
                    Text('Я студент', style: textStyle.titleSmall),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: AuthButton(
                  isFilled: (isStudent && allFieldsFilled) || allFieldsFilled,
                  text:
                      (isStudent && allFieldsFilled)
                          ? 'Далее'
                          : 'Зарегистрироваться',
                  onPressed:
                      (isStudent && allFieldsFilled)
                          ? () => Navigator.pushNamed(
                            context,
                            '/registrationStudent',
                          )
                          : allFieldsFilled
                          ? () async {
                            await _handleRegistration();
                          }
                          : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton(
                  onPressed: () async {
                    final authService = await ref.read(
                      authRegServiceProvider.future,
                    );

                    await authService.signInWithGoogle();

                    Navigator.pushReplacementNamed(context, '/allCoursesFirst');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    minimumSize: const Size(311, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side: const BorderSide(
                        color: AppColors.googleColor,
                        width: 2,
                      ),
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
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
