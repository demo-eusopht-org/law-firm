import 'package:image_picker/image_picker.dart';

abstract class ClientEvent {}

class CreateClientEvent extends ClientEvent {
  final String cnic;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final XFile? profileImage;

  CreateClientEvent({
    required this.cnic,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.profileImage,
  });
}

class UpdateClientEvent extends ClientEvent {
  final int clientId;
  final String cnic;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final XFile? profileImage;

  UpdateClientEvent({
    required this.clientId,
    required this.cnic,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.profileImage,
  });
}

class DeleteClientEvent extends ClientEvent {
  final String cnic;

  DeleteClientEvent({
    required this.cnic,
  });
}

class GetClientsEvent extends ClientEvent {}

class GetClientCasesEvent extends ClientEvent {
  final int clientId;

  GetClientCasesEvent({
    required this.clientId,
  });
}
