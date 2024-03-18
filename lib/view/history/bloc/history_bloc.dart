import 'dart:developer';

import 'package:case_management/api/case_api/case_api.dart';
import 'package:case_management/api/lawyer_api/lawyer_api.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/dio.dart';
import '../../../utils/constants.dart';
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
        await _getCaseHistory(event.caseNo, emit);
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
    String caseNo,
    Emitter<HistoryState> emit,
  ) async {
    try {
      emit(
        LoadingHistoryState(),
      );
      final response = await _caseApi.getCaseHistory({
        'case_no': caseNo,
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
}
