import 'dart:io';

import 'package:case_management/model/forgot_password_model.dart';
import 'package:case_management/model/generic_response.dart';
import 'package:case_management/model/version/app_version_model.dart';
import 'package:case_management/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../model/lawyers/profile_response.dart';
import '../../model/login_model.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;
  @POST('/api/user/login')
  Future<UserResponse> login(@Body() Map<String, dynamic> body);

  @POST('/api/user/change-password')
  Future<GenericResponse> changePassword(@Body() Map<String, dynamic> body);

  @GET('/api/user/forgot-password/')
  Future<ForgotPasswordModel> forgotPassword(@Query('cnic') String cnic);

  @GET('/api/user/get-profile')
  Future<ProfileResponse> getUserProfile(@Query('user_id') int userId);

  @MultiPart()
  @POST('/api/lawyers/upload-user-profile')
  Future<GenericResponse> uploadUserProfileImage(
    @Part() String user_id,
    @Part() File profile_pic,
  );
}
