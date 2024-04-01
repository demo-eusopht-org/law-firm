import 'dart:developer';
import 'dart:io';

import 'package:case_management/utils/base_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/auth/auth_api.dart';
import '../../../api/config/config_api.dart';
import '../../../api/dio.dart';
import '../../../services/local_storage_service.dart';
import '../../../services/locator.dart';
import '../../../utils/constants.dart';
import '../../../widgets/toast.dart';
import 'profile_events.dart';
import 'profile_states.dart';

class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
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
        } else if (event is UpdateNotificationEvent) {
          await _updateNotificationStatus(event.notificationsEnabled, emit);
        } else if (event is GetAllVersionsEvent) {
          await _getAllVersions(event, emit);
        } else if (event is LogoutProfileEvent) {
          await _logout(emit);
        }
      },
    );
  }

  Future<void> _resetPassword(
    UpdatePasswordEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingProfileState(),
      );
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
    });
  }

  Future<void> _updateVersion(
    UpdateVersionEvent event,
    Emitter<ProfileState> emit,
  ) async {
    await performSafeAction(emit, () async {
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
        emit(
          SuccessProfileState(response: response),
        );
        CustomToast.show(response.message);
      } else {
        throw Exception(
          response.message ?? 'Something Went Wrong',
        );
      }
    });
  }

  Future<void> _updateNotificationStatus(
    bool notificationStatus,
    Emitter<ProfileState> emit,
  ) async {
    final previousState = (state as GotProfileState);
    try {
      emit(
        LoadingProfileState(),
      );
      final response = await _authApi.changeNotificationStatus(
        notificationStatus ? 1 : 0,
      );
      if (response.status != 200) {
        throw Exception(response.message);
      }
      CustomToast.show(response.message);
      final updatedProfile = previousState.profile.changeNotificationStatus(
        notificationStatus,
      );
      emit(
        previousState.copyWith(
          profile: updatedProfile,
        ),
      );
    } on DioException catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(
        '${e.response!.statusCode}: ${e.response!.statusMessage}',
      );
      emit(previousState);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(previousState);
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
        '$userId',
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

  Future<void> _logout(Emitter<ProfileState> emit) async {
    final previousState = (state as GotProfileState);
    try {
      emit(LoadingProfileState());
      final response = await _authApi.logout();
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        LogoutProfileState(),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(previousState);
    }
  }

  @override
  void onReceiveError(Emitter<ProfileState> emit, String message) {
    CustomToast.show(message);
    emit(
      InitialProfileState(),
    );
  }
}
