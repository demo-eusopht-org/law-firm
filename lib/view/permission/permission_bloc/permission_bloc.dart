import 'dart:developer';

import 'package:case_management/utils/base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/config/config_api.dart';
import '../../../api/dio.dart';
import '../../../utils/constants.dart';
import '../../../widgets/toast.dart';
import 'permission_events.dart';
import 'permission_state.dart';

class PermissionBloc extends BaseBloc<PermissionEvent, PermissionState> {
  final _configApi = ConfigApi(dio, baseUrl: Constants.baseUrl);
  PermissionBloc() : super(InitialPermissionState()) {
    on<PermissionEvent>(
      (event, emit) async {
        if (event is GetRoleEvent) {
          await _getRole(event, emit);
        } else if (event is CreatePermissionEvent) {
          await _createPermission(event, emit);
        } else if (event is GetConfigPermissionEvent) {
          await _getAppConfig(emit);
        } else if (event is GetAllPermissionsEvent) {
          await _getAllPermissions(emit);
        } else if (event is ChangePermissionEvent) {
          await _changePermissionRole(event, emit);
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
      final response = await _configApi.getRole();
      if (response.status == 200) {
        emit(
          SuccessRolesState(
            roles: response.roles,
          ),
        );
        CustomToast.show(response.message);
      } else {
        throw Exception(
          response.message,
        );
      }
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

  Future<void> _createPermission(
    CreatePermissionEvent event,
    Emitter<PermissionState> emit,
  ) async {
    final previousState = (state as SuccessRolesState);
    try {
      emit(
        LoadingPermissionState(),
      );
      final response = await _configApi.createPermission(
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
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(
        previousState,
      );
    }
  }

  Future<void> _getAppConfig(Emitter<PermissionState> emit) async {
    try {
      final response = await _configApi.getAppConfig();
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        SuccessAppConfigState(data: response.data),
      );
    } catch (e, s) {
      log('Exception: $e', stackTrace: s);
      emit(
        ErrorPermissionState(message: e.toString()),
      );
    }
  }

  Future<void> _getAllPermissions(Emitter<PermissionState> emit) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingPermissionState(),
      );
      final response = await _configApi.getAllPermissions();
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        SuccessAllPermissionState(
          permissions: response.permissions,
        ),
      );
    });
  }

  Future<void> _changePermissionRole(
    ChangePermissionEvent event,
    Emitter<PermissionState> emit,
  ) async {
    await performSafeAction(emit, () async {
      log('DATA: ${event.permissionId} ${event.roleId}');
      final response = await _configApi.changePermissionRole({
        'permission_id': event.permissionId,
        'role_id': event.roleId,
        'enabled': event.enabled ? 1 : 0,
      });
      if (response.status != 200) {
        throw Exception(response.message);
      }
      add(
        GetAllPermissionsEvent(),
      );
    });
  }

  @override
  void onReceiveError(Emitter<PermissionState> emit, String message) {
    emit(
      ErrorPermissionState(message: message),
    );
  }
}
