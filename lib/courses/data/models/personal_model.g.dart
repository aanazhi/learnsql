// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalModel _$PersonalModelFromJson(Map<String, dynamic> json) =>
    PersonalModel(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      groupNumber: (json['group_number'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PersonalModelToJson(PersonalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'group_number': instance.groupNumber,
    };
