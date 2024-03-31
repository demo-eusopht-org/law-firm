import 'package:case_management/utils/json_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'all_clients_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AllClientsResponse {
  final int status;
  final String message;
  final List<Client> data;

  AllClientsResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AllClientsResponse.fromJson(Map<String, dynamic> json) {
    return _$AllClientsResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllClientsResponseToJson(this);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Client {
  final int id;
  final String cnic;
  final String firstName;
  final String? lastName;
  final String email;
  final String? description;
  final int role;
  final String phoneNumber;
  final String? profilePic;
  final String roleName;
  @JsonKey(fromJson: boolFromJson)
  final bool status;

  Client({
    required this.id,
    required this.cnic,
    required this.firstName,
    this.lastName,
    required this.email,
    this.description,
    required this.role,
    required this.phoneNumber,
    this.profilePic,
    required this.roleName,
    required this.status,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return _$ClientFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ClientToJson(this);
  }

  String getDisplayName() {
    return '$firstName $lastName';
  }
}
