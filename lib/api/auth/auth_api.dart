import 'package:case_management/model/forgot_password_model.dart';
import 'package:case_management/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../model/login_model.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;
  @POST('/api/user/login')
  Future<UserResponse> login(@Body() Map<String, dynamic> body);

  @GET('/api/user/forgot-password/')
  Future<ForgotPasswordModel> forgotPassword(@Query('cnic') String cnic);
}
