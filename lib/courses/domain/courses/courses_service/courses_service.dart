import 'package:learnsql/courses/data/remote_data/courses_api.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/courses_entity.dart';

abstract class CoursesService {
  Future<CoursesListEntity> getAllCouses();
  Future<void> addCourse({required int course});
  Future<List<int>> getJoinedCoursesIds();
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
}
