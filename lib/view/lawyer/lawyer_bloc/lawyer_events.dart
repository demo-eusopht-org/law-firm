import 'package:case_management/model/lawyer_request_model.dart';

abstract class LawyerEvent {}

class CreateNewLawyerEvent extends LawyerEvent {
  final String cnic;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String role;
  final String lawyerCredential;
  final List<Exp> experience;
  final List<Qualification> qualification;
  final String expertise;
  final String lawyerBio;
  final String password;

  CreateNewLawyerEvent({
    required this.cnic,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.lawyerCredential,
    required this.experience,
    required this.expertise,
    required this.lawyerBio,
    required this.password,
    required this.qualification,
  });
}

class GetLawyersEvent extends LawyerEvent {}

class DeleteLawyerEvent extends LawyerEvent {
  final String cnic;

  DeleteLawyerEvent({
    required this.cnic,
  });
}

class UpdateLawyerEvent extends LawyerEvent {
  final int userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String role;
  final String lawyerCredential;
  final List<Exp> experience;
  final List<Qualification> qualification;
  final String expertise;
  final String lawyerBio;
  final String password;

  UpdateLawyerEvent({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.lawyerCredential,
    required this.experience,
    required this.expertise,
    required this.lawyerBio,
    required this.password,
    required this.qualification,
  });
}
