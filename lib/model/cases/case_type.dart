import 'package:json_annotation/json_annotation.dart';

part 'case_type.g.dart';

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
