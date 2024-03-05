import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/email_validator.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';

class NewLawyer extends StatefulWidget {
  const NewLawyer({super.key});

  @override
  State<NewLawyer> createState() => _NewLawyerState();
}

class _NewLawyerState extends State<NewLawyer> {
  TextEditingController cnicController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController lawyerCredentialController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController expertiseController = TextEditingController();
  TextEditingController lawyerBioController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
                  controller: cnicController,
                  textInputType: TextInputType.number,
                  isWhiteBackground: true,
                  hintText: 'Cnic',
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: firstNameController,
                  textInputType: TextInputType.name,
                  isWhiteBackground: true,
                  hintText: 'FirstName',
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your first name.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: lastNameController,
                  textInputType: TextInputType.name,
                  isWhiteBackground: true,
                  hintText: 'LastName',
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your last name.';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  isWhiteBackground: true,
                  hintText: 'Email',
                  validatorCondition: (String? input) =>
                      input!.trim().isValidEmail() ? null : "Invalid Email",
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: phoneController,
                  textInputType: TextInputType.phone,
                  isWhiteBackground: true,
                  hintText: 'Phone Number',
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  isWhiteBackground: true,
                  hintText: 'Role',
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your role.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: lawyerCredentialController,
                  isWhiteBackground: true,
                  hintText: 'Lawyer Credentials',
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your credentials.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: experienceController,
                  isWhiteBackground: true,
                  hintText: 'Experience',
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your experience.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: expertiseController,
                  isWhiteBackground: true,
                  hintText: 'Expertise',
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your expertise.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: lawyerBioController,
                  isWhiteBackground: true,
                  hintText: 'Lawyer Bio',
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your bio.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                CustomTextField(
                  controller: passController,
                  showPasswordHideButton: true,
                  isWhiteBackground: true,
                  hintText: 'Password',
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
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
