import 'dart:io';

import 'package:case_management/view/profile/profile_bloc/profile_events.dart';
import 'package:case_management/view/profile/profile_bloc/profile_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/auth/auth_api.dart';
import '../../../api/dio.dart';
import '../../../utils/constants.dart';
import '../../../widgets/toast.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _authApi = AuthApi(dio, baseUrl: Constants.baseUrl);

  ProfileBloc() : super(InitialProfileState()) {
    on<ProfileEvent>(
      (event, emit) async {
        if (event is UpdatePasswordEvent) {
          await resetPassword(event, emit);
        } else if (event is UpdateVersionEvent) {
          await updateVersion(event, emit);
        } else if (event is GetAllVersionsEvent) {
          await getAllverions(emit);
        }
      },
    );
  }

  Future<void> resetPassword(
    UpdatePasswordEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
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
      } else
        throw Exception(
          response.message ?? 'Something Went Wrong',
        );
    } catch (e) {
      emit(
        ErrorProfileState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> updateVersion(
    UpdateVersionEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(
        LoadingProfileState(),
      );
      final model = event.file;
      final response = await _authApi.uploadAppVersion(
        apk_file: File(model.path!),
        force_update: event.force_update,
        version_number: event.version_number,
        release_notes: event.release_notes,
      );
      if (response.status == 200) {
        // log(
        //   'FILE NOT UPLOADED: ${model.title}',
        // );
        emit(
          SuccessProfileState(response: response),
        );
        CustomToast.show(response.message);
      } else
        throw Exception(
          response.message ?? 'Something Went Wrong',
        );
    } catch (e) {
      emit(
        ErrorProfileState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> getAllverions(
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(LoadingProfileState());
      final response = await _authApi.getAppVersion();
      print('hello');
      if (response.status == 200) {
        emit(VersionSuccessProfileState(
          data: response.versions,
        ));
        CustomToast.show(response.message);
      } else {
        throw Exception(
          response.message ?? 'Something Went Wrong',
        );
      }
    } catch (e) {
      emit(
        ErrorProfileState(
          message: e.toString(),
        ),
      );
    }
  }
}
