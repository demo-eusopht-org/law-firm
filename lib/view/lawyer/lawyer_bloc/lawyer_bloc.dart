import 'dart:developer';

import 'package:case_management/api/lawyer_api/lawyer_api.dart';
import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_events.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_states.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/dio.dart';

class LawyerBloc extends Bloc<LawyerEvent, LawyerState> {
  final _lawyerApi = LawyerApi(dio);

  LawyerBloc() : super(InitialLawyerState()) {
    on<LawyerEvent>((event, emit) async {
      if (event is CreateNewLawyerEvent) {
        await _createLawyer(event, emit);
      } else if (event is GetLawyersEvent) {
        await _getLawyers(event, emit);
      } else if (event is DeleteLawyerEvent) {
        await _deletelawyers(event, emit);
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
      print('${event.expertise}');
      final token = await locator<LocalStorageService>().getData('token');
      if (token != null) {
        final lawyerResponse = await _lawyerApi.createLawyer(
          'Bearer ${token}',
          {
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
            'experience': event.experience,
            'qualification': event.qualification,
          },
        );
        if (lawyerResponse.status == 200) {
          emit(
            SuccessLawyerState(
              newLawyer: lawyerResponse,
            ),
          );
          CustomToast.show(lawyerResponse.message);
        } else {
          throw Exception(
            lawyerResponse.message ?? 'Something Went Wrong',
          );
        }
      } else {
        CustomToast.show('Token is Invalid');
        emit(ErrorLawyerState(message: 'Something went wrong'));
      }
    } catch (e) {
      print(e.toString());
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
      final token = await locator<LocalStorageService>().getData('token');

      if (token != null) {
        final response = await _lawyerApi.getLawyers(
          'Bearer ${token}',
        );
        if (response.status == 200) {
          log('RRR: ${response.lawyers.length}');
          emit(
            GetLawyersState(
              lawyers: response.lawyers,
            ),
          );
          CustomToast.show(response.message);
        } else {
          throw Exception(
            response.message ?? 'Something Went Wrong',
          );
        }
      }
    } catch (e) {
      print(e.toString());
      emit(
        ErrorLawyerState(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _deletelawyers(
    DeleteLawyerEvent event,
    Emitter<LawyerState> emit,
  ) async {
    try {
      emit(
        LoadingLawyerState(),
      );
      final token = await locator<LocalStorageService>().getData('token');
      final response = await _lawyerApi.deleteLawyer(
        'Bearer ${token}',
        {
          'cnic': event.cnic,
        },
      );
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
      print('${event.expertise}');
      final token = await locator<LocalStorageService>().getData('token');
      if (token != null) {
        final response = await _lawyerApi.updateLawyer(
          'Bearer ${token}',
          {
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
          },
        );
        if (response.status == 200) {
          emit(
            GetLawyersState(
              lawyers: response.lawyers,
            ),
          );
          CustomToast.show(response.message);
        } else {
          throw Exception(
            response.message ?? 'Something Went Wrong',
          );
        }
      } else {
        CustomToast.show('Token is Invalid');
        emit(ErrorLawyerState(message: 'Something went wrong'));
      }
    } catch (e) {
      print(e.toString());
      emit(
        ErrorLawyerState(
          message: e.toString(),
        ),
      );
    }
  }
}
