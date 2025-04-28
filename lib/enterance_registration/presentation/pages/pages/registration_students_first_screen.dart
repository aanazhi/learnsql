import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/all_widgets.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';
import 'package:learnsql/config/config.dart';

class RegistrationStudentsFirstScreen extends ConsumerStatefulWidget {
  const RegistrationStudentsFirstScreen({super.key});

  @override
  ConsumerState<RegistrationStudentsFirstScreen> createState() =>
      _RegistrationStudentsFirstScreenState();
}

class _RegistrationStudentsFirstScreenState
    extends ConsumerState<RegistrationStudentsFirstScreen> {
  String? selectedOrg;
  String? selectedPeriod;

  final _formRegStudKey = GlobalKey<FormState>();

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    final orgData = ref.watch(dropdownOrgProvider);
    final perData = ref.watch(dropdownPeriodProvider);

    final orgFilled = ref.watch(organizationProvider);
    final periodFilled = ref.watch(periodProvider);

    final allFieldsFilled = orgFilled && periodFilled;

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
          key: _formRegStudKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 180),
              Center(
                child: CustomDropdownAuth<String>(
                  hintText: 'Организация',
                  itemsData: orgData,
                  value: selectedOrg,
                  onChanged: (newValue) {
                    ref.read(selectedOrgProvider.notifier).state =
                        newValue ?? '';
                    ref.read(organizationProvider.notifier).state =
                        newValue?.isNotEmpty ?? false;
                  },
                  isFilled: orgFilled,
                ),
              ),
              const SizedBox(height: 21),
              Center(
                child: CustomDropdownAuth<String>(
                  hintText: 'Период обучения',
                  itemsData: perData,
                  value: selectedPeriod,
                  onChanged: (newValue) {
                    ref.read(selectedPeriodProvider.notifier).state =
                        newValue ?? '';
                    ref.read(periodProvider.notifier).state =
                        newValue?.isNotEmpty ?? false;
                  },
                  isFilled: periodFilled,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 36),
                child: AuthButton(
                  isFilled: allFieldsFilled,
                  text: 'Далее',
                  onPressed:
                      allFieldsFilled
                          ? () {
                            ref.refresh(dropdownGroupProvider);
                            Navigator.pushNamed(
                              context,
                              '/registrationSecondStudent',
                            );
                          }
                          : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
