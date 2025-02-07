import '../../../model/cases/case_status.dart';
import '../../../model/companies/all_company_response.dart';
import '../../../model/lawyers/get_all_lawyers_model.dart';
import '../../../model/templates/all_templates_response.dart';

abstract class AdminState {}

class InitialAdminState extends AdminState {}

class ErrorAdminState extends AdminState {
  final String message;

  ErrorAdminState({
    required this.message,
  });
}

class LoadingAdminState extends AdminState {}

class GotStatusAdminState extends AdminState {
  final List<CaseStatus> statuses;

  GotStatusAdminState({
    required this.statuses,
  });
}

class GotAdminsState extends AdminState {
  final List<AllLawyer> lawyers;

  GotAdminsState({
    required this.lawyers,
  });
}

class CreateCompanySuccessState extends AdminState {}

class ReadCompaniesAdminState extends AdminState {
  final List<Company> companies;

  ReadCompaniesAdminState({
    required this.companies,
  });
}

class SuccessTemplateAdminState extends AdminState {}

class GotTemplatesAdminState extends AdminState {
  final List<Template> templates;

  GotTemplatesAdminState({
    required this.templates,
  });
}
