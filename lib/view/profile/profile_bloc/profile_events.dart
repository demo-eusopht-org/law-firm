import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}

class ChangeProfileImageEvent extends ProfileEvent {
  final XFile image;

  ChangeProfileImageEvent({
    required this.image,
  });
}

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
  final String versionNumber;
  final bool forceUpdate;
  final String releaseNotes;
  final PlatformFile file;

  UpdateVersionEvent({
    required this.versionNumber,
    required this.forceUpdate,
    required this.releaseNotes,
    required this.file,
  });
}

class GetAllVersionsEvent extends ProfileEvent {}
