import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/all_widgets.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';
import 'package:learnsql/config/config.dart';

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

  Future<void> _handleLogin() async {
    if (_formEntKey.currentState != null &&
        _formEntKey.currentState!.validate()) {
      final data = {
        'username': _loginController.text,
        'password': _passwordController.text,
      };
      try {
        final accessToken = await ref.read(accessTokenLocalDataProvider.future);
        final savedAccessToken = await accessToken.getAccessToken();
        ref.read(accessTokenProvider.notifier).state = savedAccessToken;

        await ref.read(enterProvider(data).future);
        Navigator.pushReplacementNamed(context, '/allCoursesFirst');
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AuthSnackBar(
              message: 'Неправильный логин или пароль.',
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
    ref.read(loginEntProvider.notifier).state = false;
    ref.read(passwordEntProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    final loginFilled = ref.watch(loginEntProvider);
    final passwordFilled = ref.watch(passwordEntProvider);
    final allFieldsFilled = loginFilled && passwordFilled;

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
          key: _formEntKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),
              Center(
                child: CustomTextFormField(
                  controller: _loginController,
                  hintText: 'Логин',
                  onChanged: (value) {
                    ref.read(loginEntProvider.notifier).state =
                        value.isNotEmpty;
                  },
                  isFilled: loginFilled,
                ),
              ),
              const SizedBox(height: 17),
              Center(
                child: CustomTextFormField(
                  controller: _passwordController,
                  hintText: 'Пароль',
                  obscureText: true,
                  onChanged: (value) {
                    ref.read(passwordEntProvider.notifier).state =
                        value.isNotEmpty;
                  },
                  isFilled: passwordFilled,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgetPassword');
                },
                child: Text('Забыли пароль?', style: textStyle.displaySmall),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 27),
                child: AuthButton(
                  isFilled: allFieldsFilled,
                  text: 'Войти',
                  onPressed: allFieldsFilled ? _handleLogin : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: ElevatedButton(
                  onPressed: () async {
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
            ],
          ),
        ),
      ),
    );
  }
}
