import 'package:json_annotation/json_annotation.dart';

part 'client_request_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class ClientRequestModel {
  String? cnic;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? password;

  ClientRequestModel({
    this.cnic,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.password,
  });
  factory ClientRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ClientRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ClientRequestModelToJson(this);
}
