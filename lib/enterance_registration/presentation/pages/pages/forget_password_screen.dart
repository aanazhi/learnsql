import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/all_widgets.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';
import 'package:learnsql/config/config.dart';

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

  Future<void> _recoverPassword() async {
    if (_formResetPasswordKey.currentState != null &&
        _formResetPasswordKey.currentState!.validate()) {
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
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/mainPage',
        (Route<dynamic> route) => false,
      );

      ref.read(resetPasswordFieldProvider.notifier).state = false;
      ref.read(loginEntProvider.notifier).state = false;
      ref.read(passwordEntProvider.notifier).state = false;
    }
  }

  void _resetAllProviders() {
    ref.read(resetPasswordFieldProvider.notifier).state = false;
  }

  @override
  Widget build(BuildContext context) {
    final resetPasswordFilled = ref.watch(resetPasswordFieldProvider);

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
          key: _formResetPasswordKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 210),
              Center(
                child: CustomTextFormField(
                  controller: _loginController,
                  hintText: 'Логин',
                  onChanged: (value) {
                    ref.read(resetPasswordFieldProvider.notifier).state =
                        value.isNotEmpty;
                  },
                  isFilled: resetPasswordFilled,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: AuthButton(
                  isFilled: resetPasswordFilled,
                  text: 'Восстановить пароль',
                  onPressed: resetPasswordFilled ? _recoverPassword : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
