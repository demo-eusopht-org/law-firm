import 'package:json_annotation/json_annotation.dart';

part 'lawyer_request_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class LawyerRequestModel {
  String? cnic;
  String? firstName;
  String? lastName;
  String? email;
  int? phoneNumber;
  int? role;
  String? lawyerCredential;
  String? experience;
  String? expertise;
  String? lawyerBio;
  String? password;

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
