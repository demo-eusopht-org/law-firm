import 'package:case_management/model/get_all_lawyers_model.dart';

import '../../../model/cases/case_history_response.dart';
import '../../../model/cases/case_status.dart';

abstract class HistoryState {}

class InitialHistoryState extends HistoryState {}

class LoadingHistoryState extends HistoryState {}

class DataSuccessState extends HistoryState {
  final List<CaseStatus> statuses;
  final List<AllLawyer> lawyers;

  DataSuccessState({
    required this.statuses,
    required this.lawyers,
  });
}

class SuccessGetHistoryState extends HistoryState {
  final List<CaseHistory> history;

  SuccessGetHistoryState({
    required this.history,
  });
}

class SuccessCreateProceedingState extends HistoryState {}
