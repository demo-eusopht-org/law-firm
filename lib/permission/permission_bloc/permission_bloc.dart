import 'dart:developer';

import 'package:case_management/api/permission_api/permission_api.dart';
import 'package:case_management/permission/permission_bloc/permission_events.dart';
import 'package:case_management/permission/permission_bloc/permission_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/dio.dart';
import '../../../utils/constants.dart';
import '../../widgets/toast.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  final _permissionApi = PermissionApi(dio, baseUrl: Constants.baseUrl);
  PermissionBloc() : super(InitialPermissionState()) {
    on<PermissionEvent>(
      (event, emit) async {
        if (event is GetRoleEvent) {
          await _getRole(event, emit);
        } else if (event is FetchRolesEvent) {
          await createPermission(event, emit);
        }
      },
    );
  }
  Future<void> _getRole(
    GetRoleEvent event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      emit(
        LoadingPermissionState(),
      );
      final response = await _permissionApi.getRole();
      if (response.status == 200) {
        emit(
          SuccessPermissionState(
            roles: response.roles,
          ),
        );
        CustomToast.show(response.message);
      } else
        throw Exception(
          response.message ?? 'Something went went wrong',
        );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(
        ErrorPermissionState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> createPermission(
    FetchRolesEvent event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      emit(
        LoadingPermissionState(),
      );
      final response = await _permissionApi.createPermission(
        {
          'permission_name': event.permissionName,
          'role_ids': event.roleIds,
        },
      );
      if (response.status == 200) {
        emit(
          CreatePermissionState(response: response),
        );
      } else {
        throw Exception(response.message ?? 'Something went wrong');
      }
    } catch (e) {
      emit(
        ErrorPermissionState(
          message: e.toString(),
        ),
      );
    }
  }
}
