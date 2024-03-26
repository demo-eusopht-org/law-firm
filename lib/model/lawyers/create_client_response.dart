import 'package:json_annotation/json_annotation.dart';

import '../generic_response.dart';

part 'create_client_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateClientResponse extends GenericResponse {
  final int? clientId;

  CreateClientResponse({
    required super.status,
    required super.message,
    required this.clientId,
  });

  factory CreateClientResponse.fromJson(Map<String, dynamic> json) {
    return _$CreateClientResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CreateClientResponseToJson(this);
  }
}
