import 'package:json_annotation/json_annotation.dart';

part 'get_role_model.g.dart';

@JsonSerializable()
class GetRoleModel {
  int status;
  String message;
  List<Role> roles;

  GetRoleModel({
    required this.status,
    required this.message,
    required this.roles,
  });

  factory GetRoleModel.fromJson(Map<String, dynamic> json) =>
      _$GetRoleModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetRoleModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Role {
  int id;
  String roleName;

  Role({
    required this.id,
    required this.roleName,
  });

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);

  Map<String, dynamic> toJson() => _$RoleToJson(this);
}
