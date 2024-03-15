import 'package:case_management/model/generic_response.dart';

import '../../../model/lawyers/all_clients_response.dart';

abstract class ClientState {}

class InitialClientState extends ClientState {}

class LoadingClientState extends ClientState {}

class SuccessClientState extends ClientState {
  final GenericResponse newLawyer;

  SuccessClientState({
    required this.newLawyer,
  });
}

class GetClientState extends ClientState {
  final List<Client> client;

  GetClientState({
    required this.client,
  });
}

class ErrorClientState extends ClientState {
  final String message;

  ErrorClientState({
    required this.message,
  });
}
