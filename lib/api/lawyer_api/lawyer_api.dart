import 'dart:io';

import 'package:case_management/model/new_lawyer_model.dart';
import 'package:case_management/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'lawyer_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class LawyerApi {
  factory LawyerApi(Dio dio, {String baseUrl}) = _LawyerApi;
  @POST('/api/customers/create-lawyer')
  Future<NewLawyerModel> createLawyer(@Part() String id, @Part() File file);
}
