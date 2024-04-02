import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/auth/auth_api.dart';
import '../../../api/dio.dart';
import '../../../api/lawyer_api/lawyer_api.dart';
import '../../../utils/constants.dart';
import '../../../widgets/toast.dart';
import 'lawyer_events.dart';
import 'lawyer_states.dart';

class LawyerBloc extends Bloc<LawyerEvent, LawyerState> {
  final _lawyerApi = LawyerApi(dio, baseUrl: Constants.baseUrl);
  final _authApi = AuthApi(dio, baseUrl: Constants.baseUrl);

  LawyerBloc() : super(InitialLawyerState()) {
    on<LawyerEvent>((event, emit) async {
      if (event is CreateNewLawyerEvent) {
        await _createLawyer(event, emit);
      } else if (event is GetLawyersEvent) {
        await _getLawyers(event, emit);
      } else if (event is DeleteLawyerEvent) {
        await _deleteLawyer(event, emit);
      } else if (event is UpdateLawyerEvent) {
        await _updateLawyer(event, emit);
      }
    });
  }

  Future<void> _createLawyer(
    CreateNewLawyerEvent event,
    Emitter<LawyerState> emit,
  ) async {
    try {
      emit(
        LoadingLawyerState(),
      );
      final response = await _lawyerApi.createLawyer({
        'cnic': event.cnic,
        'first_name': event.firstName,
        'last_name': event.lastName,
        'email': event.email,
        'password': event.password,
        'phone_number': event.phoneNumber,
        'role': 2,
        'lawyer_credentials': event.lawyerCredential,
        'expertise': event.expertise,
        'lawyer_bio': event.lawyerBio,
        'experience': event.experience.map((e) => e.toJson()).toList(),
        'qualification': event.qualification.map((e) => e.toJson()).toList(),
      });
      if (response.status != 200 || response.lawyerId == null) {
        throw Exception(
          response.message,
        );
      }
      if (event.profileImage != null) {
        final imageResponse = await _authApi.uploadUserProfileImage(
          '${response.lawyerId}',
          File(
            event.profileImage!.path,
          ),
        );
        if (imageResponse.status != 200) {
          CustomToast.show(imageResponse.message);
        }
      }
      emit(
        SuccessLawyerState(),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      emit(
        ErrorLawyerState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _getLawyers(
    GetLawyersEvent event,
    Emitter<LawyerState> emit,
  ) async {
    try {
      emit(
        LoadingLawyerState(),
      );
      final response = await _lawyerApi.getLawyers();
      if (response.status != 200) {
        throw Exception(
          response.message,
        );
      }
      emit(
        GetLawyersState(
          lawyers: response.lawyers,
        ),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      emit(
        ErrorLawyerState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _deleteLawyer(
    DeleteLawyerEvent event,
    Emitter<LawyerState> emit,
  ) async {
    try {
      emit(
        LoadingLawyerState(),
      );
      final response = await _lawyerApi.deleteLawyer({
        'cnic': event.cnic,
      });
      if (response.status == 200) {
        emit(
          ForgotSucessLawyerState(
            forgotResponse: response,
          ),
        );
        add(GetLawyersEvent());
        CustomToast.show(response.message);
      } else {
        throw Exception(
          response.message ?? 'Something Went Wrong',
        );
      }
    } catch (e) {
      emit(
        ErrorLawyerState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _updateLawyer(
    UpdateLawyerEvent event,
    Emitter<LawyerState> emit,
  ) async {
    try {
      emit(
        LoadingLawyerState(),
      );
      final response = await _lawyerApi.updateLawyer({
        'user_id': event.userId,
        'first_name': event.firstName,
        'last_name': event.lastName,
        'email': event.email,
        'password': event.password,
        'phone_number': event.phoneNumber,
        'role': 2,
        'lawyer_credentials': event.lawyerCredential,
        'expertise': event.expertise,
        'lawyer_bio': event.lawyerBio,
        'experience': event.experience,
        'qualification': event.qualification,
      });
      if (response.status != 200) {
        throw Exception(
          response.message ?? 'Something Went Wrong',
        );
      }
      if (event.profileImage != null) {
        final imageResponse = await _authApi.uploadUserProfileImage(
          event.userId,
          File(
            event.profileImage!.path,
          ),
        );
        if (imageResponse.status != 200) {
          CustomToast.show(imageResponse.message);
        }
      }
      emit(
        SuccessUpdateLawyerState(
          lawyer: response.data!,
        ),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      emit(
        ErrorLawyerState(
          message: e.toString(),
        ),
      );
    }
  }
}
