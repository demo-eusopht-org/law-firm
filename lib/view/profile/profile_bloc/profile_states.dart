import 'package:case_management/model/generic_response.dart';
import 'package:case_management/model/lawyers/profile_response.dart';
import 'package:case_management/model/version/app_version_model.dart';

abstract class ProfileState {}

class InitialProfileState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class SuccessProfileState extends ProfileState {
  final GenericResponse response;

  SuccessProfileState({
    required this.response,
  });
}

class VersionSuccessProfileState extends ProfileState {
  final List<Versions> data;

  VersionSuccessProfileState({
    required this.data,
  });
}

class ErrorProfileState extends ProfileState {
  final String message;

  ErrorProfileState({
    required this.message,
  });
}

class GotProfileState extends ProfileState {
  final Profile profile;
  final bool imageUploadLoading;

  GotProfileState({
    required this.profile,
    required this.imageUploadLoading,
  });

  GotProfileState copyWith({
    Profile? profile,
    bool? imageUploadLoading,
  }) {
    return GotProfileState(
      profile: profile ?? this.profile,
      imageUploadLoading: imageUploadLoading ?? this.imageUploadLoading,
    );
  }
}
