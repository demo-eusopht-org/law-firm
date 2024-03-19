import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/services/package_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../view/profile/update_Screen.dart';

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
      onRequest: (options, handler) async {
        final token = locator<LocalStorageService>().getData('token');
        final latestVersion = await PackageInfoService.getVersionNumber();
        final headers = options.headers;
        headers.addAll({
          'Authorization': 'Bearer $token',
          'version': latestVersion,
        });
        options.headers = headers;
        handler.next(options);
      },
      onResponse: (response, handler) async {
        final status = response.data['status'] as int?;
        if (status == 700) {
          Get.defaultDialog(
            title: '',
            barrierDismissible: false,
            backgroundColor: Colors.transparent,
            content: UpdateScreen(),
          );
        }
        handler.next(response);
      },
    ),
  );
