import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/json_utils.dart';
import '../lawyers/all_clients_response.dart';
import '../lawyers/get_all_lawyers_model.dart';

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
  const User({
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

  Client toClient() {
    return Client(
      id: id,
      cnic: cnic,
      firstName: firstName,
      lastName: lastName,
      description: description,
      profilePic: profilePic,
      email: email,
      role: role,
      phoneNumber: phoneNumber,
      roleName: roleName,
      status: status == 1,
    );
  }

  AllLawyer toLawyer() {
    return AllLawyer(
      id: id,
      cnic: cnic,
      firstName: firstName,
      lastName: lastName ?? '',
      profilePic: profilePic,
      description: description,
      email: email,
      phoneNumber: phoneNumber,
      lawyerCredentials: '',
      lawyerBio: '',
      expertise: '',
    );
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
