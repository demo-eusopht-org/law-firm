import 'dart:developer';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/case_api/case_api.dart';
import '../../../api/dio.dart';
import '../../../api/lawyer_api/lawyer_api.dart';
import '../../../model/cases/all_cases_response.dart';
import '../../../utils/constants.dart';
import '../../../widgets/toast.dart';
import 'history_events.dart';
import 'history_states.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final _caseApi = CaseApi(dio, baseUrl: Constants.baseUrl);
  final _lawyersApi = LawyerApi(dio, baseUrl: Constants.baseUrl);

  HistoryBloc() : super(InitialHistoryState()) {
    on<HistoryEvent>((event, emit) async {
      if (event is GetDataHistoryEvent) {
        await _getData(emit);
      } else if (event is GetHistoryEvent) {
        await _getCaseHistory(event.caseData, emit);
      } else if (event is CreateProceedingEvent) {
        await _createProceeding(event, emit);
      }
    });
  }

  Future<void> _getData(Emitter<HistoryState> emit) async {
    try {
      emit(
        LoadingHistoryState(),
      );
      final statusResponse = await _caseApi.getCaseStatuses();
      final lawyersResponse = await _lawyersApi.getLawyers();
      emit(
        DataSuccessState(
          statuses: statusResponse.data,
          lawyers: lawyersResponse.lawyers,
        ),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(InitialHistoryState());
    }
  }

  Future<void> _getCaseHistory(
    Case caseData,
    Emitter<HistoryState> emit,
  ) async {
    try {
      emit(
        LoadingHistoryState(),
      );
      final response = await _caseApi.getCaseHistory({
        'case_no': caseData.caseNo,
      });
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        SuccessGetHistoryState(
          history: response.history,
        ),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString().replaceAll('Exception: ', ''));
      emit(
        InitialHistoryState(),
      );
    }
  }

  Future<void> _createProceeding(
    CreateProceedingEvent event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      emit(
        LoadingHistoryState(),
      );
      final response = await _caseApi.createProceeding({
        'case_no': event.caseNo,
        'judge_name': event.judgeName,
        'case_status': event.status.id,
        'case_proceedings': event.proceedings,
        'opposite_party_advocate': event.oppositePartyLawyer,
        'next_hearing_date': event.nextHearingDate.millisecondsSinceEpoch,
        'next_assignee_id': event.nextAssignee?.id,
        'assignee_switch_reason': event.assigneeSwitchReason,
      });
      if (response.status != 200) {
        throw Exception(response.message);
      }
      for (final file in event.files) {
        final uploadResponse = await _caseApi.uploadCaseFile(
          caseNo: event.caseNo,
          caseFile: File(file.file.path),
          fileTitle: file.title,
          caseHistoryId: response.proceedingId,
        );
        if (uploadResponse.status != 200) {
          CustomToast.show('Could not upload ${file.title}');
        }
      }
      emit(
        SuccessCreateProceedingState(),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      add(
        GetDataHistoryEvent(),
      );
    }
  }
}
