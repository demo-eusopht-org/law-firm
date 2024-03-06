import 'package:case_management/model/new_lawyer_model.dart';

abstract class LawyerState {}

class InitialLawyerState extends LawyerState {}

class LoadingLawyerState extends LawyerState {}

class SuccessLawyerState extends LawyerState {
  final NewLawyerModel newLawyer;

  SuccessLawyerState({
    required this.newLawyer,
  });
}

class ErrorLawyerState extends LawyerState {
  final String message;

  ErrorLawyerState({
    required this.message,
  });
}
