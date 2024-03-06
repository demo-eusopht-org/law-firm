import 'package:case_management/api/lawyer_api/lawyer_api.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_events.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_states.dart';
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
    } catch (e) {}
  }
}
