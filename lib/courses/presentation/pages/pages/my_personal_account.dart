import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/domain/groups/group_entity/group_entity.dart';
import 'package:learnsql/courses/presentation/widgets/all_widgets.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/all_widgets.dart';

class MyPersonalAccountScreen extends ConsumerStatefulWidget {
  const MyPersonalAccountScreen({super.key});

  @override
  ConsumerState<MyPersonalAccountScreen> createState() =>
      _MyPersonalAccountScreenState();
}

class _MyPersonalAccountScreenState
    extends ConsumerState<MyPersonalAccountScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _groupController = TextEditingController();
  final _formAccKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _firstNameController.addListener(_checkChanges);
    _lastNameController.addListener(_checkChanges);
  }

  Future<void> _initializeControllers() async {
    try {
      final personalData = await ref.read(getPersonalDataProvider.future);
      final groupData = await ref.read(getGroupsProvider.future);

      if (!mounted) return;

      setState(() {
        _usernameController.text = personalData.username;
        _emailController.text = personalData.email;
        _firstNameController.text = personalData.firstName;
        _lastNameController.text = personalData.lastName;

        ref.read(initialFirstNameProvider.notifier).state =
            personalData.firstName;
        ref.read(initialLastNameProvider.notifier).state =
            personalData.lastName;
        ref.read(initialGroupIdProvider.notifier).state =
            personalData.groupNumber;

        if (personalData.groupNumber != null) {
          ref.read(selectedGroupInAccountProvider.notifier).state =
              personalData.groupNumber;
          _updateGroupController(personalData.groupNumber, groupData);
        } else {
          _groupController.text = 'Группа не выбрана';
        }
      });
    } catch (e) {
      debugPrint('Ошибка инициализации: $e');
    }
  }

  void _updateGroupController(int? groupNumber, GroupEntity groupData) {
    if (groupNumber != null) {
      try {
        final group = groupData.results.firstWhere(
          (g) => g.id == groupNumber,
          orElse:
              () => ListGroupEntity(
                id: groupNumber,
                title: 'Группа $groupNumber',
                period: '',
                organization: '',
              ),
        );
        _groupController.text =
            group.period.isNotEmpty
                ? '${group.title} ${group.period}'
                : group.title;
      } catch (e) {
        _groupController.text = 'Группа $groupNumber';
      }
    } else {
      _groupController.text = 'Группа не выбрана';
    }
  }

  @override
  void dispose() {
    _firstNameController.removeListener(_checkChanges);
    _lastNameController.removeListener(_checkChanges);
    _usernameController.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _groupController.dispose();
    super.dispose();
  }

  void _checkChanges() {
    if (!mounted) return;

    final selectedId = ref.read(selectedGroupInAccountProvider);
    final initialFirstName = ref.read(initialFirstNameProvider);
    final initialLastName = ref.read(initialLastNameProvider);
    final initialGroupId = ref.read(initialGroupIdProvider);

    final hasChanges =
        (_firstNameController.text.trim() != initialFirstName?.trim()) ||
        (_lastNameController.text.trim() != initialLastName?.trim()) ||
        (selectedId != initialGroupId);

    ref.read(personalChangesProvider.notifier).state = hasChanges;
  }

  Future<void> _saveChanges() async {
    if (!ref.read(isEditPersonalAccount) ||
        ref.read(patchPersonalLoadingProvider)) {
      return;
    }

    final scaffold = ScaffoldMessenger.of(context);
    scaffold.hideCurrentSnackBar();
    ref.read(patchPersonalLoadingProvider.notifier).state = true;

    try {
      final updateData = <String, dynamic>{};
      final initialFirstName = ref.read(initialFirstNameProvider);
      final initialLastName = ref.read(initialLastNameProvider);
      final initialGroupId = ref.read(initialGroupIdProvider);

      if (_firstNameController.text.trim() != initialFirstName?.trim()) {
        updateData['first_name'] = _firstNameController.text.trim();
      }
      if (_lastNameController.text.trim() != initialLastName?.trim()) {
        updateData['last_name'] = _lastNameController.text.trim();
      }

      final selectedGroup = ref.read(selectedGroupInAccountProvider);
      if (selectedGroup != initialGroupId) {
        updateData['group_number'] = selectedGroup;
      }

      if (updateData.isEmpty) {
        scaffold.showSnackBar(
          const SnackBar(content: Text('Нет изменений для сохранения')),
        );
        return;
      }

      await ref.read(patchPersonalProvider(updateData).future);

      ref.invalidate(getPersonalDataProvider);
      ref.invalidate(getGroupsProvider);
      final freshData = await ref.read(getPersonalDataProvider.future);
      final freshGroups = await ref.read(getGroupsProvider.future);

      if (!mounted) return;

      setState(() {
        _updateGroupController(freshData.groupNumber, freshGroups);
        ref.read(initialFirstNameProvider.notifier).state = freshData.firstName;
        ref.read(initialLastNameProvider.notifier).state = freshData.lastName;
        ref.read(initialGroupIdProvider.notifier).state = freshData.groupNumber;
      });

      scaffold.showSnackBar(
        const SnackBar(
          content: AuthSnackBar(
            message: 'Данные успешно изменены.',
            iconColor: AppColors.backgroundColor,
            icon: Icons.check_circle_rounded,
          ),
          backgroundColor: AppColors.greenColor,
        ),
      );
    } catch (e) {
      scaffold.showSnackBar(
        SnackBar(
          content: AuthSnackBar(
            message:
                e.toString().contains('Server error')
                    ? 'Ошибка сервера: попробуйте позже'
                    : 'Ошибка: ${e.toString()}',
            iconColor: AppColors.backgroundColor,
            icon: Icons.error_outline_rounded,
          ),
          backgroundColor: AppColors.googleColor,
        ),
      );
    } finally {
      if (mounted) {
        ref.read(patchPersonalLoadingProvider.notifier).state = false;
        ref.read(isEditPersonalAccount.notifier).state = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final isEdit = ref.watch(isEditPersonalAccount);
    final hasChanges = ref.watch(personalChangesProvider);
    final isLoading = ref.watch(patchPersonalLoadingProvider);
    final selectedGroupId = ref.watch(selectedGroupInAccountProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(showPicture: false),
      body: ref
          .watch(getPersonalDataProvider)
          .when(
            data:
                (personalData) => ref
                    .watch(getGroupsProvider)
                    .when(
                      data: (groupData) {
                        if (ref.read(initialFirstNameProvider) == null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _updateGroupController(
                              personalData.groupNumber,
                              groupData,
                            );
                            ref.read(initialFirstNameProvider.notifier).state =
                                personalData.firstName;
                            ref.read(initialLastNameProvider.notifier).state =
                                personalData.lastName;
                            ref.read(initialGroupIdProvider.notifier).state =
                                personalData.groupNumber;
                          });
                        }

                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(27, 59, 27, 70),
                            child: Column(
                              children: [
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.inActiveColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Form(
                                    key: _formAccKey,
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                            0,
                                            9,
                                            10,
                                            5,
                                          ),
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            onPressed:
                                                isLoading
                                                    ? null
                                                    : () {
                                                      ref
                                                          .read(
                                                            isEditPersonalAccount
                                                                .notifier,
                                                          )
                                                          .state = !isEdit;
                                                      if (!isEdit) {
                                                        _firstNameController
                                                            .text = ref.read(
                                                              initialFirstNameProvider,
                                                            ) ??
                                                            '';
                                                        _lastNameController
                                                            .text = ref.read(
                                                              initialLastNameProvider,
                                                            ) ??
                                                            '';
                                                        ref
                                                            .read(
                                                              selectedGroupInAccountProvider
                                                                  .notifier,
                                                            )
                                                            .state = ref.read(
                                                          initialGroupIdProvider,
                                                        );
                                                        _checkChanges();
                                                      }
                                                    },
                                            icon: Icon(
                                              Icons.edit_rounded,
                                              color:
                                                  isEdit
                                                      ? AppColors.activeColor
                                                      : AppColors
                                                          .withOpacityColor,
                                            ),
                                            iconSize: 26,
                                          ),
                                        ),
                                        CustomTextFieldPersonalAccount(
                                          controller: _usernameController,
                                          text: 'Логин',
                                          isFilled: false,
                                          isEdit: false,
                                          hasFocus: false,
                                          onChanged: (_) {},
                                        ),
                                        CustomTextFieldPersonalAccount(
                                          controller: _emailController,
                                          text: 'Email',
                                          isFilled: false,
                                          isEdit: false,
                                          hasFocus: false,
                                          onChanged: (_) {},
                                        ),
                                        CustomTextFieldPersonalAccount(
                                          controller: _firstNameController,
                                          text: 'Имя',
                                          onChanged: (_) => _checkChanges(),
                                          isFilled: false,
                                          isEdit: isEdit,
                                          hasFocus:
                                              isEdit &&
                                              _firstNameController.text !=
                                                  ref.read(
                                                    initialFirstNameProvider,
                                                  ),
                                        ),
                                        CustomTextFieldPersonalAccount(
                                          controller: _lastNameController,
                                          text: 'Фамилия',
                                          onChanged: (_) => _checkChanges(),
                                          isFilled: false,
                                          isEdit: isEdit,
                                          hasFocus:
                                              isEdit &&
                                              _lastNameController.text !=
                                                  ref.read(
                                                    initialLastNameProvider,
                                                  ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            33,
                                            0,
                                            33,
                                            24,
                                          ),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Номер группы',
                                                  style: textStyle.titleMedium
                                                      ?.copyWith(fontSize: 18),
                                                ),
                                              ),
                                              if (!isEdit) ...[
                                                const SizedBox(height: 12),
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: _buildGroupInfo(
                                                    groupData,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                const Divider(
                                                  height: 1,
                                                  thickness: 1,
                                                  color:
                                                      AppColors.inActiveColor,
                                                ),
                                              ],
                                              if (isEdit)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 8.0,
                                                      ),
                                                  child: DropdownButtonFormField<
                                                    int?
                                                  >(
                                                    isExpanded: true,
                                                    dropdownColor:
                                                        AppColors
                                                            .backgroundColor,
                                                    value: selectedGroupId,
                                                    items:
                                                        groupData.results
                                                            .map(
                                                              (
                                                                group,
                                                              ) => DropdownMenuItem(
                                                                value: group.id,
                                                                child: Text(
                                                                  '${group.title} ${group.period}',
                                                                  style: textStyle
                                                                      .bodyLarge
                                                                      ?.copyWith(
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                ),
                                                              ),
                                                            )
                                                            .toList(),
                                                    onChanged: (newValue) {
                                                      ref
                                                          .read(
                                                            selectedGroupInAccountProvider
                                                                .notifier,
                                                          )
                                                          .state = newValue;
                                                      _checkChanges();
                                                    },
                                                    decoration: const InputDecoration(
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                                  AppColors
                                                                      .activeColor,
                                                              width: 2,
                                                            ),
                                                          ),
                                                      focusedBorder:
                                                          UnderlineInputBorder(
                                                            borderSide: BorderSide(
                                                              color:
                                                                  AppColors
                                                                      .activeColor,
                                                              width: 2,
                                                            ),
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                            0,
                                            0,
                                            0,
                                            30,
                                          ),
                                          child: ElevatedButton(
                                            onPressed:
                                                (hasChanges &&
                                                        isEdit &&
                                                        !isLoading)
                                                    ? _saveChanges
                                                    : null,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  (hasChanges &&
                                                          isEdit &&
                                                          !isLoading)
                                                      ? AppColors.activeColor
                                                      : AppColors.inActiveColor,
                                              minimumSize: const Size(270, 46),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            child:
                                                isLoading
                                                    ? const CircularProgressIndicator(
                                                      color: Colors.white,
                                                    )
                                                    : Text(
                                                      'Изменить',
                                                      style:
                                                          (hasChanges && isEdit)
                                                              ? textStyle
                                                                  .titleMedium
                                                                  ?.copyWith(
                                                                    color:
                                                                        AppColors
                                                                            .backgroundColor,
                                                                  )
                                                              : textStyle
                                                                  .titleMedium,
                                                    ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: const EdgeInsets.only(
                                            left: 33,
                                          ),
                                          child: TextButton(
                                            onPressed: () {},
                                            child: Text(
                                              'Изменить пароль',
                                              style: textStyle.displaySmall,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (context.mounted) {
                                        Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/mainPage',
                                          (Route<dynamic> route) => false,
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.activeColor,
                                      minimumSize: const Size(270, 46),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: Text(
                                      'Выйти',
                                      style: textStyle.titleMedium?.copyWith(
                                        color: AppColors.backgroundColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      error:
                          (error, _) => Center(
                            child: Text('Ошибка загрузки групп: $error'),
                          ),
                      loading:
                          () => const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.activeColor,
                            ),
                          ),
                    ),
            error:
                (error, _) =>
                    Center(child: Text('Ошибка загрузки данных: $error')),
            loading:
                () => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.activeColor,
                  ),
                ),
          ),
    );
  }

  Widget _buildGroupInfo(GroupEntity groupData) {
    final textStyle = Theme.of(context).textTheme;
    final groupNumber = ref.watch(selectedGroupInAccountProvider);

    if (groupNumber == null) {
      return Text(
        'Группа не выбрана',
        style: textStyle.titleMedium?.copyWith(fontSize: 18),
      );
    }

    try {
      final group = groupData.results.firstWhere(
        (g) => g.id == groupNumber,
        orElse:
            () => ListGroupEntity(
              id: groupNumber,
              title: 'Группа $groupNumber',
              period: '',
              organization: '',
            ),
      );

      return Text(
        group.period.isNotEmpty
            ? '${group.title} ${group.period}'
            : group.title,
        style: textStyle.titleMedium?.copyWith(fontSize: 18),
      );
    } catch (e) {
      return Text(
        'Группа $groupNumber',
        style: textStyle.titleMedium?.copyWith(fontSize: 18),
      );
    }
  }
}
