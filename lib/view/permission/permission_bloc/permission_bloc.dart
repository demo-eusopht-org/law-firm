import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/config/config_api.dart';
import '../../../api/dio.dart';
import '../../../utils/constants.dart';
import '../../../widgets/toast.dart';
import 'permission_events.dart';
import 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  final _configApi = ConfigApi(dio, baseUrl: Constants.baseUrl);
  PermissionBloc() : super(InitialPermissionState()) {
    on<PermissionEvent>(
      (event, emit) async {
        if (event is GetRoleEvent) {
          await _getRole(event, emit);
        } else if (event is CreatePermissionEvent) {
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

  Future<void> createPermission(
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
}
