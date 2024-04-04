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
