import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  final _dio = Dio();

  Future<String?> download({
    required String url,
    required String filename,
  }) async {
    try {
      final dir = Platform.isIOS
          ? await getLibraryDirectory()
          : await getExternalStorageDirectory();
      await _dio.download(url, '${dir!.path}/$filename');
      return '${dir.path}/$filename';
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return null;
    }
  }
}
