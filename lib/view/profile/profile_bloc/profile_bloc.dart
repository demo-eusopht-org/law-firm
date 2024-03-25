import 'dart:developer';
import 'dart:io';

import 'package:case_management/api/config/config_api.dart';
import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/view/profile/profile_bloc/profile_events.dart';
import 'package:case_management/view/profile/profile_bloc/profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/auth/auth_api.dart';
import '../../../api/dio.dart';
import '../../../utils/constants.dart';
import '../../../widgets/toast.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _authApi = AuthApi(dio, baseUrl: Constants.baseUrl);
  final _configApi = ConfigApi(dio, baseUrl: Constants.baseUrl);

  ProfileBloc() : super(InitialProfileState()) {
    on<ProfileEvent>(
      (event, emit) async {
        if (event is UpdatePasswordEvent) {
          await _resetPassword(event, emit);
        } else if (event is UpdateVersionEvent) {
          await _updateVersion(event, emit);
        } else if (event is GetProfileEvent) {
          await _getUserProfile(emit);
        } else if (event is ChangeProfileImageEvent) {
          await _updateProfileImage(event.image, emit);
        } else if (event is GetAllVersionsEvent) {
          await _getAllVersions(event, emit);
        }
      },
    );
  }

  Future<void> _resetPassword(
    UpdatePasswordEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(
        LoadingProfileState(),
      );
      if (event.newPassword != event.oldPassword) {
        throw Exception("New password and old password don't match");
      }
      final response = await _authApi.changePassword(
        {
          'old_password': event.oldPassword,
          'new_password': event.newPassword,
          'cnic': event.cnic,
        },
      );
      if (response.status == 200) {
        emit(SuccessProfileState(response: response));
        CustomToast.show(response.message);
      } else {
        throw Exception(
          response.message ?? 'Something Went Wrong',
        );
      }
    } catch (e, s) {
      log('Exception: ${e.toString()}', stackTrace: s);
      CustomToast.show(e.toString());
    }
  }

  Future<void> _updateVersion(
    UpdateVersionEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(
        LoadingProfileState(),
      );
      final model = event.file;
      final response = await _configApi.uploadAppVersion(
        apkFile: File(model.path!),
        forceUpdate: event.forceUpdate ? 1 : 0,
        versionNumber: event.versionNumber,
        releaseNotes: event.releaseNotes,
      );
      if (response.status == 200) {
        // log(
        //   'FILE NOT UPLOADED: ${model.title}',
        // );
        emit(
          SuccessProfileState(response: response),
        );
        CustomToast.show(response.message);
      } else {
        throw Exception(
          response.message ?? 'Something Went Wrong',
        );
      }
    } catch (e, s) {
      log('Exception: ${e.toString()}', stackTrace: s);
      CustomToast.show(e.toString());
      emit(InitialProfileState());
    }
  }

  Future<void> _getAllVersions(
    GetAllVersionsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(LoadingProfileState());
      final response = await _configApi.getAppVersion();
      if (response.status == 200) {
        emit(
          VersionSuccessProfileState(
            data: response.versions,
          ),
        );
        CustomToast.show(response.message);
      } else {
        throw Exception(
          response.message,
        );
      }
    } catch (e, s) {
      log('Exception: ${e.toString()}', stackTrace: s);
      CustomToast.show(e.toString());
    }
  }

  Future<void> _getUserProfile(Emitter<ProfileState> emit) async {
    try {
      emit(
        LoadingProfileState(),
      );
      final data = locator<LocalStorageService>().getData('id');
      final userId = data ?? '';
      final response = await _authApi.getUserProfile(userId!);
      if (response.status != 200 || response.user == null) {
        throw Exception(response.message);
      }
      emit(
        GotProfileState(
          profile: response.user!,
          imageUploadLoading: false,
        ),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(InitialProfileState());
    }
  }

  Future<void> _updateProfileImage(
    XFile file,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(
        (state as GotProfileState).copyWith(
          imageUploadLoading: true,
        ),
      );
      final userId = locator<LocalStorageService>().getData('id');
      final response = await _authApi.uploadUserProfileImage(
        userId!,
        File(file.path),
      );
      if (response.status != 200) {
        throw Exception(response.message);
      }
      CustomToast.show(response.message);
      add(
        GetProfileEvent(),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(
        (state as GotProfileState).copyWith(
          imageUploadLoading: false,
        ),
      );
    }
  }
}
