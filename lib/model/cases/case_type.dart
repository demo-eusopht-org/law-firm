import 'package:json_annotation/json_annotation.dart';

part 'case_type.g.dart';

@JsonSerializable(explicitToJson: true)
class CaseTypeResponse {
  final int status;
  final String message;
  final List<CaseType> data;

  CaseTypeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CaseTypeResponse.fromJson(Map<String, dynamic> json) {
    return _$CaseTypeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CaseTypeResponseToJson(this);
  }
}

@JsonSerializable()
class CaseType {
  final int id;
  final String type;

  CaseType({
    required this.id,
    required this.type,
  });

  factory CaseType.fromJson(Map<String, dynamic> json) {
    return _$CaseTypeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CaseTypeToJson(this);
  }
}
