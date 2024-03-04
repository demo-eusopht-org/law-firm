import 'package:case_management/api/auth/auth_api.dart';
import 'package:case_management/view/auth_screens/auth_bloc/auth_eventes.dart';
import 'package:case_management/view/auth_screens/auth_bloc/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/dio.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _authApi = AuthApi(dio);
  AuthBloc() : super(InitialAuthState()) {
    on<AuthEvent>(
      (event, emit) {
        if (event is LoginEvent) {
          print('hello');
        }
      },
    );
  }
  Future<void> login() async {
    try {
      // _authApi.login();
    } catch (e) {}
  }
}
