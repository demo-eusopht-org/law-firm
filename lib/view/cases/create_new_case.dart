import 'dart:io';

import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/date_field.dart';
import '../../widgets/dropdown_fields.dart';

class CreateNewCase extends StatefulWidget {
  final bool isEdit;
  const CreateNewCase({super.key, required this.isEdit});

  @override
  State<CreateNewCase> createState() => _CreateNewCaseState();
}

class _CreateNewCaseState extends State<CreateNewCase> {
  List<File> _selectedFiles = [];

  Future<void> _openFilePicker() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
      );

      if (result != null) {
        setState(() {
          _selectedFiles
              .addAll(result.paths.map((path) => File(path!)).toList());
        });
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  void _removeSelectedFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: widget.isEdit ? 'Update' : 'Create a New Case',
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'Case No',
                ),
                SizedBox(height: 10),
                CustomTextFieldWithDropdown(
                  initialDropdownValue: 'Select Category',
                  isWhiteBackground: true,
                  onDropdownChanged: (newValue) {
                    print('Selected Category: $newValue');
                  },
                  dropdownItems: [
                    'Property Case',
                    'Murder Case',
                  ],
                ),
                SizedBox(height: 10),
                DatePickerField(
                  hintText: 'Select Reported Date',
                  isWhiteBackground: true,
                  hintColor: true,
                  onDateChanged: (DateTime selectedDate) {
                    print('Selected date: $selectedDate');
                  },
                ),
                SizedBox(height: 10),
                CustomTextFieldWithDropdown(
                  initialDropdownValue: 'Select Court',
                  isWhiteBackground: true,
                  onDropdownChanged: (newValue) {
                    print('Selected Category: $newValue');
                  },
                  dropdownItems: [
                    'Sindh High Court',
                    'Punjab High Court',
                  ],
                ),
                SizedBox(height: 10),
                DatePickerField(
                  hintText: 'Select Next Hearing Date',
                  isWhiteBackground: true,
                  hintColor: true,
                  onDateChanged: (DateTime selectedDate) {
                    print('Selected date: $selectedDate');
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'Case Assignee',
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: _openFilePicker,
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    width: double.infinity,
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _selectedFiles.isEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textWidget(
                                text: 'Add Files',
                                fSize: 14.0,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.file_open,
                                color: Colors.green,
                              )
                            ],
                          )
                        : Column(
                            children: _selectedFiles.map(
                              (file) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(text: file.path.split('/').last),
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () => _removeSelectedFile(
                                          _selectedFiles.indexOf(file)),
                                    ),
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: widget.isEdit ? 'Update' : 'Submit',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  borderRadius: 23,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
