import 'package:case_management/model/forgot_password_model.dart';
import 'package:case_management/model/get_all_lawyers_model.dart';
import 'package:case_management/model/generic_response.dart';
import 'package:case_management/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../model/lawyers/all_clients_response.dart';

part 'lawyer_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class LawyerApi {
  factory LawyerApi(Dio dio, {String baseUrl}) = _LawyerApi;
  @POST('/api/lawyers/create-lawyer')
  Future<GenericResponse> createLawyer(@Body() Map<String, dynamic> body);

  @POST('/api/lawyers/update-lawyer')
  Future<GetAllLawyerModel> updateLawyer(@Body() Map<String, dynamic> body);

  @POST('/api/lawyers/delete-lawyer')
  Future<ForgotPasswordModel> deleteLawyer(@Body() Map<String, dynamic> body);

  @GET("/api/lawyers/get-all-lawyers")
  Future<GetAllLawyerModel> getLawyers();

  @GET('/api/lawyers/get-all-clients')
  Future<AllClientsResponse> getAllClients();
}
