import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/theme/app_theme.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/execution_result.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/solution_entity.dart';
import 'package:learnsql/courses/presentation/pages/pages/db_info_screen.dart';
import 'package:learnsql/courses/providers/courses_providers.dart';

class OneTaskScreen extends ConsumerStatefulWidget {
  final int id;
  final int taskId;
  final String? solution;

  const OneTaskScreen({
    super.key,
    required this.id,
    required this.taskId,
    this.solution,
  });

  @override
  ConsumerState<OneTaskScreen> createState() => _OneTaskScreenState();
}

class _OneTaskScreenState extends ConsumerState<OneTaskScreen> {
  late final TextEditingController queryController;

  @override
  void initState() {
    super.initState();
    queryController = TextEditingController(text: widget.solution ?? '');
  }

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }

  Future<void> executeQuery() async {
    final query = queryController.text.trim();
    if (query.isEmpty) return;

    try {
      final result = await ref.read(
        executeSolutionProvider(
          ExecuteSolutionParams(
            solution: query,
            taskId: widget.taskId,
            status: 1,
            id: widget.id,
          ),
        ).future,
      );

      debugPrint('Parsed result: $result');

      if (result.isSuccess) {
        ref
            .read(executionHistoryProvider(widget.taskId).notifier)
            .clearHistory();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Запрос выполнен успешно!'),
            backgroundColor: Colors.green,
          ),
        );
      }

      ref
          .read(executionHistoryProvider(widget.taskId).notifier)
          .addResult(
            ExecutionResult(
              timestamp: DateTime.now(),
              query: query,
              result: result,
            ),
          );
    } catch (e, stack) {
      debugPrint('Error executing query: $e');
      debugPrint('Stack trace: $stack');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void clearQuery() {
    queryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final taskAsync = ref.watch(oneTaskProvider(widget.taskId));
    final executionHistory = ref.watch(executionHistoryProvider(widget.taskId));

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        surfaceTintColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: SizedBox(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 170,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: AppColors.inActiveColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.arrow_back,
                        color: AppColors.activeColor,
                        size: 24,
                      ),
                      Text(
                        'К списку заданий',
                        style: textStyle.bodyMedium?.copyWith(
                          color: AppColors.activeColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 170,
                height: 35,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: AppColors.inActiveColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'К следующему',
                        style: textStyle.bodyMedium?.copyWith(
                          color: AppColors.activeColor,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.activeColor,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: taskAsync.when(
        data: (task) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 19),
                    child: Text(
                      'Темы для изучения',
                      style: textStyle.bodyLarge?.copyWith(
                        color: AppColors.checkColor,
                      ),
                    ),
                  ),
                ),
                ...task.themes.expand(
                  (theme) => [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 8),
                      child: Text(
                        theme.theme.title,
                        style: textStyle.labelLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    ...theme.theme.topicInThemes.map(
                      (topic) => Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 28),
                        child: Text(
                          topic.topicName,
                          style: textStyle.labelLarge?.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    DbInfoScreen(taskId: widget.taskId),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.backgroundColor,
                        minimumSize: const Size(250, 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: AppColors.checkColor,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        'Посмотреть описание базы данных',
                        style: textStyle.titleMedium?.copyWith(
                          color: AppColors.checkColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 26, 0, 19),
                  child: Text(
                    'Задание:',
                    style: textStyle.titleMedium?.copyWith(
                      color: AppColors.checkColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 19),
                  child: Text(
                    task.taskText,
                    style: textStyle.labelLarge?.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 6, 32, 25),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.inActiveColor,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Запрос',
                            style: textStyle.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          thickness: 2,
                          color: AppColors.inActiveColor,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(8),
                            ),
                          ),
                          child: TextField(
                            controller: queryController,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Введите ваше решение здесь',
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: textStyle.labelLarge?.copyWith(
                              color: AppColors.blackColor,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 166,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: AppColors.blackColor),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: clearQuery,
                        child: Text(
                          'Очистить',
                          style: textStyle.labelLarge?.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 166,
                      height: 55,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.backgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: AppColors.activeColor,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: executeQuery,
                        child: Text(
                          'Выполнить',
                          style: textStyle.labelLarge?.copyWith(
                            color: AppColors.activeColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 40, 0, 30),
                  child: Text(
                    'История выполнения',
                    style: textStyle.bodyMedium?.copyWith(fontSize: 18),
                  ),
                ),
                ...executionHistory.map(
                  (result) => Padding(
                    padding: const EdgeInsets.fromLTRB(32, 0, 32, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Запрос: ${result.query}',
                          style: textStyle.bodySmall?.copyWith(
                            color: AppColors.blackColor,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 8),

                        if (result.result.isError) ...[
                          const Text(
                            'Ошибка!',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                    
                          if (result.result.message != null &&
                              (result.result.refResult == null ||
                                  result.result.refResult!.isEmpty))
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                result.result.message!,
                                style: textStyle.bodyMedium?.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),

                         
                          if (result.result.refResult != null &&
                              result.result.refResult!.isNotEmpty) ...[
                            if (result.result.message != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(result.result.message!),
                              ),

                            const Text(
                              'Правильный запрос:',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...result.result.refResult!.map(
                              (ref) => Column(
                                children: [
                                  if (ref.query.isNotEmpty) Text(ref.query),
                                  _buildResultTable(ref.rows),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),
                            const Text(
                              'Ваш запрос:',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            ...result.result.studentResult!.map(
                              (student) => Column(
                                children: [
                                  if (student.query.isNotEmpty)
                                    Text(student.query),
                                  _buildResultTable(student.rows),
                                ],
                              ),
                            ),
                          ],
                        ] else ...[
                          const Text(
                            'Правильно!',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Результат выполнения запроса',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (result.result.studentResult != null &&
                              result.result.studentResult!.isNotEmpty)
                            ...result.result.studentResult!.map(
                              (student) => Column(
                                children: [
                                  if (student.query.isNotEmpty)
                                    Text(student.query),
                                  _buildResultTable(student.rows),
                                ],
                              ),
                            ),
                        ],

                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: AppColors.inActiveColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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

  Widget _buildResultTable(List<List<String>>? rows) {
    final textStyle = Theme.of(context).textTheme;
    if (rows == null || rows.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('Нет данных'),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns:
            rows.first
                .map(
                  (header) => DataColumn(
                    label: Text(header, style: textStyle.bodyMedium),
                  ),
                )
                .toList(),
        rows:
            rows
                .skip(1)
                .where((row) => row.isNotEmpty)
                .map(
                  (row) => DataRow(
                    cells:
                        row
                            .map(
                              (cell) => DataCell(
                                Text(cell, style: textStyle.bodyMedium),
                              ),
                            )
                            .toList(),
                  ),
                )
                .toList(),
      ),
    );
  }
}
