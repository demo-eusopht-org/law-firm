import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(super.initialState);

  Future<void> performSafeAction(
      Emitter<S> emit, AsyncCallback callback) async {
    try {
      await callback.call();
    } on DioException catch (e, s) {
      log(e.toString(), stackTrace: s);
      onReceiveError(
          emit, '${e.response!.statusCode}: ${e.response!.statusMessage}');
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      onReceiveError(emit, e.toString().replaceAll('Exception:', ''));
    }
  }

  void onReceiveError(Emitter<S> emit, String message);
}
