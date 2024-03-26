import 'package:case_management/model/get_all_lawyers_model.dart';

import '../../../model/forgot_password_model.dart';

abstract class LawyerState {}

class InitialLawyerState extends LawyerState {}

class LoadingLawyerState extends LawyerState {}

class SuccessLawyerState extends LawyerState {}

class ForgotSucessLawyerState extends LawyerState {
  final ForgotPasswordModel forgotResponse;

  ForgotSucessLawyerState({required this.forgotResponse});
}

class GetLawyersState extends LawyerState {
  final List<AllLawyer> lawyers;

  GetLawyersState({
    required this.lawyers,
  });
}

class ErrorLawyerState extends LawyerState {
  final String message;

  ErrorLawyerState({
    required this.message,
  });
}
