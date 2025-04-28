import 'package:json_annotation/json_annotation.dart';
import 'package:learnsql/courses/domain/personal_data/personal_data_entity/personal_data_entity.dart';

part 'personal_model.g.dart';

@JsonSerializable()
class PersonalModel {
  final int id;
  final String username;
  final String email;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  @JsonKey(name: 'group_number')
  final int? groupNumber;

  PersonalModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.groupNumber,
  });

  factory PersonalModel.fromJson(Map<String, dynamic> json) =>
      _$PersonalModelFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalModelToJson(this);

  PersonalDataEntity toEntity() {
    return PersonalDataEntity(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
    );
  }
}
