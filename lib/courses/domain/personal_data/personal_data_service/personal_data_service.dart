import 'package:dio/dio.dart';
import 'package:learnsql/courses/data/remote_data/personal_account_api.dart';
import 'package:learnsql/courses/domain/groups/group_entity/group_entity.dart';
import 'package:learnsql/courses/domain/personal_data/personal_data_entity/personal_data_entity.dart';

abstract class PersonalDataService {
  Future<PersonalDataEntity> getPersonalData();
  Future<GroupEntity> getGroupData();
  Future<PersonalDataEntity> patchPersonalData({required FormData formData});
}

class PersonalDataServiceImpl implements PersonalDataService {
  final PersonalAccountApi _personalAccountApi;

  PersonalDataServiceImpl({required PersonalAccountApi personalAccountApi})
    : _personalAccountApi = personalAccountApi;

  @override
  Future<PersonalDataEntity> getPersonalData() async {
    final personalDataModel = await _personalAccountApi.getPersonalData();
    return personalDataModel!.toEntity();
  }

  @override
  Future<GroupEntity> getGroupData() async {
    final groupModel = await _personalAccountApi.getGroupData();
    return groupModel!.toEntity();
  }

  @override
  Future<PersonalDataEntity> patchPersonalData({
    required FormData formData,
  }) async {
    final personalDataModel = await _personalAccountApi.patchPersonalData(
      formData: formData,
    );
    return personalDataModel!.toEntity();
  }
}
