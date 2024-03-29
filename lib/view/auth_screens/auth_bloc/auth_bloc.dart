import 'dart:developer';

import 'package:case_management/api/auth/auth_api.dart';
import 'package:case_management/api/config/config_api.dart';
import 'package:case_management/services/device_service.dart';
import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/services/messaging_service.dart';
import 'package:case_management/view/auth_screens/auth_bloc/auth_eventes.dart';
import 'package:case_management/view/auth_screens/auth_bloc/auth_states.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/dio.dart';
import '../../../utils/constants.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authApi = AuthApi(dio, baseUrl: Constants.baseUrl);
  final _configApi = ConfigApi(dio, baseUrl: Constants.baseUrl);
  AuthBloc() : super(InitialAuthState()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          await _login(event, emit);
        } else if (event is ForgotEvent) {
          await _userforgotPassword(event, emit);
        }
      },
    );
  }
  Future<void> _login(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(
        LoadingAuthState(),
      );
      final deviceId = await locator<DeviceService>().getDeviceId();
      final token = await locator<MessagingService>().getToken();
      final userResponse = await _authApi.login({
        'cnic': event.cnic,
        'password': event.password,
        'device_id': deviceId,
        'token': token,
      });
      if (userResponse.status == 200) {
        CustomToast.show(userResponse.message);
        if (userResponse.token != null) {
          await locator<LocalStorageService>().saveData(
            'token',
            userResponse.token!,
          );
        }
        await locator<LocalStorageService>().saveData(
          'role',
          userResponse.data!.roleName,
        );
        await locator<LocalStorageService>().saveData(
          'id',
          userResponse.data!.id,
        );
        await locator<LocalStorageService>().saveData(
          'cnic',
          userResponse.data!.cnic,
        );
        await locator<LocalStorageService>().saveData(
          'name',
          userResponse.data!.displayName,
        );
        await _saveConfig();
        emit(
          SuccessAuthState(
            response: userResponse,
          ),
        );
      } else {
        throw Exception(
          userResponse.message ?? 'Something Went Wrong',
        );
      }
    } on DioException catch (e, s) {
      log(e.toString(), stackTrace: s);
      emit(
        ErrorAuthState(
          message: '${e.response!.statusCode}: ${e.response!.statusMessage}',
        ),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      emit(
        ErrorAuthState(
          message: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }

  Future<void> _saveConfig() async {
    final response = await _configApi.getAppConfig();
    if (response.status != 200) {
      throw Exception(response.message);
    }
    final permissions = response.data.where((config) {
      return config.isAllowed;
    }).toList();
    configNotifier.value = permissions
        .map(
          (e) => e.permissionName,
        )
        .toList();
  }

  Future<void> _userforgotPassword(
    ForgotEvent fEvent,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(
        LoadingAuthState(),
      );
      print('${fEvent.cnic}');
      final forgotResponse = await _authApi.forgotPassword(
        fEvent.cnic,
      );
      if (forgotResponse.status == 200) {
        emit(
          ForgotSuccessAuthState(
            forgotResponse: forgotResponse,
          ),
        );
        CustomToast.show(forgotResponse.message);
      } else {
        throw Exception(
          forgotResponse.message ?? 'Something Went Wrong',
        );
      }
    } catch (e) {
      emit(
        ErrorAuthState(
          message: e.toString(),
        ),
      );
    }
  }
}
