import '../../../model/open_file_model.dart';

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

class UpdateVersionEvent extends ProfileEvent {
  final double version_number;
  final int force_update;
  final String release_notes;
  final List<OpenFileModel> files;

  UpdateVersionEvent({
    required this.version_number,
    required this.force_update,
    required this.release_notes,
    required this.files,
  });
}
