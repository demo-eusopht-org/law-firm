import 'dart:developer';

import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/auth/auth_api.dart';
import '../../../api/dio.dart';
import '../../../utils/constants.dart';
import 'notification_events.dart';
import 'notification_states.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final _authApi = AuthApi(dio, baseUrl: Constants.baseUrl);

  NotificationBloc() : super(InitialNotificationState()) {
    on<NotificationEvent>((event, emit) async {
      if (event is GetNotificationsEvent) {
        await _getNotifications(emit);
      }
    });
  }

  Future<void> _getNotifications(Emitter<NotificationState> emit) async {
    try {
      emit(
        LoadingNotificationState(),
      );
      final userId = locator<LocalStorageService>().getData('id');
      final response = await _authApi.getUserNotifications(userId);
      if (response.status != 200) {
        throw Exception(response.message);
      }
      emit(
        SuccessNotificationState(
          notifications: response.notifications,
        ),
      );
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      emit(
        ErrorNotificationState(message: e.toString()),
      );
    }
  }
}
