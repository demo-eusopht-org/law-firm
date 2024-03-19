import 'dart:io';

import 'package:case_management/model/forgot_password_model.dart';
import 'package:case_management/model/generic_response.dart';
import 'package:case_management/model/version/app_version_model.dart';
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

  @POST('/api/user/change-password')
  Future<GenericResponse> changePassword(@Body() Map<String, dynamic> body);
  @MultiPart()
  @POST('/api/versions/add-new-version')
  Future<GenericResponse> uploadAppVersion({
    @Part() required String version_number,
    @Part() required File apk_file,
    @Part() required String force_update,
    @Part() String? release_notes,
  });

  @GET('/api/versions/get-app-versions')
  Future<AppVersionModel> getAppVersion();

  @GET('/api/user/forgot-password/')
  Future<ForgotPasswordModel> forgotPassword(@Query('cnic') String cnic);
}
