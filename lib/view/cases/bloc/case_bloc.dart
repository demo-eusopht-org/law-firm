import 'dart:developer';
import 'dart:io';

import 'package:case_management/model/open_file_model.dart';
import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/case_api/case_api.dart';
import '../../../api/dio.dart';
import '../../../api/lawyer_api/lawyer_api.dart';
import '../../../utils/base_bloc.dart';
import '../../../utils/constants.dart';
import '../../../widgets/toast.dart';
import 'case_events.dart';
import 'case_states.dart';

class CaseBloc extends BaseBloc<CaseEvent, CaseState> {
  final _caseApi = CaseApi(dio, baseUrl: Constants.baseUrl);
  final _lawyersApi = LawyerApi(dio, baseUrl: Constants.baseUrl);

  CaseBloc() : super(InitialCaseState()) {
    on<CaseEvent>((event, emit) async {
      if (event is GetCasesEvent) {
        await _getCases(emit);
      } else if (event is GetDataCaseEvent) {
        await _getCaseData(emit);
      } else if (event is CreateCaseEvent) {
        await _createCase(event, emit);
      } else if (event is GetUserCasesEvent) {
        await _getUserCases(event.userId, emit);
      } else if (event is DeleteCaseEvent) {
        await _deleteCase(event.caseNo, emit);
      } else if (event is AssignLawyerEvent) {
        await _assignCaseToUser(event.caseNo, event.cnic, emit);
      } else if (event is GetCaseEvent) {
        await _getCase(event.caseNo, emit);
      } else if (event is GetCaseFilesEvent) {
        await _getCaseFiles(event.caseNo, emit);
      } else if (event is UploadCaseFileEvent) {
        await _uploadCaseFiles(event.caseNo, event.file, emit);
      }
    });
  }

  Future<void> _getCases(Emitter<CaseState> emit) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingCaseState(),
      );
      final response = await _caseApi.getAllCases();
      final id = locator<LocalStorageService>().getData('id');
      final role = locator<LocalStorageService>().getData('role');
      if (response.status != 200) {
        throw Exception(response.message);
      }
      final myCases = response.data?.where((myCase) {
            return role == 'ADMIN' ||
                myCase.caseCustomer?.id == id ||
                myCase.caseLawyer?.id == id;
          }).toList() ??
          [];
      emit(
        AllCasesState(
          cases: myCases,
        ),
      );
    });
  }

  Future<void> _getCaseData(Emitter<CaseState> emit) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingCaseState(),
      );
      final typesRes = await _caseApi.getCaseType();
      final statusRes = await _caseApi.getCaseStatuses();
      final courtRes = await _caseApi.getCourtTypes();
      final clientData = await _lawyersApi.getAllClients();
      final lawyersData = await _lawyersApi.getLawyers();
      emit(
        DataSuccessCaseState(
          caseTypes: typesRes.data,
          caseStatuses: statusRes.data,
          courtTypes: courtRes.data,
          clients: clientData.data.where((client) {
            return client.status;
          }).toList(),
          lawyers: lawyersData.lawyers,
        ),
      );
    });
  }

  Future<void> _createCase(
    CreateCaseEvent event,
    Emitter<CaseState> emit,
  ) async {
    final dataState = (state as DataSuccessCaseState);
    try {
      emit(
        SubmittingCaseState(),
      );
      final response = await _caseApi.createCase({
        'case_no': event.caseNo,
        'plaintiff': event.plaintiff,
        'defendant': event.defendant,
        'plaintiff_advocate': event.plaintiffAdvocate,
        'defendant_advocate': event.defendantAdvocate,
        'court_type': event.courtType.id,
        'case_type': event.caseType.id,
        'case_status': event.caseStatus.id,
        'case_customer_id': event.caseClient?.id,
        'is_customer_plaintiff': event.isCustomerPlaintiff,
        'case_filing_date': event.caseFilingDate.millisecondsSinceEpoch,
        'next_hearing_date': event.nextHearingDate.millisecondsSinceEpoch,
        'judge': event.judgeName,
        'court_location': event.courtLocation,
        'year': event.year,
        'case_assigned_to': event.caseLawyer?.id,
        'current_proceedings': event.proceedings,
      });
      if (response.status != 200) {
        throw Exception(
          response.message ?? 'Something went wrong while creating case!',
        );
      }
      for (final model in event.files) {
        final fileResponse = await _caseApi.uploadCaseFile(
          caseNo: event.caseNo,
          caseFile: File(model.file.path),
          fileTitle: model.title,
        );
        if (fileResponse.status != 200) {
          log('FILE NOT UPLOADED: ${model.title}');
        }
      }
      emit(
        SubmitSuccessCaseState(),
      );
    } on DioException catch (e, s) {
      final message = '${e.response!.statusCode}: ${e.response!.statusMessage}';
      log(message, stackTrace: s);
      CustomToast.show(message);
      emit(
        dataState,
      );
    } catch (e) {
      log('Exception: ${e.toString()}');
      CustomToast.show(e.toString());
      emit(
        dataState,
      );
    }
  }

  Future<void> _getUserCases(int userId, Emitter<CaseState> emit) async {
    try {
      emit(
        LoadingCaseState(),
      );
      final response = await _caseApi.getUserCases(userId);
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        AllCasesState(cases: response.data ?? []),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(
        InitialCaseState(),
      );
    }
  }

  Future<void> _deleteCase(String caseNo, Emitter<CaseState> emit) async {
    try {
      emit(
        LoadingCaseState(),
      );
      final response = await _caseApi.deleteCase({
        'case_no': caseNo,
      });
      if (response.status != 200) {
        throw Exception(response.message);
      }
      CustomToast.show(response.message);
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
    } finally {
      add(
        GetCasesEvent(),
      );
    }
  }

  Future<void> _assignCaseToUser(
    String caseNo,
    String cnic,
    Emitter<CaseState> emit,
  ) async {
    final previousState = (state as AllCasesState);
    try {
      emit(
        LoadingCaseState(),
      );
      final response = await _caseApi.assignCaseToUser({
        'case_no': caseNo,
        'cnic': cnic,
      });
      if (response.status != 200) {
        throw Exception(response.message);
      }
      CustomToast.show(response.message);
      add(
        GetCasesEvent(),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(previousState);
    }
  }

  Future<void> _getCase(String caseNo, Emitter<CaseState> emit) async {
    try {
      emit(
        LoadingCaseState(),
      );
      final response = await _caseApi.getCase(caseNo);
      if (response.status != 200 || response.data == null) {
        throw Exception(response.message);
      }
      emit(
        SuccessCaseState(caseData: response.data!),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      CustomToast.show(e.toString());
      emit(InitialCaseState());
    }
  }

  Future<void> _getCaseFiles(String caseNo, Emitter<CaseState> emit) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingCaseState(),
      );
      final response = await _caseApi.getAllCaseFiles({
        'case_no': caseNo,
      });
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        SuccessAllFilesState(
          files: response.files,
        ),
      );
    });
  }

  Future<void> _uploadCaseFiles(
    String caseNo,
    OpenFileModel caseFile,
    Emitter<CaseState> emit,
  ) async {
    await performSafeAction(emit, () async {
      emit(
        LoadingCaseState(),
      );
      final response = await _caseApi.uploadCaseFile(
        caseNo: caseNo,
        caseFile: File(caseFile.file.path),
        fileTitle: caseFile.title,
      );
      if (response.status != 200) {
        CustomToast.show(response.message);
      }
      add(
        GetCaseFilesEvent(caseNo: caseNo),
      );
    });
  }

  @override
  void onReceiveError(Emitter<CaseState> emit, String message) {
    emit(
      ErrorCaseState(
        message: message,
      ),
    );
  }
}
