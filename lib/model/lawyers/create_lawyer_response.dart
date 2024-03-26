import 'package:json_annotation/json_annotation.dart';

part 'create_lawyer_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateLawyerResponse {
  final int status;
  final String message;
  final int? lawyerId;

  CreateLawyerResponse({
    required this.status,
    required this.message,
    required this.lawyerId,
  });

  factory CreateLawyerResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateLawyerResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CreateLawyerResponseToJson(this);
  }
}
