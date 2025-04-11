import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';

import '../../../config/config.dart';

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

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final orgData = ref.watch(dropdownOrgProvider);
    final perData = ref.watch(dropdownPeriodProvider);

    final orgFilled = ref.watch(organizationProvider);
    final periodFilled = ref.watch(periodProvider);

    bool allFieldsFilled = orgFilled && periodFilled;

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

              ref.read(organizationProvider.notifier).state = false;
              ref.read(periodProvider.notifier).state = false;
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formRegStudKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 180),
              Center(
                child: SizedBox(
                  width: 340,
                  height: 55,
                  child: orgData.when(
                    data: (data) {
                      return DropdownButtonFormField(
                        dropdownColor: AppColors.inActiveColor,
                        decoration: InputDecoration(
                          hintText: 'Организация',
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
                        items:
                            data.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item, style: textStyle.titleMedium),
                              );
                            }).toList(),
                        value: selectedOrg,
                        onChanged: (String? newValue) {
                          ref.read(selectedOrgProvider.notifier).state =
                              newValue ?? '';
                          ref.read(organizationProvider.notifier).state =
                              newValue!.isNotEmpty;
                        },
                      );
                    },
                    loading: () => SizedBox.shrink(),
                    error: (error, stackTrace) {
                      if (kDebugMode) {
                        print(
                          'Error with dropdown org: $error, stackTrace: $stackTrace',
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
                  child: perData.when(
                    data: (data) {
                      return DropdownButtonFormField(
                        dropdownColor: AppColors.inActiveColor,
                        decoration: InputDecoration(
                          hintText: 'Период обучения',
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
                        items:
                            data.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item, style: textStyle.titleMedium),
                              );
                            }).toList(),
                        value: selectedPeriod,
                        onChanged: (String? newValue) {
                          ref.read(selectedPeriodProvider.notifier).state =
                              newValue ?? '';
                          ref.read(periodProvider.notifier).state =
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
                          'Error with dropdown org: $error, stackTrace: $stackTrace',
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 36),
                child: ElevatedButton(
                  onPressed:
                      allFieldsFilled
                          ? () {
                            // ignore: unused_result
                            ref.refresh(dropdownGroupProvider);

                            Navigator.pushNamed(
                              context,
                              '/registrationSecondStudent',
                            );
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
                    'Далее',
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
