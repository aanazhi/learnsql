import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/presentation/pages/all_pages.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';

class MainOnPaScreen extends ConsumerStatefulWidget {
  const MainOnPaScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainOnPaScreenState();
}

class _MainOnPaScreenState extends ConsumerState<MainOnPaScreen> {
  final List<Widget> _screens = [
    const AllCoursesContent(),
    const QaScreen(),
    const FeedbackFormScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavigationProvider);

    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 26,
        backgroundColor: AppColors.greyColor,
        currentIndex: currentIndex,
        onTap: (newIndex) {
          ref.read(bottomNavigationProvider.notifier).state = newIndex;
          ref.read(themeFbProvider.notifier).state = false;
          ref.read(messageFbProvider.notifier).state = false;
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
      ),
    );
  }
}
