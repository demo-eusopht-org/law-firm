import 'package:json_annotation/json_annotation.dart';

part 'court_type.g.dart';

@JsonSerializable(explicitToJson: true)
class CourtTypeResponse {
  final int status;
  final String message;
  final List<CourtType> data;

  CourtTypeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CourtTypeResponse.fromJson(Map<String, dynamic> json) {
    return _$CourtTypeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CourtTypeResponseToJson(this);
  }
}

@JsonSerializable()
class CourtType {
  final int id;
  final String court;

  CourtType({
    required this.id,
    required this.court,
  });

  factory CourtType.fromJson(Map<String, dynamic> json) {
    return _$CourtTypeFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CourtTypeToJson(this);
  }
}
