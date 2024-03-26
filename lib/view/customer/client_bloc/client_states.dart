import '../../../model/cases/all_cases_response.dart';
import '../../../model/lawyers/all_clients_response.dart';

abstract class ClientState {}

class InitialClientState extends ClientState {}

class LoadingClientState extends ClientState {}

class SuccessClientState extends ClientState {}

class SuccessClientCasesState extends ClientState {
  final List<Case> cases;

  SuccessClientCasesState({
    required this.cases,
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
