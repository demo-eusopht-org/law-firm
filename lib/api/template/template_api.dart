import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../../model/generic_response.dart';
import '../../utils/constants.dart';

part 'template_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class TemplateApi {
  factory TemplateApi(Dio dio, {String? baseUrl}) = _TemplateApi;

  @POST('/api/templates/upload-template')
  Future<GenericResponse> uploadTemplate(
    @Part(name: 'template') File file,
    @Part(name: 'file_title') String title,
  );
}
