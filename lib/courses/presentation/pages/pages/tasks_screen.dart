import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/presentation/pages/all_pages.dart';
import 'package:learnsql/courses/presentation/pages/pages/list_of_materials_screen.dart';
import 'package:learnsql/courses/presentation/pages/pages/list_of_themes.dart';
import 'package:learnsql/courses/presentation/pages/pages/one_task_screen.dart';
import 'package:learnsql/courses/presentation/widgets/all_widgets.dart';

class TasksAndMaterialScreen extends ConsumerStatefulWidget {
  final int courseId;
  const TasksAndMaterialScreen({super.key, required this.courseId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksAndMaterialScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(showButton: true, controller: _tabController),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TasksTabView(courseId: widget.courseId),
          _MaterialsTabView(courseId: widget.courseId),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(activeIndex: 0),
    );
  }
}

class _TasksTabView extends StatelessWidget {
  final int courseId;
  const _TasksTabView({required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/tasks',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/tasks':
            return MaterialPageRoute(
              builder: (context) => ListOfTasksScreen(courseId: courseId),
            );
          case '/oneTask':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder:
                  (context) =>
                      OneTaskScreen(id: args['id'], taskId: args['taskId']),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => ListOfMaterialsScreen(courseId: courseId),
            );
        }
      },
    );
  }
}

class _MaterialsTabView extends StatelessWidget {
  final int courseId;
  const _MaterialsTabView({required this.courseId});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: '/materials',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/materials':
            return MaterialPageRoute(
              builder: (context) => ListOfMaterialsScreen(courseId: courseId),
            );
          case '/themes':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder:
                  (context) => ListOfThemesScreen(themeId: args['themeId']),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => ListOfMaterialsScreen(courseId: courseId),
            );
        }
      },
    );
  }
}
