import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/case_api/case_api.dart';
import '../../../api/dio.dart';
import '../../../utils/base_bloc.dart';
import '../../../widgets/toast.dart';
import 'admin_events.dart';
import 'admin_states.dart';

class AdminBloc extends BaseBloc<AdminEvent, AdminState> {
  final _caseApi = CaseApi(dio);

  AdminBloc() : super(InitialAdminState()) {
    on<AdminEvent>((event, emit) async {
      if (event is CreateStatusAdminEvent) {
        await _createStatus(emit, event.statusName);
      } else if (event is GetStatusAdminEvent) {
        await _getCaseStatuses(emit);
      } else if (event is UpdateStatusAdminEvent) {
        await _updateCaseStatus(event, emit);
      } else if (event is DeleteStatusAdminEvent) {
        await _deleteStatus(event.statusId, emit);
      }
    });
  }

  Future<void> _createStatus(
    Emitter<AdminState> emit,
    String statusName,
  ) async {
    await performSafeAction(emit, () async {
      final previous = state as GotStatusAdminState;
      emit(
        LoadingAdminState(),
      );
      final response = await _caseApi.createCaseStatus({
        'status_name': statusName,
      });
      if (response.status != 200) {
        CustomToast.show(response.message);
        emit(previous);
      } else {
        add(
          GetStatusAdminEvent(),
        );
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

  Future<void> _updateCaseStatus(
    UpdateStatusAdminEvent event,
    Emitter<AdminState> emit,
  ) async {
    await performSafeAction(emit, () async {
      final previous = (state as GotStatusAdminState);
      emit(
        LoadingAdminState(),
      );
      final response = await _caseApi.updateCaseStatus({
        'status_name': event.statusName,
        'status_id': event.statusId,
      });
      if (response.status != 200) {
        CustomToast.show(response.message);
        emit(previous);
      } else {
        add(
          GetStatusAdminEvent(),
        );
      }
    });
  }

  Future<void> _deleteStatus(int statusId, Emitter<AdminState> emit) async {
    await performSafeAction(emit, () async {
      final previousState = (state as GotStatusAdminState);
      emit(
        LoadingAdminState(),
      );
      final response = await _caseApi.deleteCaseStatus(statusId);
      if (response.status != 200) {
        CustomToast.show(response.message);
        emit(previousState);
      } else {
        add(
          GetStatusAdminEvent(),
        );
      }
    });
  }

  @override
  void onReceiveError(Emitter<AdminState> emit, String message) {
    emit(
      ErrorAdminState(message: message),
    );
  }
}
