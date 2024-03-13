// import 'package:json_annotation/json_annotation.dart';
//
// part 'lawyer_request_model.g.dart';
//
// @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
// class GetAllLawyerModel {
//   String? message;
//   int? status;
//   AllLawyer? lawyer;
//
//   GetAllLawyerModel({
//     this.message,
//     this.status,
//     this.lawyer,
//   });
// }
//
// class AllLawyer{}
//
//   String? cnic;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? phoneNumber;
//   String? role;
//   String? lawyerCredential;
//   String? experience;
//   Exp? expertise;
//   String? lawyerBio;
//   String? password;
//   Qualification? qualification;
//
//   LawyerRequestModel({
//     this.cnic,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.phoneNumber,
//     this.role,
//     this.lawyerCredential,
//     this.experience,
//     this.expertise,
//     this.lawyerBio,
//     this.password,
//   });
//   factory LawyerRequestModel.fromJson(Map<String, dynamic> json) =>
//       _$LawyerRequestModelFromJson(json);
//   Map<String, dynamic> toJson() => _$LawyerRequestModelToJson(this);
// }
//
// @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
// class Exp {
//   String? jobTitle;
//   String? employer;
//   int? startYear;
//   int? endYear;
//
//   Exp({
//     this.jobTitle,
//     this.employer,
//     this.startYear,
//     this.endYear,
//   });
//   factory Exp.fromJson(Map<String, dynamic> json) => _$ExpFromJson(json);
//   Map<String, dynamic> toJson() => _$ExpToJson(this);
// }
//
// @JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
// class Qualification {
//   String? degree;
//   String? institute;
//   int? startYear;
//   int? endYear;
//
//   Qualification({
//     this.degree,
//     this.institute,
//     this.startYear,
//     this.endYear,
//   });
//   factory Qualification.fromJson(Map<String, dynamic> json) =>
//       _$QualificationFromJson(json);
//   Map<String, dynamic> toJson() => _$QualificationToJson(this);
// }
