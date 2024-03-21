abstract class CauseEvent {}

class GetCauseListEvent extends CauseEvent {}

class ChangeDateCauseEvent extends CauseEvent {
  final DateTime? date;

  ChangeDateCauseEvent({
    required this.date,
  });
}
