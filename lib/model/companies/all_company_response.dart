import 'package:json_annotation/json_annotation.dart';

import '../../utils/json_utils.dart';
import '../users/login_model.dart';

part 'all_company_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AllCompanyResponse {
  final int status;
  final String message;
  final List<Company> data;

  AllCompanyResponse({
    required this.status,
    required this.message,
    this.data = const [],
  });

  factory AllCompanyResponse.fromJson(Map<String, dynamic> json) {
    return _$AllCompanyResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllCompanyResponseToJson(this);
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Company {
  final int id;
  final String companyName;
  final User? companyAdmin;
  @JsonKey(fromJson: dateFromJson)
  final DateTime createdAt;

  Company({
    required this.id,
    required this.companyName,
    this.companyAdmin,
    required this.createdAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return _$CompanyFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CompanyToJson(this);
  }
}
