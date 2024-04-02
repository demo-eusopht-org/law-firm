import 'dart:io';

import 'package:case_management/model/cases/all_case_files_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/cases/add_proceeding_response.dart';
import '../../model/cases/all_cases_response.dart';
import '../../model/cases/case_history_response.dart';
import '../../model/cases/case_status.dart';
import '../../model/cases/case_type.dart';
import '../../model/cases/court_type.dart';
import '../../model/cases/get_case_response.dart';
import '../../model/generic_response.dart';
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
    @Part(name: 'case_no') required String caseNo,
    @Part(name: 'case_file') required File caseFile,
    @Part(name: 'file_title') required String fileTitle,
    @Part(name: 'case_history_id') int? caseHistoryId,
  });

  @GET('/api/cases/get-cases')
  Future<AllCasesResponse> getAllCases();

  @POST('/api/cases/get-case-history')
  Future<CaseHistoryResponse> getCaseHistory(@Body() Map<String, dynamic> body);

  @POST('/api/cases/add-proceedings')
  Future<AddProceedingResponse> createProceeding(
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/cases/get-user-cases')
  Future<AllCasesResponse> getUserCases(@Query('user_id') int userId);

  @POST('/api/cases/delete-case')
  Future<GenericResponse> deleteCase(@Body() Map<String, dynamic> body);

  @POST('/api/cases/assign-case-to-user')
  Future<GenericResponse> assignCaseToUser(@Body() Map<String, dynamic> body);

  @GET('/api/cases/get-case')
  Future<GetCaseResponse> getCase(@Query('caseNo') String caseNo);

  @GET('/api/cases/get-all-case-files')
  Future<AllCaseFilesResponse> getAllCaseFiles(
      @Body() Map<String, dynamic> body);
}
