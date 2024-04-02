import 'package:json_annotation/json_annotation.dart';

import '../generic_response.dart';
import 'get_all_lawyers_model.dart';
import 'lawyer_request_model.dart';

part 'update_lawyer_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateLawyerResponse extends GenericResponse {
  final LawyerProfile? data;

  UpdateLawyerResponse({
    required super.status,
    required super.message,
    this.data,
  });

  factory UpdateLawyerResponse.fromJson(Map<String, dynamic> json) {
    return _$UpdateLawyerResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateLawyerResponseToJson(this);
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LawyerProfile {
  final String userId;
  final String firstName;
  final String? lastName;
  final String email;
  final String phoneNumber;
  final int role;
  final String lawyerCredentials;
  final String expertise;
  final String lawyerBio;
  final List<Exp> experience;
  final List<Qualification> qualification;

  LawyerProfile({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.lawyerCredentials,
    required this.expertise,
    required this.lawyerBio,
    required this.experience,
    required this.qualification,
  });

  factory LawyerProfile.fromJson(Map<String, dynamic> json) {
    return _$LawyerProfileFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LawyerProfileToJson(this);
  }

  AllLawyer toAllLawyer(
    String cnic,
    String? profilePic,
  ) {
    return AllLawyer(
      id: int.parse(userId),
      cnic: cnic,
      firstName: firstName,
      lastName: lastName!,
      profilePic: profilePic,
      email: email,
      phoneNumber: phoneNumber,
      lawyerCredentials: lawyerCredentials,
      lawyerBio: lawyerBio,
      expertise: expertise,
      experience: experience
          .map(
            (e) => AllLawyerExp(
              id: 0,
              jobTitle: e.jobTitle,
              employer: e.employer,
              startYear: e.startYear,
              endYear: e.endYear,
              userId: int.parse(userId),
            ),
          )
          .toList(),
      qualification: qualification
          .map(
            (e) => AllLawyerQualification(
              id: 0,
              degree: e.degree,
              institute: e.institute,
              startYear: e.startYear,
              endYear: e.endYear,
              userId: int.parse(userId),
            ),
          )
          .toList(),
    );
  }
}
