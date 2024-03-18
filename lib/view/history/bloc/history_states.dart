import '../../../model/cases/case_history_response.dart';

abstract class HistoryState {}

class InitialHistoryState extends HistoryState {}

class LoadingHistoryState extends HistoryState {}

class SuccessGetHistoryState extends HistoryState {
  final List<CaseHistory> history;

  SuccessGetHistoryState({
    required this.history,
  });
}
