class PersonalDataEntity {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final int? groupNumber;

  PersonalDataEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.groupNumber,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalDataEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
