import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnsql/config/constants/app_constants.dart';
import 'package:learnsql/courses/data/remote_data/courses_api.dart';
import 'package:learnsql/courses/data/remote_data/feedback_api.dart';
import 'package:learnsql/courses/data/remote_data/personal_account_api.dart';
import 'package:learnsql/courses/domain/courses/courses_entity/courses_entity.dart';
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

// Initial Values Providers
final initialFirstNameProvider = StateProvider<String?>((ref) => null);
final initialLastNameProvider = StateProvider<String?>((ref) => null);
final initialGroupIdProvider = StateProvider<int?>((ref) => null);
