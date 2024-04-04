import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_lawyers_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GetAllLawyerModel {
  final String message;
  final int status;
  List<AllLawyer> lawyers;

  GetAllLawyerModel({
    required this.message,
    required this.status,
    this.lawyers = const [],
  });
  factory GetAllLawyerModel.fromJson(Map<String, dynamic> json) =>
      _$GetAllLawyerModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetAllLawyerModelToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AllLawyer extends Equatable {
  final int id;
  final String cnic;
  final String firstName;
  final String lastName;
  final String email;
  String? description;
  String? profilePic;
  final String phoneNumber;
  final String lawyerCredentials;
  final String expertise;
  final String lawyerBio;
  List<AllLawyerExp> experience;
  List<AllLawyerQualification> qualification;

  AllLawyer({
    required this.id,
    required this.cnic,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.description,
    required this.phoneNumber,
    this.profilePic,
    required this.lawyerCredentials,
    required this.lawyerBio,
    required this.expertise,
    this.experience = const [],
    this.qualification = const [],
  });

  factory AllLawyer.fromJson(Map<String, dynamic> json) {
    return _$AllLawyerFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllLawyerToJson(this);

  String getDisplayName() {
    return '$firstName $lastName';
  }

  @override
  List<Object?> get props => [
        id,
        cnic,
      ];
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AllLawyerExp {
  final int id;
  final String jobTitle;
  final String employer;
  final String startYear;
  final String endYear;
  final int userId;
  String? createdAt;
  String? updatedAt;

  AllLawyerExp({
    required this.id,
    required this.jobTitle,
    required this.employer,
    required this.startYear,
    required this.endYear,
    required this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory AllLawyerExp.fromJson(Map<String, dynamic> json) {
    return _$AllLawyerExpFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllLawyerExpToJson(this);
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class AllLawyerQualification {
  int id;
  String degree;
  String institute;
  final String startYear;
  final String endYear;
  final int userId;
  String? createdAt;
  String? updatedAt;

  AllLawyerQualification({
    required this.id,
    required this.degree,
    required this.institute,
    required this.startYear,
    required this.endYear,
    required this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory AllLawyerQualification.fromJson(Map<String, dynamic> json) {
    return _$AllLawyerQualificationFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AllLawyerQualificationToJson(this);
}
