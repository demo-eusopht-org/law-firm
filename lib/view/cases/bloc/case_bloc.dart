import 'dart:developer';
import 'dart:io';

import 'package:case_management/api/case_api/case_api.dart';
import 'package:case_management/api/lawyer_api/lawyer_api.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/dio.dart';
import '../../../utils/constants.dart';
import 'case_events.dart';
import 'case_states.dart';

class CaseBloc extends Bloc<CaseEvent, CaseState> {
  final _caseApi = CaseApi(dio, baseUrl: Constants.baseUrl);
  final _lawyersApi = LawyerApi(dio, baseUrl: Constants.baseUrl);
  CaseBloc() : super(InitialCaseState()) {
    on<CaseEvent>((event, emit) async {
      if (event is GetCasesEvent) {
        await _getCases(emit);
      } else if (event is GetDataCaseEvent) {
        await _getCaseData(emit);
      } else if (event is CreateCaseEvent) {
        await _createCase(event, emit);
      }
    });
  }

  Future<void> _getCases(Emitter<CaseState> emit) async {
    try {
      emit(
        LoadingCaseState(),
      );
      final response = await _caseApi.getAllCases();
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        AllCasesState(
          cases: response.data ?? [],
        ),
      );
    } catch (e, s) {
      log('Exception: $e', stackTrace: s);
      CustomToast.show(e.toString());
      emit(
        InitialCaseState(),
      );
    }
  }

  Future<void> _getCaseData(Emitter<CaseState> emit) async {
    try {
      emit(
        LoadingCaseState(),
      );
      final typesRes = await _caseApi.getCaseType();
      final statusRes = await _caseApi.getCaseStatuses();
      final courtRes = await _caseApi.getCourtTypes();
      final clientData = await _lawyersApi.getAllClients();
      final lawyersData = await _lawyersApi.getLawyers();
      emit(
        DataSuccessCaseState(
          caseTypes: typesRes.data,
          caseStatuses: statusRes.data,
          courtTypes: courtRes.data,
          clients: clientData.data,
          lawyers: lawyersData.lawyers,
        ),
      );
    } catch (e, s) {
      log('Exception: $e', stackTrace: s);
      CustomToast.show(e.toString());
      emit(
        InitialCaseState(),
      );
    }
  }

  Future<void> _createCase(
    CreateCaseEvent event,
    Emitter<CaseState> emit,
  ) async {
    final dataState = (state as DataSuccessCaseState);
    try {
      emit(
        SubmittingCaseState(),
      );
      final response = await _caseApi.createCase({
        'case_no': event.caseNo,
        'plaintiff': event.plaintiff,
        'defendant': event.defendant,
        'plaintiff_advocate': event.plaintiffAdvocate,
        'defendant_advocate': event.defendantAdvocate,
        'court_type': event.courtType.id,
        'case_type': event.caseType.id,
        'case_status': event.caseStatus.id,
        'case_customer_id': event.caseClient.id,
        'is_customer_plaintiff': event.isCustomerPlaintiff,
        'case_filing_date': event.caseFilingDate.millisecondsSinceEpoch,
        'next_hearing_date': event.nextHearingDate.millisecondsSinceEpoch,
        'judge': event.judgeName,
        'court_location': event.courtLocation,
        'year': event.year,
        'case_assigned_to': event.caseLawyer.id,
        'current_proceedings': event.proceedings,
      });
      if (response.status != 200) {
        throw Exception(
          response.message ?? 'Something went wrong while creating case!',
        );
      }
      for (final model in event.files) {
        final fileResponse = await _caseApi.uploadCaseFile(
          case_no: event.caseNo,
          case_file: File(model.file.path),
          file_title: model.title,
        );
        if (fileResponse.status != 200) {
          log('FILE NOT UPLOADED: ${model.title}');
        }
      }
      emit(
        SubmitSuccessCaseState(),
      );
    } catch (e) {
      log('Exception: ${e.toString()}');
      CustomToast.show(e.toString());
      emit(
        dataState,
      );
    }
  }
}
