import 'package:case_management/widgets/custom_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../model/lawyers/add_experience_model.dart';
import '../../model/lawyers/get_all_lawyers_model.dart';
import '../../model/lawyers/lawyer_request_model.dart';
import '../../model/qualification_model.dart';
import '../../services/image_picker_service.dart';
import '../../services/locator.dart';
import '../../utils/constants.dart';
import '../../utils/validator.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/date_field.dart';
import '../../widgets/round_file_image_view.dart';
import '../../widgets/rounded_image_view.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/toast.dart';
import 'lawyer_bloc/lawyer_bloc.dart';
import 'lawyer_bloc/lawyer_events.dart';
import 'lawyer_bloc/lawyer_states.dart';

class NewLawyer extends StatefulWidget {
  final AllLawyer? lawyer;

  const NewLawyer({
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
  final _experienceNotifier = ValueNotifier<List<AddExperienceModel>>([]);
  final _qualificationNotifier = ValueNotifier<List<AddQualificationModel>>([]);
  DateTime? startDateTime;
  DateTime? endDateTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isExpanded = false;
  final _imageNotifier = ValueNotifier<XFile?>(null);
  final _monthYearFormat = DateFormat('MM / yyyy');

  Future<void> _getImage() async {
    final pickedFile = await locator<ImagePickerService>().pickImage(
      ImageSource.gallery,
    );
    _imageNotifier.value = pickedFile;
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
        _experienceNotifier.value.add(
          AddExperienceModel(
            titleController: TextEditingController(text: item.jobTitle),
            employerController: TextEditingController(text: item.employer),
            startYear: _monthYearFormat.parse(item.startYear),
            endYear: _monthYearFormat.parse(item.endYear),
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
            startYear: _monthYearFormat.parse(item.startYear),
            endYear: _monthYearFormat.parse(item.endYear),
          ),
        );
      }
    }
    _qualificationNotifier.value = temp;
  }

  void _onSubmitPressed() {
    bool experienceYearsValid = true;
    for (var exp in _experienceNotifier.value) {
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
    for (var qual in _qualificationNotifier.value) {
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
    final experience = _experienceNotifier.value
        .map(
          (exp) {
            final start = exp.startYear;
            final end = exp.endYear;
            if (start != null && end != null) {
              return Exp(
                jobTitle: exp.titleController.text,
                employer: exp.employerController.text,
                startYear: _monthYearFormat.format(start),
                endYear: _monthYearFormat.format(end),
              );
            }
            return null;
          },
        )
        .whereType<Exp>()
        .toList();

    final qualification = _qualificationNotifier.value
        .map((qualification) {
          final start = qualification.startYear;
          final end = qualification.endYear;
          if (start != null && end != null) {
            return Qualification(
              institute: qualification.instituteController.text,
              degree: qualification.degreeController.text,
              startYear: _monthYearFormat.format(start),
              endYear: _monthYearFormat.format(end),
            );
          }
          return null;
        })
        .whereType<Qualification>()
        .toList();

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
                profileImage: _imageNotifier.value,
              )
            : CreateNewLawyerEvent(
                cnic: cnicController.text.trim(),
                firstName: firstNameController.text.trim(),
                lastName: lastNameController.text,
                email: emailController.text.trim(),
                phoneNumber: phoneController.text,
                role: roleController.text.trim(),
                lawyerCredential: lawyerCredentialController.text.trim(),
                experience: experience,
                expertise: expertiseController.text.trim(),
                lawyerBio: lawyerBioController.text.trim(),
                password: passController.text.trim(),
                qualification: qualification,
                profileImage: _imageNotifier.value,
              ),
      );
    } else {
      CustomToast.show(
        'Data provided is not valid, please check form again!',
      );
    }
  }

  @override
  void dispose() {
    _experienceNotifier.dispose();
    _qualificationNotifier.dispose();
    _imageNotifier.dispose();
    super.dispose();
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
            Navigator.pop(context, true);
          }
        },
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: _buildForm(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGap(),
          Center(
            child: _buildProfileImage(),
          ),
          _buildGap(),
          textWidget(
            text: 'Personal Details:',
            color: Colors.black,
            fSize: 18.0,
          ),
          _buildGap(),
          CustomTextField(
            enabled: widget.lawyer == null,
            controller: cnicController,
            textInputType: TextInputType.number,
            isWhiteBackground: true,
            hintText: '4210111111111',
            label: 'CNIC',
            validatorCondition: Validator.cnic,
          ),
          _buildGap(),
          CustomTextField(
            controller: firstNameController,
            textInputType: TextInputType.name,
            isWhiteBackground: true,
            label: 'First Name',
            validatorCondition: Validator.notEmpty,
          ),
          _buildGap(),
          CustomTextField(
            controller: lastNameController,
            textInputType: TextInputType.name,
            isWhiteBackground: true,
            label: 'Last Name',
            validatorCondition: Validator.notEmpty,
          ),
          _buildGap(),
          CustomTextField(
            controller: emailController,
            textInputType: TextInputType.emailAddress,
            isWhiteBackground: true,
            label: 'Email',
            validatorCondition: Validator.email,
          ),
          _buildGap(),
          CustomTextField(
            controller: phoneController,
            textInputType: TextInputType.phone,
            isWhiteBackground: true,
            label: 'Phone Number',
            validatorCondition: Validator.phoneNumber,
          ),
          _buildGap(),
          if (widget.lawyer == null)
            CustomTextField(
              controller: passController,
              showPasswordHideButton: true,
              isWhiteBackground: true,
              label: 'Password',
              maxLines: 1,
              validatorCondition: Validator.password,
            ),
          _buildGap(),
          textWidget(
            text: 'Lawyer Profile:',
            color: Colors.black,
            fSize: 18.0,
          ),
          _buildGap(),
          CustomTextField(
            controller: lawyerCredentialController,
            isWhiteBackground: true,
            label: 'Lawyer Credentials',
            validatorCondition: Validator.notEmpty,
          ),
          _buildGap(),
          CustomTextField(
            controller: expertiseController,
            isWhiteBackground: true,
            label: 'Expertise',
            validatorCondition: Validator.notEmpty,
          ),
          _buildGap(),
          CustomTextField(
            controller: lawyerBioController,
            isWhiteBackground: true,
            label: 'Lawyer Bio',
            maxLines: 3,
            validatorCondition: Validator.notEmpty,
          ),
          _buildGap(),
          textWidget(
            text: 'Experience:',
            color: Colors.black,
            fSize: 18.0,
          ),
          _buildGap(),
          ValueListenableBuilder(
            valueListenable: _experienceNotifier,
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
              final temp = List.of(_experienceNotifier.value);
              temp.add(
                AddExperienceModel(
                  titleController: TextEditingController(),
                  employerController: TextEditingController(),
                ),
              );
              _experienceNotifier.value = temp;
            },
            child: textWidget(
              text: 'Add experience',
              color: Colors.green,
              fWeight: FontWeight.w800,
              fSize: 18.0,
            ),
          ),
          _buildGap(),
          textWidget(
            text: 'Qualification:',
            color: Colors.black,
            fSize: 18.0,
          ),
          _buildGap(),
          ValueListenableBuilder(
            valueListenable: _qualificationNotifier,
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
              final temp = List.of(_qualificationNotifier.value);
              temp.add(
                AddQualificationModel(
                  degreeController: TextEditingController(),
                  instituteController: TextEditingController(),
                ),
              );
              _qualificationNotifier.value = temp;
            },
            child: textWidget(
              text: 'Add qualification',
              color: Colors.green,
              fWeight: FontWeight.w800,
              fSize: 18.0,
            ),
          ),
          _buildGap(),
          _buildSubmitButton(context),
          _buildGap(),
        ],
      ),
    );
  }

  SizedBox _buildGap() {
    return const SizedBox(
      height: 20,
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _getImage,
      child: ValueListenableBuilder(
        valueListenable: _imageNotifier,
        builder: (context, selectedFile, child) {
          if (selectedFile != null) {
            return RoundFileImageView(
              filePath: selectedFile.path,
              showBadge: true,
              size: 120,
            );
          } else if (widget.lawyer?.profilePic?.isNotEmpty ?? false) {
            return RoundNetworkImageView(
              url: Constants.getProfileUrl(
                widget.lawyer!.profilePic!,
                widget.lawyer!.id,
              ),
              showBadge: true,
              size: 120,
            );
          }
          return child!;
        },
        child: Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green,
          ),
          child: const Icon(
            Icons.add,
            size: 34,
            color: Colors.white,
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
            onPressed: _onSubmitPressed,
            borderRadius: 23,
          ),
        );
      },
    );
  }

  Widget _buildExperienceForm(AddExperienceModel model) {
    return CustomExpansionTile(
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
      actions: [
        IconButton(
          onPressed: () {
            final temp = List.of(_experienceNotifier.value);
            temp.remove(model);
            _experienceNotifier.value = temp;
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
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
        _buildGap(),
        Row(
          children: [
            Expanded(
              child: DatePickerField(
                hintText: 'Start Year',
                isWhiteBackground: true,
                hintColor: true,
                initialDate: model.startYear,
                dateFormat: _monthYearFormat,
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
                dateFormat: _monthYearFormat,
                onDateChanged: (DateTime selectedDate) {
                  model.endYear = selectedDate;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQualificationForm(AddQualificationModel model) {
    return CustomExpansionTile(
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
      actions: [
        IconButton(
          onPressed: () {
            final temp = List.of(_qualificationNotifier.value);
            temp.remove(model);
            _qualificationNotifier.value = temp;
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
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
        _buildGap(),
        Row(
          children: [
            Expanded(
              child: DatePickerField(
                hintText: 'Start Year',
                isWhiteBackground: true,
                initialDate: model.startYear,
                hintColor: true,
                dateFormat: _monthYearFormat,
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
                dateFormat: _monthYearFormat,
                onDateChanged: (DateTime selectedDate) {
                  model.endYear = selectedDate;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
