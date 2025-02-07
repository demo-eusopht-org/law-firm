import 'package:json_annotation/json_annotation.dart';

import '../../utils/json_utils.dart';
import '../users/login_model.dart';

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
    super.lastName,
    required super.email,
    super.description,
    required super.role,
    required super.phoneNumber,
    super.profilePic,
    required super.notificationsEnabled,
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

  Profile changeNotificationStatus(bool notificationStatus) {
    return Profile(
      id: id,
      cnic: cnic,
      firstName: firstName,
      lastName: lastName,
      email: email,
      role: role,
      phoneNumber: phoneNumber,
      profilePic: profilePic,
      notificationsEnabled: notificationStatus,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      roleId: roleId,
      roleName: roleName,
      description: description,
      expertise: expertise,
      lawyerBio: lawyerBio,
      lawyerCredentials: lawyerCredentials,
    );
  }
}
