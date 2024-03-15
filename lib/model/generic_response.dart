import 'package:json_annotation/json_annotation.dart';

part 'generic_response.g.dart';

@JsonSerializable()
class GenericResponse {
  String? message;
  int? status;

  GenericResponse({
    this.message,
    this.status,
  });
  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      _$GenericResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenericResponseToJson(this);
}
