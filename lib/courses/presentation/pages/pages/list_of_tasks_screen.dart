import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/config.dart';
import 'package:learnsql/courses/presentation/pages/pages/one_task_screen.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';

class ListOfTasksScreen extends ConsumerWidget {
  final int courseId;
  const ListOfTasksScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme;
    final tasksAsync = ref.watch(tasksProvider(courseId));

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: tasksAsync.when(
        data: (tasks) {
          return SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 24),
                    width: 345,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColors.inActiveColor,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(tasks.count, (index) {
                            final tasksNumber = index + 1;
                            final task = tasks.results[index];
                            final isLast = index == tasks.count - 1;

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (kDebugMode) {
                                      print('tasksNumber $tasksNumber');
                                    }
                                    if (kDebugMode) {
                                      print('tasks ${task.taskInSet.id}');
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => OneTaskScreen(
                                              taskId: task.taskInSet.id,
                                              solution: task.solution,
                                              id: task.id, 
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 70,
                                    color: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 26,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 32,
                                          ),
                                          child: Text(
                                            '$tasksNumber',
                                            style: textStyle.titleLarge
                                                ?.copyWith(
                                                  color:
                                                      task.status == '0'
                                                          ? AppColors
                                                              .withOpacityColor
                                                          : AppColors
                                                              .checkColor,
                                                ),
                                          ),
                                        ),
                                        task.status == '0'
                                            ? const Icon(
                                              Icons.close,
                                              size: 30,
                                              color: AppColors.withOpacityColor,
                                            )
                                            : const Icon(
                                              Icons.check_outlined,
                                              size: 30,
                                              color: AppColors.checkColor,
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (!isLast)
                                  const Divider(
                                    thickness: 2,
                                    color: AppColors.inActiveColor,
                                  ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
        error:
            (error, _) => Center(
              child: Text(
                'Произошла ошибка, уже работаем над этим!',
                style: textStyle.labelMedium,
              ),
            ),
        loading:
            () => const Center(
              child: CircularProgressIndicator(color: AppColors.activeColor),
            ),
      ),
    );
  }
}
