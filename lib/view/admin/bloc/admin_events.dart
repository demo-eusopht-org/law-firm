import 'package:case_management/model/lawyers/get_all_lawyers_model.dart';

abstract class AdminEvent {}

class CreateStatusAdminEvent extends AdminEvent {
  final String statusName;

  CreateStatusAdminEvent({
    required this.statusName,
  });
}

class GetStatusAdminEvent extends AdminEvent {}

class UpdateStatusAdminEvent extends AdminEvent {
  final String statusName;
  final int statusId;

  UpdateStatusAdminEvent({
    required this.statusName,
    required this.statusId,
  });
}

class DeleteStatusAdminEvent extends AdminEvent {
  final int statusId;

  DeleteStatusAdminEvent({
    required this.statusId,
  });
}

class GetAdminsEvent extends AdminEvent {}

class CreateCompanyEvent extends AdminEvent {
  final String companyName;
  final AllLawyer? companyAdmin;

  CreateCompanyEvent({
    required this.companyName,
    this.companyAdmin,
  });
}

class GetCompaniesAdminEvent extends AdminEvent {}

class UpdateCompanyEvent extends AdminEvent {
  final String companyName;
  final int companyId;
  final AllLawyer? companyAdmin;

  UpdateCompanyEvent({
    required this.companyName,
    required this.companyId,
    this.companyAdmin,
  });
}
