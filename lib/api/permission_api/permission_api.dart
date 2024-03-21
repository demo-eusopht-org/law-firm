import 'package:case_management/model/generic_response.dart';
import 'package:case_management/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../model/permission/get_role_model.dart';

part 'permission_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class PermissionApi {
  factory PermissionApi(Dio dio, {String baseUrl}) = _PermissionApi;

  @GET('/api/user/get-roles')
  Future<GetRoleModel> getRole();

  @POST('/api/user/create-permission')
  Future<GenericResponse> createPermission(@Body() Map<String, dynamic> body);
}
