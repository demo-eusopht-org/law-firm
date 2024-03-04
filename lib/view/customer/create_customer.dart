import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';

class CreateCustomer extends StatefulWidget {
  const CreateCustomer({
    super.key,
  });

  @override
  State<CreateCustomer> createState() => _CreateCustomerState();
}

class _CreateCustomerState extends State<CreateCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Create Customer',
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
                  hintText: 'First Name',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'Last Name',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'Email',
                ),
                SizedBox(
                  height: 10,
                ),
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
