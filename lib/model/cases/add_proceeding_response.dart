import 'package:json_annotation/json_annotation.dart';

part 'add_proceeding_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AddProceedingResponse {
  final int status;
  final String message;
  final int? proceedingId;

  AddProceedingResponse({
    required this.status,
    required this.message,
    this.proceedingId,
  });

  factory AddProceedingResponse.fromJson(Map<String, dynamic> json) {
    return _$AddProceedingResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddProceedingResponseToJson(this);
  }
}
