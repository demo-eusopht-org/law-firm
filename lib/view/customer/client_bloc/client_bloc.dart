import 'package:case_management/api/dio.dart';
import 'package:case_management/api/lawyer_api/lawyer_api.dart';
import 'package:case_management/utils/constants.dart';
import 'package:case_management/view/customer/client_bloc/client_events.dart';
import 'package:case_management/view/customer/client_bloc/client_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/toast.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final _clientApi = LawyerApi(dio, baseUrl: Constants.baseUrl);

  ClientBloc() : super(InitialClientState()) {
    on<ClientEvent>((event, emit) async {
      if (event is CreateClientEvent) {
        await _newClient(event, emit);
      } else if (event is GetClientsEvent) {
        await _getAllClients(event, emit);
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
      if (response.status == 200) {
        emit(
          SuccessClientState(
            newLawyer: response,
          ),
        );
        CustomToast.show(response.message);
      } else
        throw Exception(
          response.message ?? 'Something Went Wrong',
        );
    } catch (e) {
      print(e.toString());
      emit(
        ErrorClientState(
          message: e.toString(),
        ),
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
        CustomToast.show(response.message);
      } else {
        throw Exception(
          response.message ?? 'Something Went Wrong',
        );
      }
    } catch (e) {
      print(e.toString());
      emit(
        ErrorClientState(
          message: e.toString(),
        ),
      );
    }
  }
}
