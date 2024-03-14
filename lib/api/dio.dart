import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final dio = Dio()
  ..interceptors.add(
    PrettyDioLogger(
      compact: true,
      request: true,
      requestBody: true,
      requestHeader: false,
      responseBody: true,
      responseHeader: false,
    ),
  )
  ..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = locator<LocalStorageService>().getData('token');
        final headers = options.headers;
        headers.addAll({
          'Authorization': 'Bearer $token',
        });
        options.headers = headers;
        handler.next(options);
      },
    ),
  );
