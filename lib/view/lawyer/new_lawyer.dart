import 'dart:io';

import 'package:case_management/model/add_experience_model.dart';
import 'package:case_management/model/lawyer_request_model.dart';
import 'package:case_management/model/qualification_model.dart';
import 'package:case_management/services/image_picker_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/utils/validator.dart';
import 'package:case_management/view/lawyer/lawyer_bloc/lawyer_events.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../model/get_all_lawyers_model.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/date_field.dart';
import '../../widgets/toast.dart';
import 'lawyer_bloc/lawyer_bloc.dart';
import 'lawyer_bloc/lawyer_states.dart';

class NewLawyer extends StatefulWidget {
  final AllLawyer? lawyer;

  NewLawyer({
    super.key,
    this.lawyer,
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
  DateTime? startDateTime;
  DateTime? endDateTime;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Exp>? exp;
  bool isExpanded = false;

  File? _image;

  Future<void> _getImage() async {
    final pickedFile = await locator<ImagePickerService>().pickImage(
      ImageSource.gallery,
    );

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
    firstNameController.text = widget.lawyer?.firstName ?? '';
    lastNameController.text = widget.lawyer?.lastName ?? '';
    emailController.text = widget.lawyer?.email ?? '';
    phoneController.text = widget.lawyer?.phoneNumber ?? '';
    cnicController.text = widget.lawyer?.cnic ?? '';
    lawyerCredentialController.text = widget.lawyer?.lawyerCredentials ?? '';
    expertiseController.text = widget.lawyer?.expertise ?? '';
    lawyerBioController.text = widget.lawyer?.lawyerBio ?? '';

    if (widget.lawyer?.experience != null) {
      for (int i = 0; i < widget.lawyer!.experience.length; i++) {
        final item = widget.lawyer!.experience[i];
        _addExperience.value.add(
          AddExperienceModel(
            titleController: TextEditingController(text: item.jobTitle),
            employerController: TextEditingController(text: item.employer),
            startYear:
                item.startYear != null ? DateTime(item.startYear!) : null,
            endYear: item.endYear != null ? DateTime(item.endYear!) : null,
          ),
        );
      }
    }
    final List<AddQualificationModel> temp = [];

    if (widget.lawyer?.qualification != null) {
      for (int i = 0; i < widget.lawyer!.qualification.length; i++) {
        final item = widget.lawyer!.qualification[i];
        temp.add(
          AddQualificationModel(
            degreeController: TextEditingController(text: item.degree),
            instituteController: TextEditingController(text: item.institute),
            startYear:
                item.startYear != null ? DateTime(item.startYear!) : null,
            endYear: item.endYear != null ? DateTime(item.endYear!) : null,
          ),
        );
      }
    }
    _addQualification.value = temp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: widget.lawyer != null ? 'Update' : 'Create a New Lawyer',
      ),
      body: BlocListener(
        bloc: BlocProvider.of<LawyerBloc>(context),
        listener: (context, state) {
          if (state is ErrorLawyerState) {
            CustomToast.show(state.message);
          } else if (state is SuccessLawyerState) {
            Navigator.pop(context);
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
                    const SizedBox(
                      height: 20,
                    ),

                    Center(
                      child: GestureDetector(
                        onTap: _getImage,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
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
                                  icon: const Icon(
                                    Icons.add,
                                    size: 34,
                                  ),
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    textWidget(
                      text: 'Personal Details:',
                      color: Colors.black,
                      fSize: 18.0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      enabled: widget.lawyer == null,
                      controller: cnicController,
                      textInputType: TextInputType.number,
                      isWhiteBackground: true,
                      hintText: '4210111111111',
                      label: 'CNIC',
                      validatorCondition: Validator.cnic,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: firstNameController,
                      textInputType: TextInputType.name,
                      isWhiteBackground: true,
                      label: 'First Name',
                      validatorCondition: Validator.notEmpty,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: lastNameController,
                      textInputType: TextInputType.name,
                      isWhiteBackground: true,
                      label: 'Last Name',
                      validatorCondition: Validator.notEmpty,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      isWhiteBackground: true,
                      label: 'Email',
                      validatorCondition: Validator.email,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: phoneController,
                      textInputType: TextInputType.phone,
                      isWhiteBackground: true,
                      label: 'Phone Number',
                      validatorCondition: Validator.phoneNumber,
                    ),
                    const SizedBox(height: 10),
                    if (widget.lawyer == null)
                      CustomTextField(
                        controller: passController,
                        showPasswordHideButton: true,
                        isWhiteBackground: true,
                        label: 'Password',
                        maxLines: 1,
                        validatorCondition: Validator.password,
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
                    const SizedBox(
                      height: 10,
                    ),
                    textWidget(
                      text: 'Lawyer Profile:',
                      color: Colors.black,
                      fSize: 18.0,
                    ),

                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: lawyerCredentialController,
                      isWhiteBackground: true,
                      label: 'Lawyer Credentials',
                      validatorCondition: Validator.notEmpty,
                    ),

                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: expertiseController,
                      isWhiteBackground: true,
                      label: 'Expertise',
                      validatorCondition: Validator.notEmpty,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: lawyerBioController,
                      isWhiteBackground: true,
                      label: 'Lawyer Bio',
                      validatorCondition: Validator.notEmpty,
                    ),
                    const SizedBox(height: 10),
                    textWidget(
                      text: 'Experience:',
                      color: Colors.black,
                      fSize: 18.0,
                    ),
                    const SizedBox(height: 10),

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

                    const SizedBox(
                      height: 10,
                    ),
                    textWidget(
                      text: 'Qualification:',
                      color: Colors.black,
                      fSize: 18.0,
                    ),
                    const SizedBox(height: 10),

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

                    const SizedBox(height: 20),
                    _buildSubmitButton(context),
                    const SizedBox(height: 20),
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
    BuildContext context,
  ) {
    return BlocBuilder<LawyerBloc, LawyerState>(
      bloc: BlocProvider.of<LawyerBloc>(context),
      builder: (context, state) {
        if (state is LoadingLawyerState) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          );
        }
        return Center(
          child: RoundedElevatedButton(
            text: widget.lawyer != null ? 'Update' : 'Submit',
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
              if (!experienceYearsValid) {
                CustomToast.show(
                  'Please enter correct years for experience!',
                );
                return;
              }
              bool qualificationYearsValid = true;
              for (var qual in qualification) {
                if (qual.startYear == null || qual.endYear == null) {
                  qualificationYearsValid = false;
                  break;
                }
              }
              if (!qualificationYearsValid) {
                CustomToast.show(
                  'Please enter valid years for qualification!',
                );
                return;
              }
              // log('ex: ${experience.first.jobTitle}');
              if (_formKey.currentState!.validate() &&
                  qualification.isNotEmpty &&
                  experience.isNotEmpty &&
                  experienceYearsValid &&
                  qualificationYearsValid) {
                BlocProvider.of<LawyerBloc>(context).add(
                  widget.lawyer != null
                      ? UpdateLawyerEvent(
                          userId: widget.lawyer!.id.toString(),
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          phoneNumber: phoneController.text,
                          role: roleController.text,
                          lawyerCredential: lawyerCredentialController.text,
                          experience: experience.toList(),
                          expertise: expertiseController.text,
                          lawyerBio: lawyerBioController.text,
                          password: passController.text,
                          qualification: qualification.toList(),
                        )
                      : CreateNewLawyerEvent(
                          cnic: cnicController.text.trim(),
                          firstName: firstNameController.text.trim(),
                          lastName: lastNameController.text,
                          email: emailController.text.trim(),
                          phoneNumber: phoneController.text,
                          role: roleController.text.trim(),
                          lawyerCredential:
                              lawyerCredentialController.text.trim(),
                          experience: experience.toList(),
                          expertise: expertiseController.text.trim(),
                          lawyerBio: lawyerBioController.text.trim(),
                          password: passController.text.trim(),
                          qualification: qualification.toList(),
                        ),
                );
              } else {
                CustomToast.show(
                  'Data provided is not valid, please check form again!',
                );
              }
            },
            borderRadius: 23,
          ),
        );
      },
    );
  }

  Widget _buildExperienceForm(AddExperienceModel model) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: TextFormField(
        controller: model.titleController,
        decoration: const InputDecoration(
          hintText: '(Unspecified)',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(
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
                label: 'Job title',
                validatorCondition: Validator.notEmpty,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: CustomTextField(
                controller: model.employerController,
                isWhiteBackground: true,
                label: 'Employer',
                validatorCondition: Validator.notEmpty,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: DatePickerField(
                hintText: 'Start Year',
                isWhiteBackground: true,
                hintColor: true,
                initialDate: model.startYear,
                onDateChanged: (DateTime selectedDate) {
                  model.startYear = selectedDate;
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: DatePickerField(
                hintText: 'End Year',
                isWhiteBackground: true,
                initialDate: model.endYear,
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
        decoration: const InputDecoration(
          hintText: '(Unspecified)',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        style: const TextStyle(
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
                label: 'Degree',
                validatorCondition: Validator.notEmpty,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: CustomTextField(
                controller: model.instituteController,
                isWhiteBackground: true,
                label: 'Institute',
                validatorCondition: Validator.notEmpty,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: DatePickerField(
                hintText: 'Start Year',
                isWhiteBackground: true,
                initialDate: model.startYear,
                hintColor: true,
                onDateChanged: (DateTime selectedDate) {
                  model.startYear = selectedDate;
                },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: DatePickerField(
                hintText: 'End Year',
                isWhiteBackground: true,
                initialDate: model.endYear,
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
