import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../model/generic_response.dart';
import '../../model/permission/get_role_model.dart';
import '../../model/version/app_version_model.dart';
import '../../utils/constants.dart';

part 'config_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class ConfigApi {
  factory ConfigApi(Dio dio, {String baseUrl}) = _ConfigApi;

  @MultiPart()
  @POST('/api/config/add-new-version')
  Future<GenericResponse> uploadAppVersion({
    @Part(name: 'version_number') required String versionNumber,
    @Part(name: 'apk_file') required File apkFile,
    @Part(name: 'force_update') required int forceUpdate,
    @Part(name: 'release_notes') String? releaseNotes,
  });

  @GET('/api/config/get-app-versions')
  Future<AppVersionModel> getAppVersion();

  @GET('/api/config/get-roles')
  Future<GetRoleModel> getRole();

  @POST('/api/config/create-permission')
  Future<GenericResponse> createPermission(@Body() Map<String, dynamic> body);
}
