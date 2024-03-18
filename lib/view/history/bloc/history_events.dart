abstract class HistoryEvent {}

class GetHistoryEvent extends HistoryEvent {
  final String caseNo;

  GetHistoryEvent({
    required this.caseNo,
  });
}
