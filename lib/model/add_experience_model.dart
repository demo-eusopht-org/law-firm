import 'package:flutter/cupertino.dart';

class AddExperienceModel {
  final TextEditingController titleController;
  final TextEditingController employerController;
  DateTime? startYear;
  DateTime? endYear;

  AddExperienceModel({
    required this.titleController,
    required this.employerController,
    this.startYear,
    this.endYear,
  });
}
