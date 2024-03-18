abstract class ProfileEvent {}

class UpdatePasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;
  final String cnic;

  UpdatePasswordEvent({
    required this.oldPassword,
    required this.newPassword,
    required this.cnic,
  });
}
