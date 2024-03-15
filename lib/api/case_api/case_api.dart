import 'dart:io';

import 'package:case_management/model/cases/case_status.dart';
import 'package:case_management/model/cases/case_type.dart';
import 'package:case_management/model/cases/court_type.dart';
import 'package:case_management/model/generic_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../utils/constants.dart';

part 'case_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class CaseApi {
  factory CaseApi(Dio dio, {String? baseUrl}) = _CaseApi;

  @GET('/api/cases/get-case-types')
  Future<CaseTypeResponse> getCaseType();

  @GET('/api/cases/get-case-statuses')
  Future<CaseStatusResponse> getCaseStatuses();

  @GET('/api/cases/get-court-types')
  Future<CourtTypeResponse> getCourtTypes();

  @POST('/api/cases/create-case')
  Future<GenericResponse> createCase(@Body() Map<String, dynamic> body);

  @MultiPart()
  @POST('/api/cases/upload-case-files')
  Future<GenericResponse> uploadCaseFile({
    @Part() required String case_no,
    @Part() required File case_file,
    @Part() required String file_title,
    @Part() String? case_history_id,
  });
}
