import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/constants/app_constants.dart';
import 'package:learnsql/courses/data/remote_data/courses_api.dart';
import 'package:learnsql/courses/data/remote_data/feedback_api.dart';
import 'package:learnsql/courses/data/remote_data/personal_account_api.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/courses_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/execution_result.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/materials_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/one_task_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/request_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/solution_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/tasks_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/theme_entity.dart';
import 'package:learnsql/courses/domain/courses/courses_service/courses_service.dart';
import 'package:learnsql/courses/domain/feedback/feedback_service/feedback_service.dart';
import 'package:learnsql/courses/domain/groups/group_entity/group_entity.dart';
import 'package:learnsql/courses/domain/personal_data/personal_data_entity/personal_data_entity.dart';
import 'package:learnsql/courses/domain/personal_data/personal_data_service/personal_data_service.dart';
import 'package:learnsql/enterance_registration/providers/auth_reg_providers.dart';

// Dio Providers
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {'Accept': AppConstants.headers},
    ),
  );

  final talker = ref.watch(talkerProvider);

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        talker.log('Request: ${options.method} ${options.uri}');
        talker.log('Headers: ${options.headers}');
        talker.log('Data: ${options.data}');

        final accessToken = await ref.read(accessTokenLocalDataProvider.future);
        final token = await accessToken.getAccessToken();

        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
          talker.log('Authorization token added to headers');
        } else {
          talker.log('No authorization token available');
        }

        return handler.next(options);
      },
    ),
  );
  return dio;
});

// API Providers
final coursesApiProvider = Provider<CoursesApi>((ref) {
  final dio = ref.read(dioProvider);
  final talker = ref.watch(talkerProvider);

  return CoursesApiImpl(dio: dio, talker: talker);
});

final feedbackApiProvider = Provider<FeedbackApi>((ref) {
  final dio = ref.read(dioProvider);
  final talker = ref.watch(talkerProvider);

  return FeedbackApiImpl(dio: dio, talker: talker);
});

final personalDataApiProvider = Provider<PersonalAccountApi>((ref) {
  final dio = ref.read(dioProvider);
  final talker = ref.watch(talkerProvider);

  return PersonalAccountApiImpl(dio: dio, talker: talker);
});

// Service Providers
final cousesServiceProvider = Provider<CoursesService>((ref) {
  final coursesApi = ref.read(coursesApiProvider);
  return CoursesServiceImpl(coursesApi: coursesApi);
});

final feedbackServiceProvider = Provider<FeedbackService>((ref) {
  final feedbackApi = ref.read(feedbackApiProvider);
  return FeedbackServiceImpl(feedbackApi: feedbackApi);
});

final personalDataServiceProvider = Provider<PersonalDataService>((ref) {
  final personalAccountApi = ref.read(personalDataApiProvider);
  return PersonalDataServiceImpl(personalAccountApi: personalAccountApi);
});

// Courses Providers
final getAllCousesProvider = FutureProvider<CoursesListEntity>((ref) async {
  final coursesService = ref.read(cousesServiceProvider);

  return await coursesService.getAllCouses();
});

final addCourseProvider = FutureProvider.family<void, Map<String, dynamic>>((
  ref,
  data,
) async {
  final coursesService = ref.read(cousesServiceProvider);
  final course = data['course'] as int;

  return await coursesService.addCourse(course: course);
});

final joinedCoursesProvider = FutureProvider<List<int>>((ref) async {
  final coursesService = ref.read(cousesServiceProvider);
  return await coursesService.getJoinedCoursesIds();
});

final tasksProvider = FutureProvider.autoDispose.family<TasksEntity, int>((
  ref,
  id,
) {
  return ref.read(cousesServiceProvider).getTasks(id: id);
});

final materialsProvider = FutureProvider.autoDispose
    .family<MaterialsEntity, int>((ref, id) {
      return ref.read(cousesServiceProvider).getMaterials(id: id);
    });

final themesProvider = FutureProvider.autoDispose.family<ThemeEntity, int>((
  ref,
  id,
) {
  return ref.read(cousesServiceProvider).getTheme(id: id);
});

final executeSolutionProvider = FutureProvider.autoDispose
    .family<SolutionResponseEntity, ExecuteSolutionParams>((ref, params) async {
      final service = ref.read(cousesServiceProvider);
      return service.executeSolution(
        solution: params.solution,
        taskId: params.taskId,
        status: params.status,
        id: params.id,
      );
    });

final oneTaskProvider = FutureProvider.autoDispose.family<OneTaskEntity, int>((
  ref,
  id,
) {
  return ref.read(cousesServiceProvider).getOneTask(id: id);
});

// Feedback Providers
final addFeedbackProvider = FutureProvider.family<dynamic, Map<String, String>>(
  (ref, data) async {
    final feedbackService = ref.watch(feedbackServiceProvider);
    final subject = data['subject'] ?? '';
    final message = data['password'] ?? '';

    return await feedbackService.feedbackAdd(
      subject: subject,
      message: message,
    );
  },
);

final themeFbProvider = StateProvider<bool>((ref) => false);

final messageFbProvider = StateProvider<bool>((ref) => false);

// Personal Account Providers
final getPersonalDataProvider = FutureProvider<PersonalDataEntity>((ref) async {
  final personalDataService = ref.read(personalDataServiceProvider);

  return await personalDataService.getPersonalData();
});

final getGroupsProvider = FutureProvider<GroupEntity>((ref) async {
  final personalDataService = ref.read(personalDataServiceProvider);

  return await personalDataService.getGroupData();
});

final patchPersonalProvider = FutureProvider.family<
  PersonalDataEntity,
  Map<String, dynamic>
>((ref, data) async {
  final personalDataService = ref.read(personalDataServiceProvider);

  debugPrint('Sending update data: $data');

  final formData = FormData.fromMap({
    if (data['first_name'] != null) 'first_name': data['first_name'].toString(),
    if (data['last_name'] != null) 'last_name': data['last_name'].toString(),
    if (data['group_number'] != null)
      'group_number': data['group_number'].toString(),
  });

  final result = await personalDataService.patchPersonalData(
    formData: formData,
  );

  return result;
});

// UI State Providers
final bottomNavigationProvider = StateProvider<int>((ref) => 0);
final isEditPersonalAccount = StateProvider<bool>((ref) => false);
final personalChangesProvider = StateProvider<bool>((ref) => false);
final selectedGroupInAccountProvider = StateProvider<int?>((ref) => null);
final patchPersonalLoadingProvider = StateProvider<bool>((ref) => false);
final courseIdProvider = StateProvider<int>((ref) => 0);
final themeIdProvider = StateProvider<int>((ref) => 0);

// Initial Values Providers
final initialFirstNameProvider = StateProvider<String?>((ref) => null);
final initialLastNameProvider = StateProvider<String?>((ref) => null);
final initialGroupIdProvider = StateProvider<int?>((ref) => null);

final executionHistoryProvider = StateNotifierProvider.family<
  ExecutionHistoryNotifier,
  List<ExecutionResult>,
  int
>((ref, taskId) {
  return ExecutionHistoryNotifier();
});

class ExecutionHistoryNotifier extends StateNotifier<List<ExecutionResult>> {
  ExecutionHistoryNotifier() : super([]);

  void addResult(ExecutionResult result) {
    state = [result, ...state];
  }

  void clearHistory() {
    state = [];
  }
}
