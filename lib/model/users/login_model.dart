import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/json_utils.dart';

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
class User extends Equatable {
  final int id;
  final String cnic;
  final String firstName;
  final String? lastName;
  final String email;
  final String? description;
  final int role;
  final int status;
  final String phoneNumber;
  final String? profilePic;
  final bool notificationsEnabled;
  @JsonKey(fromJson: dateFromJson)
  final DateTime createdAt;
  @JsonKey(fromJson: dateFromJson)
  final DateTime updatedAt;
  final int roleId;
  final String roleName;
  User({
    required this.id,
    required this.cnic,
    required this.firstName,
    this.lastName,
    required this.email,
    this.description,
    required this.role,
    required this.phoneNumber,
    this.profilePic,
    required this.notificationsEnabled,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
    required this.roleName,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get displayName {
    return '$firstName $lastName';
  }

  @override
  List<Object?> get props => [
        id,
        cnic,
        email,
        firstName,
        lastName,
        notificationsEnabled,
        status,
      ];
}
