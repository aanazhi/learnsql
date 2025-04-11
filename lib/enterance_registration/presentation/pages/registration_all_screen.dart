import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';

import '../../../config/config.dart';

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

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    final loginFilled = ref.watch(loginRegAllProvider);
    final emailFilled = ref.watch(emailRegAllProvider);
    final nameFilled = ref.watch(nameRegAllProvider);
    final surnameFilled = ref.watch(surnameRegAllProvider);
    final passwordFilled = ref.watch(passwordRegAllProvider);

    bool allFieldsFilled =
        loginFilled &&
        emailFilled &&
        nameFilled &&
        surnameFilled &&
        passwordFilled;

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

              ref.read(loginRegAllProvider.notifier).state = false;
              ref.read(emailRegAllProvider.notifier).state = false;
              ref.read(nameRegAllProvider.notifier).state = false;
              ref.read(surnameRegAllProvider.notifier).state = false;
              ref.read(passwordRegAllProvider.notifier).state = false;
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formRegAllKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              Center(
                child: SizedBox(
                  width: 340,
                  height: 55,
                  child: TextFormField(
                    cursorColor: AppColors.activeColor,
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
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.activeColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      ref.read(loginRegAllProvider.notifier).state =
                          value.isNotEmpty;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                    'Пожалуйста, введите логин',
                                    style: textStyle.labelMedium,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.googleColor,
                            ),
                          );
                        });
                      }
                      if (value!.length > 150) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                    'Логин не более 150 символов',
                                    style: textStyle.labelMedium,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.googleColor,
                            ),
                          );
                        });
                      }
                      final validCharacters = RegExp(r'^[a-zA-Z0-9@./+/-/_]+$');
                      if (!validCharacters.hasMatch(value)) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                    'Допустимы буквы, цифры и @/./+/-/_',
                                    style: textStyle.labelMedium,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.googleColor,
                            ),
                          );
                        });
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 21),
              Center(
                child: SizedBox(
                  width: 340,
                  height: 55,
                  child: TextFormField(
                    cursorColor: AppColors.activeColor,
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: textStyle.titleMedium,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              emailFilled
                                  ? AppColors.activeColor
                                  : AppColors.withOpacityColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.activeColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      ref.read(emailRegAllProvider.notifier).state =
                          value.isNotEmpty;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                    'Пожалуйста, введите email',
                                    style: textStyle.labelMedium,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.googleColor,
                            ),
                          );
                        });
                      }
                      if (!EmailValidator.validate(value!)) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                    'Некорректный email',
                                    style: textStyle.labelMedium,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.googleColor,
                            ),
                          );
                        });
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 21),
              Center(
                child: SizedBox(
                  width: 340,
                  height: 55,
                  child: TextFormField(
                    cursorColor: AppColors.activeColor,
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Имя',
                      hintStyle: textStyle.titleMedium,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              nameFilled
                                  ? AppColors.activeColor
                                  : AppColors.withOpacityColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.activeColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      ref.read(nameRegAllProvider.notifier).state =
                          value.isNotEmpty;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                    'Пожалуйста, введите имя',
                                    style: textStyle.labelMedium,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.googleColor,
                            ),
                          );
                        });
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 21),
              Center(
                child: SizedBox(
                  width: 340,
                  height: 55,
                  child: TextFormField(
                    cursorColor: AppColors.activeColor,
                    controller: _surnameController,
                    decoration: InputDecoration(
                      hintText: 'Фамилия',
                      hintStyle: textStyle.titleMedium,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color:
                              surnameFilled
                                  ? AppColors.activeColor
                                  : AppColors.withOpacityColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.activeColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      ref.read(surnameRegAllProvider.notifier).state =
                          value.isNotEmpty;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                    'Пожалуйста, введите фамилию',
                                    style: textStyle.labelMedium,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.googleColor,
                            ),
                          );
                        });
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(height: 21),
              Center(
                child: SizedBox(
                  width: 340,
                  height: 55,
                  child: TextFormField(
                    cursorColor: AppColors.activeColor,
                    controller: _passwordController,
                    obscureText: true,
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
                      contentPadding: EdgeInsets.all(10),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.activeColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      ref.read(passwordRegAllProvider.notifier).state =
                          value.isNotEmpty;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                    'Пожалуйста, введите пароль',
                                    style: textStyle.labelMedium,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.googleColor,
                            ),
                          );
                        });
                      }
                      if (value!.length < 6) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
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
                                    'Пароль не меньше 6 символов',
                                    style: textStyle.labelMedium,
                                  ),
                                ],
                              ),
                              backgroundColor: AppColors.googleColor,
                            ),
                          );
                        });
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 27),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/registrationStudent');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    minimumSize: const Size(311, 54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                      side: BorderSide(color: AppColors.activeColor, width: 2),
                    ),
                  ),
                  child: Text(
                    'Я студент',
                    style: textStyle.titleMedium?.copyWith(
                      color: AppColors.activeColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: ElevatedButton(
                  onPressed:
                      allFieldsFilled
                          ? () async {
                            if (_formRegAllKey.currentState!.validate()) {
                              final data = {
                                'username': _loginController.text,
                                'email': _emailController.text,
                                'first_name': _nameController.text,
                                'last_name': _surnameController.text,
                                'password': _passwordController.text,
                              };

                              try {
                                await ref.read(
                                  registerAllProvider(data).future,
                                );

                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_rounded,
                                          size: 22,
                                          color: AppColors.backgroundColor,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Вы успешно зарегистрированы',
                                          style: textStyle.labelMedium,
                                        ),
                                      ],
                                    ),
                                    backgroundColor: AppColors.activeColor,
                                  ),
                                );

                                if (kDebugMode) {
                                  print('Registration successful');
                                }
                              } catch (error, stackTrace) {
                                if (kDebugMode) {
                                  print(
                                    'Registration failed: $error, $stackTrace',
                                  );
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.error_outline_rounded,
                                          size: 20,
                                          color: AppColors.backgroundColor,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          'Пользователь с таким именем уже существует',
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
                    'Зарегистрироваться',
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
