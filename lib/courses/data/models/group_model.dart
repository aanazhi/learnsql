import 'package:json_annotation/json_annotation.dart';
import 'package:learnsql/courses/domain/groups/group_entity/group_entity.dart';

part 'group_model.g.dart';

@JsonSerializable()
class GroupModel {
  final int count;
  final List<ListGroupsModel> results;

  GroupModel({required this.count, required this.results});

  factory GroupModel.fromJson(Map<String, dynamic> json) =>
      _$GroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$GroupModelToJson(this);

  GroupEntity toEntity() {
    return GroupEntity(
      count: count,
      results: results.map((res) => res.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class ListGroupsModel {
  final int id;
  final String title;
  final String period;
  final String organization;

  ListGroupsModel({
    required this.id,
    required this.title,
    required this.period,
    required this.organization,
  });

  factory ListGroupsModel.fromJson(Map<String, dynamic> json) =>
      _$ListGroupsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListGroupsModelToJson(this);

  ListGroupEntity toEntity() {
    return ListGroupEntity(
      id: id,
      title: title,
      period: period,
      organization: organization,
    );
  }
}
