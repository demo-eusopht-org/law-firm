abstract class LawyerEvent {}

class CreateNewLawyerEvent extends LawyerEvent {
  final String cnic;
  final String firstName;
  final String lastName;
  final String email;
  final int phoneNumber;
  final int role;
  final String lawyerCredential;
  final String experience;
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
  });
}
