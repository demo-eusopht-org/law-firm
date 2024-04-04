import 'package:case_management/api/company_api/company_api.dart';
import 'package:case_management/api/lawyer_api/lawyer_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/case_api/case_api.dart';
import '../../../api/dio.dart';
import '../../../utils/base_bloc.dart';
import '../../../utils/constants.dart';
import '../../../widgets/toast.dart';
import 'admin_events.dart';
import 'admin_states.dart';

class AdminBloc extends BaseBloc<AdminEvent, AdminState> {
  final _caseApi = CaseApi(dio, baseUrl: Constants.baseUrl);
  final _lawyersApi = LawyerApi(dio, baseUrl: Constants.baseUrl);
  final _companyApi = CompanyApi(dio, baseUrl: Constants.baseUrl);

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
      } else if (event is GetAdminsEvent) {
        await _getAdminsList(emit);
      } else if (event is CreateCompanyEvent) {
        await _createCompany(event, emit);
      } else if (event is GetCompaniesAdminEvent) {
        await _getCompanies(emit);
      } else if (event is UpdateCompanyEvent) {
        await _updateCompany(event, emit);
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

  Future<void> _getAdminsList(Emitter<AdminState> emit) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingAdminState(),
      );
      final response = await _lawyersApi.getLawyers();
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        GotAdminsState(lawyers: response.lawyers),
      );
    });
  }

  Future<void> _createCompany(
    CreateCompanyEvent event,
    Emitter<AdminState> emit,
  ) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingAdminState(),
      );
      final response = await _companyApi.createCompany({
        'company_name': event.companyName,
        'admin_id': event.companyAdmin?.id,
      });
      if (response.status != 200) {
        throw Exception(
          response.message,
        );
      }
      emit(
        CreateCompanySuccessState(),
      );
    });
  }

  Future<void> _getCompanies(Emitter<AdminState> emit) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingAdminState(),
      );
      final response = await _companyApi.getAllCompanies();
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        ReadCompaniesAdminState(companies: response.data),
      );
    });
  }

  Future<void> _updateCompany(
    UpdateCompanyEvent event,
    Emitter<AdminState> emit,
  ) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingAdminState(),
      );
      final response = await _companyApi.updateCompany({
        'company_name': event.companyName,
        'company_id': event.companyId,
        'admin_id': event.companyAdmin?.id,
      });
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        CreateCompanySuccessState(),
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
