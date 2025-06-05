import 'package:learnsql/courses/data/remote_data/courses_api.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/courses_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/materials_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/one_task_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/request_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/tasks_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/theme_entity.dart';

abstract class CoursesService {
  Future<CoursesListEntity> getAllCouses();
  Future<void> addCourse({required int course});
  Future<List<int>> getJoinedCoursesIds();
  Future<TasksEntity> getTasks({required int id});
  Future<MaterialsEntity> getMaterials({required int id});
  Future<ThemeEntity> getTheme({required int id});
  Future<OneTaskEntity> getOneTask({required int id});
  Future<SolutionResponseEntity> executeSolution({
    required String solution,
    required int taskId,
    required int status,
    required int id,
  });
}

class CoursesServiceImpl implements CoursesService {
  final CoursesApi _coursesApi;

  CoursesServiceImpl({required CoursesApi coursesApi})
    : _coursesApi = coursesApi;

  @override
  Future<CoursesListEntity> getAllCouses() async {
    final cousesModel = await _coursesApi.getAllCouses();
    return cousesModel!.toEntity();
  }

  @override
  Future<void> addCourse({required int course}) async {
    await _coursesApi.addCourse(course: course);
  }

  @override
  Future<List<int>> getJoinedCoursesIds() async {
    final response = await _coursesApi.getJoinedCourses();
    return (response['results'] as List)
        .map((course) => course['course'] as int)
        .toList();
  }

  @override
  Future<TasksEntity> getTasks({required int id}) async {
    final tasksModel = await _coursesApi.getTasks(id: id);
    return tasksModel.toEntity();
  }

  @override
  Future<MaterialsEntity> getMaterials({required int id}) async {
    final materialsModel = await _coursesApi.getMaterials(id: id);
    return materialsModel.toEntity();
  }

  @override
  Future<ThemeEntity> getTheme({required int id}) async {
    final themesModel = await _coursesApi.getTheme(id: id);
    return themesModel.toEntity();
  }

  @override
  Future<OneTaskEntity> getOneTask({required int id}) async {
    final taskModel = await _coursesApi.getOneTask(id: id);
    return taskModel.toEntity();
  }

  @override
  Future<SolutionResponseEntity> executeSolution({
    required String solution,
    required int taskId,
    required int status,
    required int id,
  }) async {
    final response = await _coursesApi.executeSolution(
      solution: solution,
      taskId: taskId,
      status: status,
      id: id,
    );
    return response.toEntity();
  }
}
