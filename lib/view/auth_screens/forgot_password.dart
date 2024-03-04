import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Forgot Password',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              isWhiteBackground: true,
              hintText: 'Enter Cnic',
            ),
            SizedBox(height: 20),
            RoundedElevatedButton(
              text: 'Submit',
              onPressed: () {},
              borderRadius: 23,
            ),
          ],
        ),
      ),
    );
  }
}
