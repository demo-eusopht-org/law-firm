import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../utils/json_utils.dart';
import '../users/login_model.dart';

part 'all_cases_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AllCasesResponse {
  final int status;
  final String message;
  final List<Case>? data;

  AllCasesResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory AllCasesResponse.fromJson(Map<String, dynamic> json) {
    return _$AllCasesResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AllCasesResponseToJson(this);
  }
}

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Case extends Equatable {
  final int id;
  final String caseNo;
  final String plaintiff;
  final String defendant;
  final String plaintiffAdvocate;
  final String defendantAdvocate;
  @JsonKey(fromJson: boolFromJson)
  final bool? isCustomerPlaintiff;
  @JsonKey(fromJson: dateFromJson)
  final DateTime caseFilingDate;
  @JsonKey(fromJson: dateFromJson)
  final DateTime nextHearingDate;
  final String judge;
  final String courtLocation;
  final int year;
  final String currentProceedings;
  final String caseStatus;
  final int statusId;
  final int typeId;
  final String caseType;
  final int courtId;
  final String courtType;
  final List<CaseFile> caseFiles;
  final User? caseCustomer;
  final User? caseLawyer;

  Case({
    required this.id,
    required this.caseNo,
    required this.plaintiff,
    required this.defendant,
    required this.plaintiffAdvocate,
    required this.defendantAdvocate,
    this.isCustomerPlaintiff,
    required this.caseFilingDate,
    required this.nextHearingDate,
    required this.judge,
    required this.courtLocation,
    required this.year,
    required this.currentProceedings,
    required this.caseStatus,
    required this.statusId,
    required this.typeId,
    required this.caseType,
    required this.courtId,
    required this.courtType,
    required this.caseFiles,
    this.caseCustomer,
    this.caseLawyer,
  });

  factory Case.fromJson(Map<String, dynamic> json) {
    return _$CaseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CaseToJson(this);
  }

  String get caseTitle {
    return '$plaintiff V $defendant';
  }

  @override
  List<Object?> get props => [
        id,
        caseNo,
        caseStatus,
        nextHearingDate,
      ];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CaseFile {
  final int id;
  final String fileName;
  final String fileTitle;
  final int caseId;
  @JsonKey(fromJson: dateFromJson)
  final DateTime createdAt;

  CaseFile({
    required this.id,
    required this.fileName,
    required this.fileTitle,
    required this.caseId,
    required this.createdAt,
  });

  factory CaseFile.fromJson(Map<String, dynamic> json) {
    return _$CaseFileFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CaseFileToJson(this);
  }
}
