import 'dart:io';

import 'package:case_management/model/add_experience_model.dart';
import 'package:case_management/model/lawyer_request_model.dart';
import 'package:case_management/model/qualification_model.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_events.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/email_validator.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/date_field.dart';
import '../../widgets/toast.dart';
import 'lawyer_bloc/lawyer_bloc.dart';
import 'lawyer_bloc/lawyer_states.dart';

class NewLawyer extends StatefulWidget {
  final bool isEdit;
  final String? cnic;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNumber;
  final String? lawyerCredential;
  final String? expertise;
  final String? lawyerBio;
  final String? jobTtitle;
  final String? employer;
  final String? degree;
  final String? institute;
  final int? startYear;
  final int? endYear;
  NewLawyer({
    super.key,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.email,
    this.cnic,
    this.expertise,
    this.lawyerBio,
    this.jobTtitle,
    this.employer,
    this.endYear,
    this.startYear,
    this.institute,
    this.degree,
    this.lawyerCredential,
    required this.isEdit,
  });

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
  final _addQualification = ValueNotifier<List<AddQualificationModel>>([]);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Exp>? exp;
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
  void initState() {
    super.initState();
    firstNameController.text = widget.firstName ?? '';
    firstNameController.text = widget.firstName ?? '';
    lastNameController.text = widget.lastName ?? '';
    emailController.text = widget.email ?? '';
    phoneController.text = widget.phoneNumber ?? '';
    cnicController.text = widget.cnic ?? '';
    lawyerCredentialController.text = widget.lawyerCredential ?? '';
    expertiseController.text = widget.expertise ?? '';
    lawyerBioController.text = widget.lawyerBio ?? '';
    _addExperience.value.add(AddExperienceModel(
      titleController: TextEditingController(text: widget.jobTtitle),
      employerController: TextEditingController(text: widget.employer),
      startYear: widget.startYear != null ? DateTime(widget.startYear!) : null,
      endYear: widget.endYear != null ? DateTime(widget.endYear!) : null,
    ));

    _addQualification.value.add(
      AddQualificationModel(
        degreeController: TextEditingController(text: widget.degree),
        instituteController: TextEditingController(text: widget.institute),
        startYear:
            widget.startYear != null ? DateTime(widget.startYear!) : null,
        endYear: widget.endYear != null ? DateTime(widget.endYear!) : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: widget.isEdit ? 'Update' : 'Create a New Lawyer',
      ),
      body: BlocListener(
        bloc: BlocProvider.of<LawyerBloc>(context),
        listener: (context, state) {
          if (state is ErrorLawyerState) {
            CustomToast.show(state.message);
          } else if (state is SuccessLawyerState) {
            Navigator.pop(context);
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   CupertinoPageRoute(
            //     builder: (context) => MainScreen(),
            //   ),
            //       (_) => false,
            // );
          }
        },
        child: Center(
          child: Form(
            key: _formKey,
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
                      enabled: widget.isEdit ? false : true,
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

                    SizedBox(
                      height: 10,
                    ),
                    textWidget(
                      text: 'Qualification:',
                      color: Colors.black,
                      fSize: 18.0,
                    ),
                    SizedBox(height: 10),

                    ValueListenableBuilder(
                      valueListenable: _addQualification,
                      builder: (context, experienceFields, child) {
                        return Column(
                          children: experienceFields.map((exp) {
                            return _buildQualificationForm(exp);
                          }).toList(),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        final temp = List.of(_addQualification.value);
                        temp.add(
                          AddQualificationModel(
                            degreeController: TextEditingController(),
                            instituteController: TextEditingController(),
                          ),
                        );
                        _addQualification.value = temp;
                      },
                      child: textWidget(
                        text: 'Add qualification',
                        color: Colors.green,
                        fWeight: FontWeight.w800,
                        fSize: 18.0,
                      ),
                    ),

                    SizedBox(height: 20),
                    _buildSubmitButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  BlocBuilder<LawyerBloc, LawyerState> _buildSubmitButton(
      BuildContext context) {
    return BlocBuilder<LawyerBloc, LawyerState>(
      bloc: BlocProvider.of<LawyerBloc>(context),
      builder: (context, state) {
        if (state is LoadingLawyerState) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }
        return RoundedElevatedButton(
          text: widget.isEdit ? 'Update' : 'Submit',
          onPressed: () {
            final experience = _addExperience.value.map(
              (exp) {
                return Exp(
                  jobTitle: exp.titleController.text,
                  employer: exp.employerController.text,
                  startYear: exp.startYear?.year,
                  endYear: exp.endYear?.year,
                );
              },
            );

            final qualification = _addQualification.value.map((exp) {
              return Qualification(
                institute: exp.instituteController.text,
                degree: exp.degreeController.text,
                startYear: exp.startYear?.year,
                endYear: exp.endYear?.year,
              );
            });
            bool experienceYearsValid = true;
            for (var exp in experience) {
              if (exp.startYear == null || exp.endYear == null) {
                experienceYearsValid = false;
                break;
              }
            }
            bool qualificationYearsValid = true;
            for (var qual in qualification) {
              if (qual.startYear == null || qual.endYear == null) {
                qualificationYearsValid = false;
                break;
              }
            }
            // log('ex: ${experience.first.jobTitle}');
            if (_formKey.currentState!.validate() &&
                qualification.isNotEmpty &&
                experience.isNotEmpty &&
                experienceYearsValid &&
                qualificationYearsValid) {
              BlocProvider.of<LawyerBloc>(context).add(
                CreateNewLawyerEvent(
                  cnic: cnicController.text.trim(),
                  firstName: firstNameController.text.trim(),
                  lastName: lastNameController.text,
                  email: emailController.text.trim(),
                  phoneNumber: phoneController.text,
                  role: roleController.text.trim(),
                  lawyerCredential: lawyerCredentialController.text.trim(),
                  experience: experience.toList(),
                  expertise: expertiseController.text.trim(),
                  lawyerBio: lawyerBioController.text.trim(),
                  password: passController.text.trim(),
                  qualification: qualification.toList(),
                ),
              );
            } else {
              CustomToast.show('Invalid Date');
            }
          },
          borderRadius: 23,
        );
      },
    );
  }

  Widget _buildExperienceForm(AddExperienceModel model) {
    return ExpansionTile(
      initiallyExpanded: true,
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
                  model.startYear = selectedDate;
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
                  model.endYear = selectedDate;
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

  Widget _buildQualificationForm(AddQualificationModel model) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: TextFormField(
        controller: model.degreeController,
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
                controller: model.degreeController,
                isWhiteBackground: true,
                hintText: 'Degree',
                validatorCondition: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your degree.';
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
                controller: model.instituteController,
                isWhiteBackground: true,
                hintText: 'Institute',
                validatorCondition: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your institute.';
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
                  model.startYear = selectedDate;
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
                  model.endYear = selectedDate;
                },
              ),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            final temp = List.of(_addQualification.value);
            temp.remove(model);
            _addQualification.value = temp;
          },
          child: textWidget(
            text: 'Remove this qualification',
            color: Colors.red,
            fWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
