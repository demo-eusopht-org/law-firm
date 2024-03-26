abstract class ClientEvent {}

class CreateClientEvent extends ClientEvent {
  final String cnic;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;

  CreateClientEvent({
    required this.cnic,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });
}

class UpdateClientEvent extends ClientEvent {
  final String cnic;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  UpdateClientEvent({
    required this.cnic,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });
}

class GetClientsEvent extends ClientEvent {}

class GetClientCasesEvent extends ClientEvent {
  final int clientId;

  GetClientCasesEvent({
    required this.clientId,
  });
}
