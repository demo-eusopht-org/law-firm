import 'package:case_management/model/login_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ProfileResponse {
  final int status;
  final String message;
  final Profile? user;

  ProfileResponse({
    required this.status,
    required this.message,
    this.user,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProfileResponseToJson(this);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Profile extends User {
  final String? lawyerCredentials;
  final String? expertise;
  final String? lawyerBio;

  Profile({
    required super.id,
    required super.cnic,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.description,
    required super.role,
    required super.phoneNumber,
    required super.profilePic,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    required super.roleId,
    required super.roleName,
    this.lawyerCredentials,
    this.expertise,
    this.lawyerBio,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return _$ProfileFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ProfileToJson(this);
  }
}
