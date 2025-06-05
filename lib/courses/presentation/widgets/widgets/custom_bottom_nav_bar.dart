import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';

class CustomBottomNavBar extends ConsumerWidget {
  final int activeIndex;
  final bool isRootNavigator;
  final ValueChanged<int>? onTap;

  const CustomBottomNavBar({
    super.key,
    this.isRootNavigator = false,
    required this.activeIndex,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
      iconSize: 26,
      backgroundColor: AppColors.greyColor,
      currentIndex: activeIndex,
      onTap: (newIndex) async {
        if (newIndex != activeIndex) {
          if (isRootNavigator) {
            if (onTap != null) {
              onTap!(newIndex);
            }
          } else {
            final navigator = Navigator.of(context, rootNavigator: true);

            navigator.pop();

            if (newIndex == 0) {
              ref.read(bottomNavigationProvider.notifier).state = 0;
            } else {
              ref.read(bottomNavigationProvider.notifier).state = newIndex;
            }
          }
        }
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.cast_for_education_sharp),
          label: 'Курсы',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_support),
          label: 'Вопросы/Ответы',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: 'Форма обратной связи',
        ),
      ],
      selectedItemColor: AppColors.activeColor,
      unselectedItemColor: AppColors.inActiveColor,
    );
  }
}
