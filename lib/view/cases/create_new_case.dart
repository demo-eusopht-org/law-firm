import 'package:case_management/view/cases/open_file.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
  final FileManagerController controller = FileManagerController();

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
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    final status =
                        await Permission.manageExternalStorage.request();
                    if (status == PermissionStatus.granted) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => OpenFile(),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: textWidget(
                        text: 'Add Files',
                        fSize: 16.0,
                      ),
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
