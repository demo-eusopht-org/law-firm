import 'dart:developer';

import 'package:case_management/api/case_api/case_api.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/dio.dart';
import 'case_events.dart';
import 'case_states.dart';

class CaseBloc extends Bloc<CaseEvent, CaseState> {
  final _caseApi = CaseApi(dio);
  CaseBloc() : super(InitialCaseState()) {
    on<CaseEvent>((event, emit) async {
      if (event is GetDataCaseEvent) {
        await _getCaseData(emit);
      }
    });
  }

  Future<void> _getCaseData(Emitter<CaseState> emit) async {
    try {
      emit(
        LoadingCaseState(),
      );
      final typesRes = await _caseApi.getCaseType();
      final statusRes = await _caseApi.getCaseStatuses();
      final courtRes = await _caseApi.getCourtTypes();
      emit(
        DataSuccessCaseState(
          caseTypes: typesRes.data,
          caseStatuses: statusRes.data,
          courtTypes: courtRes.data,
        ),
      );
    } catch (e, s) {
      log('Exception: $e', stackTrace: s);
      CustomToast.show(e.toString());
    }
  }
}
