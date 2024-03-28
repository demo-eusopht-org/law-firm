import 'package:json_annotation/json_annotation.dart';

part 'lawyer_request_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LawyerRequestModel {
  String? cnic;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? role;
  String? lawyerCredential;
  String? experience;
  Exp? expertise;
  String? lawyerBio;
  String? password;
  Qualification? qualification;

  LawyerRequestModel({
    this.cnic,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.role,
    this.lawyerCredential,
    this.experience,
    this.expertise,
    this.lawyerBio,
    this.password,
  });
  factory LawyerRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LawyerRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$LawyerRequestModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Exp {
  final String jobTitle;
  final String employer;
  final String startYear;
  final String endYear;

  const Exp({
    required this.jobTitle,
    required this.employer,
    required this.startYear,
    required this.endYear,
  });

  factory Exp.fromJson(Map<String, dynamic> json) => _$ExpFromJson(json);

  Map<String, dynamic> toJson() => _$ExpToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Qualification {
  final String degree;
  final String institute;
  final String startYear;
  final String endYear;

  Qualification({
    required this.degree,
    required this.institute,
    required this.startYear,
    required this.endYear,
  });

  factory Qualification.fromJson(Map<String, dynamic> json) {
    return _$QualificationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QualificationToJson(this);
}
