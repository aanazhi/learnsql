import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/all_widgets.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';
import 'package:learnsql/config/config.dart';

class RegistrationStudentsSecondScreen extends ConsumerStatefulWidget {
  const RegistrationStudentsSecondScreen({super.key});

  @override
  ConsumerState<RegistrationStudentsSecondScreen> createState() =>
      _RegistrationStudentsSecondScreenState();
}

class _RegistrationStudentsSecondScreenState
    extends ConsumerState<RegistrationStudentsSecondScreen> {
  final _formRegSecStudKey = GlobalKey<FormState>();
  final _tubNumnController = TextEditingController();
  String? selectedGroupNewValue;

  @override
  void dispose() {
    _tubNumnController.dispose();
    super.dispose();
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

  Future<void> _handleRegistration() async {
    if (!_formRegSecStudKey.currentState!.validate()) {
      return;
    }
    final data = {
      'username': ref.read(selectedUsernameProvider),
      'email': ref.read(selectedEmailProvider),
      'first_name': ref.read(selectedFirstNameProvider),
      'last_name': ref.read(selectedLastNameProvider),
      'password': ref.read(selectedPasswordProvider),
      'organisation': ref.read(selectedOrgProvider),
      'period': ref.read(selectedPeriodProvider),
      'group_number': ref.read(selectedGroupProvider),
      'isu_number': ref.read(selectedNumberProvider),
    };

    try {
      await ref.read(registerAllProvider(data).future);

      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/mainPage',
          (Route<dynamic> route) => false,
        );

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

  String? _extractErrorMessage(Map<String, dynamic>? errorData) {
    for (final entry in errorData!.entries) {
      if (entry.value is List && (entry.value as List).isNotEmpty) {
        return (entry.value as List).first.toString();
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final selectedOrg = ref.read(selectedOrgProvider);
    final selectedPeriod = ref.read(selectedPeriodProvider);

    if (kDebugMode) {
      print('SelectedOrg -$selectedOrg');
    }
    if (kDebugMode) {
      print('SelectedPeriod -$selectedPeriod');
    }

    final groupData = ref.watch(dropdownGroupProvider);

    final groupFilled = ref.watch(groupProvider);
    final numberFilled = ref.watch(numberProvider);

    final allFieldsFilled = groupFilled && numberFilled;

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
          key: _formRegSecStudKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 180),
              Center(
                child: CustomDropdownAuth<String>(
                  hintText: 'Группа',
                  itemsData: groupData,
                  onChanged: (newValue) {
                    ref
                        .read(selectedGroupProvider.notifier)
                        .state = int.tryParse(newValue ?? '');
                    ref.read(groupProvider.notifier).state =
                        newValue!.isNotEmpty;
                  },
                  isFilled: groupFilled,
                  displayText: (value) => value.toString(),
                  value: selectedGroupNewValue,
                ),
              ),
              const SizedBox(height: 21),
              Center(
                child: CustomTextFormField(
                  controller: _tubNumnController,
                  hintText: 'Табельный номер',
                  isFilled: numberFilled,
                  onChanged: (newValue) {
                    ref
                        .read(selectedNumberProvider.notifier)
                        .state = int.tryParse(newValue);
                    ref.read(numberProvider.notifier).state =
                        newValue.isNotEmpty;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите табельный номер';
                    }
                    if (value.startsWith(' ') || value.endsWith(' ')) {
                      return 'Пробелы в начале/конце недопустимы';
                    }

                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: AuthButton(
                  isFilled: allFieldsFilled,
                  text: 'Зарегистрироваться',
                  onPressed: allFieldsFilled ? _handleRegistration : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
