import 'package:json_annotation/json_annotation.dart';

part 'get_all_lawyers_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetAllLawyerModel {
  String? message;
  int? status;
  List<AllLawyer> lawyers;

  GetAllLawyerModel({
    this.message,
    this.status,
    this.lawyers = const [],
  });
  factory GetAllLawyerModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllLawyerModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllLawyerModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AllLawyer {
  int? userId;
  int? id;
  String? cnic;
  String? firstName;
  String? lastName;
  String? email;
  String? decription;
  String? profilePic;
  String? phoneNumber;
  String? lawyerCredential;
  String? expertise;
  String? lawyerBio;
  List<AllLawyerExp> experience;
  List<AlllawyerQualification> qualification;

  AllLawyer({
    this.userId,
    this.id,
    this.cnic,
    this.firstName,
    this.lastName,
    this.email,
    this.decription,
    this.phoneNumber,
    this.profilePic,
    this.lawyerCredential,
    this.lawyerBio,
    this.expertise,
    this.experience = const [],
    this.qualification = const [],
  });
  factory AllLawyer.fromJson(Map<String, dynamic> json) =>
      _$AllLawyerFromJson(json);
  Map<String, dynamic> toJson() => _$AllLawyerToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AllLawyerExp {
  int? id;
  String? jobTitle;
  String? employer;
  int? startYear;
  int? endYear;
  int? userId;
  String? createdAt;
  String? updateedAt;

  AllLawyerExp({
    this.id,
    this.jobTitle,
    this.employer,
    this.startYear,
    this.endYear,
    this.userId,
    this.createdAt,
    this.updateedAt,
  });
  factory AllLawyerExp.fromJson(Map<String, dynamic> json) =>
      _$AllLawyerExpFromJson(json);
  Map<String, dynamic> toJson() => _$AllLawyerExpToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AlllawyerQualification {
  int? id;
  String? degree;
  String? institute;
  int? startYear;
  int? endYear;
  int? userId;
  String? createdAt;
  String? updateedAt;

  AlllawyerQualification({
    this.id,
    this.degree,
    this.institute,
    this.startYear,
    this.endYear,
    this.userId,
    this.createdAt,
    this.updateedAt,
  });
  factory AlllawyerQualification.fromJson(Map<String, dynamic> json) =>
      _$AlllawyerQualificationFromJson(json);
  Map<String, dynamic> toJson() => _$AlllawyerQualificationToJson(this);
}
