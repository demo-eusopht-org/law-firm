import 'package:flutter/cupertino.dart';

class AddExperienceModel {
  final TextEditingController titleController;
  final TextEditingController employerController;
  final DateTime? startYear;
  final DateTime? endYear;

  AddExperienceModel({
    required this.titleController,
    required this.employerController,
    this.startYear,
    this.endYear,
  });
}
