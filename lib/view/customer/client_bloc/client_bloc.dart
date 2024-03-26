import 'dart:developer';
import 'dart:io';

import 'package:case_management/api/auth/auth_api.dart';
import 'package:case_management/api/case_api/case_api.dart';
import 'package:case_management/api/dio.dart';
import 'package:case_management/api/lawyer_api/lawyer_api.dart';
import 'package:case_management/utils/constants.dart';
import 'package:case_management/view/customer/client_bloc/client_events.dart';
import 'package:case_management/view/customer/client_bloc/client_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/toast.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final _clientApi = LawyerApi(dio, baseUrl: Constants.baseUrl);
  final _caseApi = CaseApi(dio, baseUrl: Constants.baseUrl);
  final _authApi = AuthApi(dio, baseUrl: Constants.baseUrl);

  ClientBloc() : super(InitialClientState()) {
    on<ClientEvent>((event, emit) async {
      if (event is CreateClientEvent) {
        await _newClient(event, emit);
      } else if (event is GetClientsEvent) {
        await _getAllClients(event, emit);
      } else if (event is GetClientCasesEvent) {
        await _getCasesForClients(event.clientId, emit);
      } else if (event is UpdateClientEvent) {
        await _updateClient(event, emit);
      } else if (event is DeleteClientEvent) {
        await _deleteClient(event.cnic, emit);
      }
    });
  }

  Future<void> _newClient(
    CreateClientEvent event,
    Emitter<ClientState> emit,
  ) async {
    try {
      emit(
        LoadingClientState(),
      );
      final response = await _clientApi.createClient({
        'cnic': event.cnic,
        'first_name': event.firstName,
        'last_name': event.lastName,
        'email': event.email,
        "password": event.password,
        "phone_number": event.phoneNumber,
      });
      if (response.status != 200 || response.clientId == null) {
        throw Exception(response.message);
      }
      if (event.profileImage != null) {
        final imageResponse = await _authApi.uploadUserProfileImage(
          '${response.clientId!}',
          File(event.profileImage!.path),
        );
        if (imageResponse.status != 200) {
          CustomToast.show(response.message);
        }
      }
      emit(
        SuccessClientState(),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      emit(
        ErrorClientState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _updateClient(
    UpdateClientEvent event,
    Emitter<ClientState> emit,
  ) async {
    try {
      emit(
        LoadingClientState(),
      );
      final response = await _clientApi.updateClient({
        'cnic': event.cnic,
        'first_name': event.firstName,
        'last_name': event.lastName,
        'email': event.email,
        'phone_number': event.phoneNumber,
      });
      if (response.status != 200) {
        throw Exception(response.message);
      }
      if (event.profileImage != null) {
        final imageResponse = await _authApi.uploadUserProfileImage(
          '${event.clientId}',
          File(event.profileImage!.path),
        );
        if (imageResponse.status != 200) {
          CustomToast.show(response.message);
        }
      }
      emit(
        SuccessClientState(),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      emit(
        ErrorClientState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _deleteClient(String cnic, Emitter<ClientState> emit) async {
    try {
      emit(
        LoadingClientState(),
      );
      final response = await _clientApi.deleteLawyer({
        'cnic': cnic,
      });
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        DeletedClientState(),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      emit(
        ErrorClientState(message: e.toString()),
      );
    }
  }

  Future<void> _getAllClients(
    GetClientsEvent event,
    Emitter<ClientState> emit,
  ) async {
    try {
      emit(
        LoadingClientState(),
      );
      final response = await _clientApi.getAllClients();
      if (response.status == 200) {
        emit(GetClientState(
          client: response.data,
        ));
      } else {
        throw Exception(
          response.message,
        );
      }
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      emit(
        ErrorClientState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _getCasesForClients(
    int clientId,
    Emitter<ClientState> emit,
  ) async {
    try {
      emit(
        LoadingClientState(),
      );
      final response = await _caseApi.getUserCases(clientId);
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        SuccessClientCasesState(cases: response.data ?? []),
      );
    } catch (e, s) {
      log('Exception: ${e.toString()}', stackTrace: s);
      emit(
        ErrorClientState(message: e.toString()),
      );
    }
  }
}
