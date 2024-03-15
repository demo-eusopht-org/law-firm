import 'package:json_annotation/json_annotation.dart';

part 'case_status.g.dart';

@JsonSerializable(explicitToJson: true)
class CaseStatusResponse {
  final int status;
  final String message;
  final List<CaseStatus> data;

  CaseStatusResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CaseStatusResponse.fromJson(Map<String, dynamic> json) {
    return _$CaseStatusResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CaseStatusResponseToJson(this);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CaseStatus {
  final int id;
  final String statusName;

  CaseStatus({
    required this.id,
    required this.statusName,
  });

  factory CaseStatus.fromJson(Map<String, dynamic> json) {
    return _$CaseStatusFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CaseStatusToJson(this);
  }
}
