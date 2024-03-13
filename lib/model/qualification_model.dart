import 'package:flutter/cupertino.dart';

class AddQualificationModel {
  final TextEditingController degreeController;
  final TextEditingController instituteController;
  DateTime? startYear;
  DateTime? endYear;

  AddQualificationModel({
    required this.degreeController,
    required this.instituteController,
    this.startYear,
    this.endYear,
  });
}
