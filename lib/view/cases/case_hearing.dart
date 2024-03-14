import 'package:case_management/view/home/lawyer_Screen.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/date_field.dart';
import '../../widgets/dropdown_fields.dart';
import '../../widgets/text_widget.dart';

class CaseHearing extends StatefulWidget {
  const CaseHearing({super.key});

  @override
  State<CaseHearing> createState() => _CaseHearingState();
}

class _CaseHearingState extends State<CaseHearing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Case Hearing',
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                CustomTextFieldWithDropdown<String>(
                  hintText: 'Case Status',
                  isWhiteBackground: true,
                  onDropdownChanged: (newValue) {
                    print('Selected Category: $newValue');
                  },
                  builder: (String value) {
                    return textWidget(
                      text: value,
                      color: Colors.black,
                    );
                  },
                  dropdownItems: [
                    'Pending',
                    'Approved',
                  ],
                ),
                SizedBox(height: 10),
                DatePickerField(
                  hintText: 'Select Hearing Date',
                  isWhiteBackground: true,
                  hintColor: true,
                  onDateChanged: (DateTime selectedDate) {
                    print('Selected date: $selectedDate');
                  },
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
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'Opposite Party Advocate',
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: 'Submit',
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => LawyerScreen(),
                      ),
                    );
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
