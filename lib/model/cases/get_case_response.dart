import 'package:json_annotation/json_annotation.dart';

import '../generic_response.dart';
import 'all_cases_response.dart';

part 'get_case_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetCaseResponse extends GenericResponse {
  final Case? data;

  GetCaseResponse({
    required super.status,
    required super.message,
    this.data,
  });

  factory GetCaseResponse.fromJson(Map<String, dynamic> json) {
    return _$GetCaseResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$GetCaseResponseToJson(this);
  }
}
