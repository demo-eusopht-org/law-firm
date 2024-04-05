import 'package:json_annotation/json_annotation.dart';

import '../generic_response.dart';

part 'all_templates_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AllTemplatesResponse extends GenericResponse {
  final List<Template> data;

  AllTemplatesResponse({
    required super.status,
    required super.message,
    required this.data,
  });

  factory AllTemplatesResponse.fromJson(Map<String, dynamic> data) {
    return _$AllTemplatesResponseFromJson(data);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$AllTemplatesResponseToJson(this);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Template {
  final int id;
  final String title;
  final String fileName;
  final DateTime createdAt;

  Template({
    required this.id,
    required this.title,
    required this.fileName,
    required this.createdAt,
  });

  factory Template.fromJson(Map<String, dynamic> json) {
    return _$TemplateFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TemplateToJson(this);
  }
}
