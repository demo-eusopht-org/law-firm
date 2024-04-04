import 'package:case_management/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/generic_response.dart';

part 'company_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class CompanyApi {
  factory CompanyApi(Dio dio, {String? baseUrl}) = _CompanyApi;

  @POST('/api/company/create-company')
  Future<GenericResponse> createCompany(@Body() Map<String, dynamic> body);
}
