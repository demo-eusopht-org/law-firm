import 'dart:io';

import 'package:case_management/model/add_experience_model.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/email_validator.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/date_field.dart';

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
  TextEditingController expertiseController = TextEditingController();
  TextEditingController lawyerBioController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final _addExperience = ValueNotifier<List<AddExperienceModel>>([]);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isExpanded = false;

  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  void dispose() {
    _addExperience.dispose();
    super.dispose();
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),

                Center(
                  child: GestureDetector(
                    onTap: _getImage,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: _image != null
                          ? ClipOval(
                              child: Image.file(
                                _image!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            )
                          : IconButton(
                              onPressed: _getImage,
                              icon: Icon(
                                Icons.add,
                                size: 34,
                              ),
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                textWidget(
                  text: 'Personal Details:',
                  color: Colors.black,
                  fSize: 18.0,
                ),
                SizedBox(
                  height: 10,
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
                  controller: passController,
                  showPasswordHideButton: true,
                  isWhiteBackground: true,
                  hintText: 'Password',
                  maxlines: 1,
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password.';
                    }
                    return null;
                  },
                ),
                // SizedBox(height: 10),
                // CustomTextField(
                //   isWhiteBackground: true,
                //   hintText: 'Role',
                //   validatorCondition: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your role.';
                //     }
                //     return null;
                //   },
                // ),
                SizedBox(
                  height: 10,
                ),
                textWidget(
                  text: 'Lawyer Profile:',
                  color: Colors.black,
                  fSize: 18.0,
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
                textWidget(
                  text: 'Experience:',
                  color: Colors.black,
                  fSize: 18.0,
                ),
                SizedBox(height: 10),

                ValueListenableBuilder(
                  valueListenable: _addExperience,
                  builder: (context, experienceFields, child) {
                    return Column(
                      children: experienceFields.map((exp) {
                        return _buildExperienceForm(exp);
                      }).toList(),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    final temp = List.of(_addExperience.value);
                    temp.add(
                      AddExperienceModel(
                        titleController: TextEditingController(),
                        employerController: TextEditingController(),
                      ),
                    );
                    _addExperience.value = temp;
                  },
                  child: textWidget(
                    text: 'Add experience',
                    color: Colors.green,
                    fWeight: FontWeight.w800,
                    fSize: 18.0,
                  ),
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

  Widget _buildExperienceForm(AddExperienceModel model) {
    return ExpansionTile(
      title: TextFormField(
        controller: model.titleController,
        decoration: InputDecoration(
          hintText: '(Unspecified)',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        enabled: false,
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: model.titleController,
                isWhiteBackground: true,
                hintText: 'Job title',
                validatorCondition: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your experience.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: CustomTextField(
                controller: model.employerController,
                isWhiteBackground: true,
                hintText: 'Employer',
                validatorCondition: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your experience.';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: DatePickerField(
                hintText: 'Start Year',
                isWhiteBackground: true,
                hintColor: true,
                onDateChanged: (DateTime selectedDate) {
                  print('Selected date: $selectedDate');
                },
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: DatePickerField(
                hintText: 'End Year',
                isWhiteBackground: true,
                hintColor: true,
                onDateChanged: (DateTime selectedDate) {
                  print('Selected date: $selectedDate');
                },
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            final temp = List.of(_addExperience.value);
            temp.remove(model);
            _addExperience.value = temp;
          },
          child: textWidget(
            text: 'Remove this experience',
            color: Colors.red,
            fWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
