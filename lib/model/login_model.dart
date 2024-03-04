import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable()
class UserResponse {
  int? status;
  String? message;
  String? token;
  User? data;

  UserResponse({
    this.status,
    this.message,
    this.token,
    this.data,
  });
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class User {
  int? id;
  String? cnic;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? description;
  int? role;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? roleId;
  String? roleName;
  User({
    this.id,
    this.cnic,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.description,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.roleId,
    this.roleName,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
