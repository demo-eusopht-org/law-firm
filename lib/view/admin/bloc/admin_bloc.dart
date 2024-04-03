import 'package:bloc/src/bloc.dart';

import '../../../api/case_api/case_api.dart';
import '../../../api/dio.dart';
import '../../../utils/base_bloc.dart';
import 'admin_events.dart';
import 'admin_states.dart';

class AdminBloc extends BaseBloc<AdminEvent, AdminState> {
  final _caseApi = CaseApi(dio);

  AdminBloc() : super(InitialAdminState()) {
    on<AdminEvent>((event, emit) async {
      if (event is GetStatusAdminEvent) {
        await _getCaseStatuses(emit);
      }
    });
  }

  Future<void> _getCaseStatuses(Emitter<AdminState> emit) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingAdminState(),
      );
      final response = await _caseApi.getCaseStatuses();
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        GotStatusAdminState(
          statuses: response.data,
        ),
      );
    });
  }

  @override
  void onReceiveError(Emitter<AdminState> emit, String message) {
    emit(
      ErrorAdminState(message: message),
    );
  }
}
