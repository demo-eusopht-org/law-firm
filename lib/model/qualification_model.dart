import 'package:flutter/cupertino.dart';

class AddQualificationModel {
  final TextEditingController degreeController;
  final TextEditingController instituteController;
  final DateTime? startYear;
  final DateTime? endYear;

  AddQualificationModel({
    required this.degreeController,
    required this.instituteController,
    this.startYear,
    this.endYear,
  });
}
