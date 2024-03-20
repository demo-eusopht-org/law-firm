import 'package:file_picker/file_picker.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

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
  final String version_number;
  final String force_update;
  final String release_notes;
  final PlatformFile file;

  UpdateVersionEvent({
    required this.version_number,
    required this.force_update,
    required this.release_notes,
    required this.file,
  });
}

class GetAllVersionsEvent extends ProfileEvent {}
