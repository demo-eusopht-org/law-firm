import 'package:case_management/model/forgot_password_model.dart';
import 'package:case_management/model/get_all_lawyers_model.dart';
import 'package:case_management/model/new_lawyer_model.dart';
import 'package:case_management/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'lawyer_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class LawyerApi {
  factory LawyerApi(Dio dio, {String baseUrl}) = _LawyerApi;
  @POST('/api/lawyers/create-lawyer')
  Future<NewLawyerModel> createLawyer(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @POST('/api/lawyers/delete-lawyer')
  Future<ForgotPasswordModel> deleteLawyer(
      @Header('Authorization') String token, @Body() Map<String, dynamic> body);

  @GET("/api/lawyers/get-all-lawyers")
  Future<GetAllLawyerModel> getLawyers(@Header('Authorization') String token);
}
