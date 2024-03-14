import 'package:flutter_bloc/flutter_bloc.dart';

import 'case_events.dart';
import 'case_states.dart';

class CaseBloc extends Bloc<CaseEvent, CaseState> {
  CaseBloc() : super(InitialCaseState()) {
    on<CaseEvent>((event, emit) async {
      if (event is GetDataCaseEvent) {
        await _getCaseData();
      }
    });
  }

  Future<void> _getCaseData() async {}
}
