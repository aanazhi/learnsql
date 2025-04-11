import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';

import '../../../config/config.dart';

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
  String? selectedGroup;

  @override
  void dispose() {
    _tubNumnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final selectedOrg = ref.read(selectedOrgProvider);
    final selectedPeriod = ref.read(selectedPeriodProvider);

    print('SelectedOrg -$selectedOrg');
    print('SelectedPeriod -$selectedPeriod');

    final groupData = ref.watch(dropdownGroupProvider);

    final groupFilled = ref.watch(groupProvider);
    final numberFilled = ref.watch(numberProvider);

    bool allFieldsFilled = groupFilled && numberFilled;

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

              ref.read(groupProvider.notifier).state = false;
              ref.read(numberProvider.notifier).state = false;
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formRegSecStudKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 180),
              Center(
                child: SizedBox(
                  width: 340,
                  height: 55,
                  child: groupData.when(
                    data: (data) {
                      return DropdownButtonFormField(
                        dropdownColor: AppColors.inActiveColor,
                        decoration: InputDecoration(
                          hintText: 'Группа',
                          hintStyle: textStyle.titleSmall,

                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.inActiveColor,
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
                        items:
                            data.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item, style: textStyle.titleMedium),
                              );
                            }).toList(),
                        value: selectedGroup,
                        onChanged: (String? newValue) {
                          ref.read(selecteGroupProvider.notifier).state =
                              newValue ?? '';
                          ref.read(groupProvider.notifier).state =
                              newValue!.isNotEmpty;
                        },
                      );
                    },
                    loading:
                        () => Center(
                          child: CircularProgressIndicator(
                            color: AppColors.activeColor,
                          ),
                        ),
                    error: (error, stackTrace) {
                      if (kDebugMode) {
                        print(
                          'Error with dropdown: $error, stackTrace: $stackTrace',
                        );
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
                    style: textStyle.titleMedium,
                    controller: _tubNumnController,
                    onChanged: (newValue) {
                      ref.read(selecteNumberProvider.notifier).state = newValue;
                      ref.read(numberProvider.notifier).state =
                          newValue.isNotEmpty;
                    },
                    decoration: InputDecoration(
                      hintText: 'Табельный номер',
                      hintStyle: textStyle.titleMedium,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.inActiveColor,
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
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: ElevatedButton(
                  onPressed:
                      allFieldsFilled
                          ? () async {
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

                            ref.read(organizationProvider.notifier).state =
                                false;
                            ref.read(periodProvider.notifier).state = false;

                            ref.read(groupProvider.notifier).state = false;
                            ref.read(numberProvider.notifier).state = false;
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
            ],
          ),
        ),
      ),
    );
  }
}
