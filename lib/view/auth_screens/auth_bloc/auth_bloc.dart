import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/auth/auth_api.dart';
import '../../../api/config/config_api.dart';
import '../../../api/dio.dart';
import '../../../services/device_service.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/locator.dart';
import '../../../services/messaging_service.dart';
import '../../../utils/base_bloc.dart';
import '../../../utils/constants.dart';
import '../../../widgets/toast.dart';
import 'auth_eventes.dart';
import 'auth_states.dart';

class AuthBloc extends BaseBloc<AuthEvent, AuthState> {
  final _authApi = AuthApi(dio, baseUrl: Constants.baseUrl);
  final _configApi = ConfigApi(dio, baseUrl: Constants.baseUrl);

  AuthBloc() : super(InitialAuthState()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is LoginEvent) {
          await _login(event, emit);
        } else if (event is ForgotEvent) {
          await _userForgotPassword(event, emit);
        }
      },
    );
  }

  Future<void> _login(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    await performSafeAction(emit, () async {
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
    });
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

  Future<void> _userForgotPassword(
    ForgotEvent fEvent,
    Emitter<AuthState> emit,
  ) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingAuthState(),
      );
      final forgotResponse = await _authApi.forgotPassword(
        fEvent.cnic,
      );
      if (forgotResponse.status != 200) {
        throw Exception(
          forgotResponse.message ?? 'Something Went Wrong',
        );
      }
      emit(
        ForgotSuccessAuthState(
          forgotResponse: forgotResponse,
        ),
      );
      CustomToast.show(forgotResponse.message);
    });
  }

  @override
  void onReceiveError(Emitter<AuthState> emit, String message) {
    emit(
      ErrorAuthState(
        message: message,
      ),
    );
  }
}
