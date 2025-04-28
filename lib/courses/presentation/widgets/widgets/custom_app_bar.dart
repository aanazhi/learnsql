import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool showButton;
  final bool showPicture;
  final TabController? controller;

  const CustomAppBar({
    super.key,
    this.showButton = false,
    this.controller,
    this.showPicture = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.activeColor,
      title:
          showPicture
              ? Image.asset('assets/images/logo_2.png', width: 200, height: 59)
              : IconButton(
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: AppColors.backgroundColor,
                ),
                iconSize: 30,
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(isEditPersonalAccount.notifier).state = false;
                },
              ),
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/myPersonalAccount');
            },
            icon: const Icon(
              size: 35,
              Icons.account_circle_sharp,
              color: AppColors.backgroundColor,
            ),
          ),
        ),
      ],
      bottom:
          showButton
              ? PreferredSize(
                preferredSize: const Size.fromHeight(48),
                child: Container(
                  color: AppColors.backgroundColor,
                  child: Stack(
                    children: [
                      TabBar(
                        controller: controller,
                        tabs: const [
                          Tab(text: 'Все курсы'),
                          Tab(text: 'Мои курсы'),
                        ],
                        indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide(
                            color: AppColors.activeColor,
                            width: 3,
                          ),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: AppColors.activeColor,
                        labelStyle: textStyle.titleSmall?.copyWith(
                          fontSize: 20,
                        ),
                        unselectedLabelColor: AppColors.withOpacityColor,
                        unselectedLabelStyle: textStyle.titleMedium,
                      ),
                      Positioned.fill(
                        child: Align(
                          child: Container(
                            width: 2,
                            height: 30,
                            color: AppColors.inActiveColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              : null,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight + (controller != null ? 48 : 0));
  }
}
