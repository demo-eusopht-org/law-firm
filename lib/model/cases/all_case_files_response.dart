import 'package:json_annotation/json_annotation.dart';

import '../generic_response.dart';
import 'all_cases_response.dart';

part 'all_case_files_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AllCaseFilesResponse extends GenericResponse {
  final List<CaseFile> files;

  AllCaseFilesResponse({
    this.files = const [],
  });

  factory AllCaseFilesResponse.fromJson(Map<String, dynamic> json) {
    return _$AllCaseFilesResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$AllCaseFilesResponseToJson(this);
  }
}
