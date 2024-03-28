import 'dart:io';

import 'package:case_management/model/users/get_notifications_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/generic_response.dart';
import '../../model/lawyers/profile_response.dart';
import '../../model/users/forgot_password_model.dart';
import '../../model/users/login_model.dart';
import '../../utils/constants.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/api/user/login')
  Future<UserResponse> login(@Body() Map<String, dynamic> body);

  @GET('/api/user/logout')
  Future<GenericResponse> logout();

  @POST('/api/user/change-password')
  Future<GenericResponse> changePassword(@Body() Map<String, dynamic> body);

  @GET('/api/user/forgot-password/')
  Future<ForgotPasswordModel> forgotPassword(@Query('cnic') String cnic);

  @GET('/api/user/get-profile')
  Future<ProfileResponse> getUserProfile(@Query('user_id') int userId);

  @MultiPart()
  @POST('/api/lawyers/upload-user-profile')
  Future<GenericResponse> uploadUserProfileImage(
    @Part(name: 'user_id') String userId,
    @Part(name: 'profile_pic') File profilePic,
  );

  @GET('/api/user/get-user-notifications')
  Future<GetNotificationsResponse> getUserNotifications(
      @Query('userId') int userId);
}
