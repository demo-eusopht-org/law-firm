import 'dart:developer';

import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/case_api/case_api.dart';
import '../../../api/dio.dart';
import '../../../model/cases/all_cases_response.dart';
import '../../../utils/constants.dart';
import 'cause_events.dart';
import 'cause_states.dart';

class CauseBloc extends Bloc<CauseEvent, CauseState> {
  final _caseApi = CaseApi(dio, baseUrl: Constants.baseUrl);
  final List<Case> _cases = [];

  CauseBloc() : super(InitialCauseState()) {
    on<CauseEvent>((event, emit) async {
      if (event is GetCauseListEvent) {
        await _getCauseList(emit);
      } else if (event is ChangeDateCauseEvent) {
        _changeDateForCases(event.date, emit);
      }
    });
  }

  Future<void> _getCauseList(
    Emitter<CauseState> emit,
  ) async {
    try {
      emit(
        LoadingCauseState(),
      );
      final response = await _caseApi.getAllCases();
      if (response.status != 200 || response.data == null) {
        throw Exception(response.message);
      }
      _cases.clear();
      final temp = response.data ?? [];
      _cases.addAll(List.of(temp));
      temp.removeWhere((element) {
        return !element.nextHearingDate.isToday;
      });
      emit(
        SuccessCauseState(cases: temp),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(InitialCauseState());
    }
  }

  void _changeDateForCases(DateTime? date, Emitter<CauseState> emit) {
    if (date == null) {
      emit(
        SuccessCauseState(
          cases: _cases.where((data) {
            return data.nextHearingDate.isToday;
          }).toList(),
        ),
      );
      return;
    }
    final filteredCases = _cases.where((_case) {
      return _case.nextHearingDate.year == date.year &&
          _case.nextHearingDate.month == date.month &&
          _case.nextHearingDate.day == date.day;
    }).toList();
    log('Filtered: ${_cases.length} ${filteredCases.length}');
    emit(
      SuccessCauseState(cases: filteredCases),
    );
  }
}
