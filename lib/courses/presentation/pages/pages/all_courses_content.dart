import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/presentation/widgets/all_widgets.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';
import 'package:learnsql/enterance_registration/presentation/widgets/all_widgets.dart';

class AllCoursesContent extends ConsumerStatefulWidget {
  const AllCoursesContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllCoursesContentState();
}

class _AllCoursesContentState extends ConsumerState<AllCoursesContent> {
  Future<void> _joinCourse(int courseId) async {
    try {
      await ref.read(addCourseProvider({'course': courseId}).future);
      ref.invalidate(joinedCoursesProvider);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: AuthSnackBar(
            message: 'Произошла ошибка.',
            iconColor: AppColors.backgroundColor,
            icon: Icons.error_outline_rounded,
          ),
          backgroundColor: AppColors.googleColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(getAllCousesProvider);
    final joinedCoursesAsync = ref.watch(joinedCoursesProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(),
      body: coursesAsync.when(
        data: (courses) {
          return joinedCoursesAsync.when(
            data: (joinedCourses) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(31, 59, 30, 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: courses.results.length,
                  itemBuilder: (context, index) {
                    final course = courses.results[index];
                    final isJoined = joinedCourses.contains(course.id);
                    final customTitle2 =
                        index == 0
                            ? 'задания подбираются случайным образом'
                            : 'выдача заданий';

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 44),
                      child: CourseCard(
                        id: course.id,
                        title: course.title,
                        title2: customTitle2,
                        difficulty: course.difficulty,
                        themes: course.themes,
                        isJoined: isJoined,
                        onJoinPressed: () => _joinCourse(course.id),
                      ),
                    );
                  },
                ),
              );
            },
            loading:
                () => const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.activeColor,
                  ),
                ),
            error: (error, _) => Center(child: Text('Ошибка: $error')),
          );
        },
        error: (error, _) => Center(child: Text('Произошла ошибка: $error')),
        loading:
            () => const Center(
              child: CircularProgressIndicator(color: AppColors.activeColor),
            ),
      ),
    );
  }
}
