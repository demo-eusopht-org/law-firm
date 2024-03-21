import '../../../model/cases/all_cases_response.dart';

abstract class CauseState {}

class InitialCauseState extends CauseState {}

class LoadingCauseState extends CauseState {}

class SuccessCauseState extends CauseState {
  final List<Case> cases;

  SuccessCauseState({
    required this.cases,
  });
}
