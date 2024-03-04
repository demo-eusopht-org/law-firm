import 'package:case_management/view/home/lawyer_Screen.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';

class NewLawyer extends StatefulWidget {
  const NewLawyer({super.key});

  @override
  State<NewLawyer> createState() => _NewLawyerState();
}

class _NewLawyerState extends State<NewLawyer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Create a New Lawyer',
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
                  hintText: 'Lawyer Id',
                ),
                SizedBox(height: 10),
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'FirstName',
                ),
                SizedBox(height: 10),
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'LastName',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'Description',
                ),
                SizedBox(height: 10),
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'Email',
                ),
                SizedBox(height: 10),
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'Cnic',
                ),
                SizedBox(height: 20),
                RoundedElevatedButton(
                  text: 'Submit',
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
