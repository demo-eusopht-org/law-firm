import 'dart:io';

import 'package:case_management/model/permission/all_permissions_response.dart';
import 'package:case_management/model/permission/app_config_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

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

  @GET('/api/config/get-all-permissions')
  Future<AllPermissionsResponse> getAllPermissions();

  @POST('/api/config/change-permission-role')
  Future<GenericResponse> changePermissionRole(
    @Body() Map<String, dynamic> body,
  );

  @GET('/api/config/get-app-config')
  Future<AppConfigResponse> getAppConfig();
}
