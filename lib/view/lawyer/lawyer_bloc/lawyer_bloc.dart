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
    on<CreateNewLawyerEvent>(
      (event, emit) async {
        await _createLawyer(event, emit);
      },
    );
  }

  Future<void> _createLawyer(
    CreateNewLawyerEvent event,
    Emitter<LawyerState> emit,
  ) async {
    try {
      emit(
        LoadingLawyerState(),
      );
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
}
