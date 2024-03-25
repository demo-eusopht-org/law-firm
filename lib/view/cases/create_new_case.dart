import 'dart:developer';

import 'package:case_management/model/cases/case_status.dart';
import 'package:case_management/model/cases/case_type.dart';
import 'package:case_management/model/cases/court_type.dart';
import 'package:case_management/model/get_all_lawyers_model.dart';
import 'package:case_management/model/lawyers/all_clients_response.dart';
import 'package:case_management/model/open_file_model.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/services/permission_service.dart';
import 'package:case_management/utils/validator.dart';
import 'package:case_management/view/cases/bloc/case_bloc.dart';
import 'package:case_management/view/cases/bloc/case_events.dart';
import 'package:case_management/view/cases/bloc/case_states.dart';
import 'package:case_management/view/cases/open_file.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/date_field.dart';
import '../../widgets/dropdown_fields.dart';

class CreateNewCase extends StatefulWidget {
  final bool isEdit;
  const CreateNewCase({
    super.key,
    required this.isEdit,
  });

  @override
  State<CreateNewCase> createState() => _CreateNewCaseState();
}

class _CreateNewCaseState extends State<CreateNewCase> {
  final FileManagerController controller = FileManagerController();
  final _formKey = GlobalKey<FormState>();
  final _selectedFilesNotifier = ValueNotifier<List<OpenFileModel>>([]);
  final _caseNoController = TextEditingController();
  final _plaintiffController = TextEditingController();
  final _defendantController = TextEditingController();
  final _plaintiffAdvController = TextEditingController();
  final _defendantAdvController = TextEditingController();
  final _judgeController = TextEditingController();
  final _locationController = TextEditingController();
  final _yearController = TextEditingController();
  final _proceedingsController = TextEditingController();
  CaseType? _selectedCaseType;
  CaseStatus? _selectedCaseStatus;
  CourtType? _selectedCourtType;
  Client? _selectedClient;
  bool? _isCustomerPlaintiff;
  DateTime? _caseFilingDate;
  DateTime? _nextHearingDate;

  AllLawyer? _selectedLawyer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<CaseBloc>(context).add(
        GetDataCaseEvent(),
      ),
    );
  }

  Future<void> _onSubmitPressed() async {
    if (!_validate()) {
      return;
    }
    log('Validated!');
    BlocProvider.of<CaseBloc>(context).add(
      CreateCaseEvent(
        caseNo: _caseNoController.text,
        plaintiff: _plaintiffController.text,
        defendant: _defendantController.text,
        plaintiffAdvocate: _plaintiffAdvController.text,
        defendantAdvocate: _defendantAdvController.text,
        caseType: _selectedCaseType!,
        caseStatus: _selectedCaseStatus!,
        courtType: _selectedCourtType!,
        caseClient: _selectedClient!,
        isCustomerPlaintiff: _isCustomerPlaintiff!,
        caseFilingDate: _caseFilingDate!,
        nextHearingDate: _nextHearingDate!,
        judgeName: _judgeController.text,
        courtLocation: _locationController.text,
        year: _yearController.text,
        caseLawyer: _selectedLawyer!,
        proceedings: _proceedingsController.text,
        files: _selectedFilesNotifier.value,
      ),
    );
  }

  bool _validate() {
    final areTextFieldsValidated = _formKey.currentState!.validate();
    if (!areTextFieldsValidated) {
      return false;
    } else if (_selectedCaseType == null) {
      CustomToast.show('Please select case type!');
      return false;
    } else if (_selectedCaseStatus == null) {
      CustomToast.show('Please select case status!');
      return false;
    } else if (_selectedCourtType == null) {
      CustomToast.show('Please select court type!');
      return false;
    } else if (_selectedClient == null) {
      CustomToast.show('Please select case client!');
      return false;
    } else if (_selectedLawyer == null) {
      CustomToast.show('Please select case lawyer!');
      return false;
    } else if (_caseFilingDate == null) {
      CustomToast.show('Please select case filing date!');
      return false;
    } else if (_isCustomerPlaintiff == null) {
      CustomToast.show('Please select if client is plaintiff!');
      return false;
    } else if (_nextHearingDate == null) {
      CustomToast.show('Please select next hearing date!');
      return false;
    } else if (_selectedFilesNotifier.value.isEmpty) {
      CustomToast.show('Please select at least one file!');
      return false;
    }
    return true;
  }

  void _listener(BuildContext context, CaseState state) {
    if (state is SubmitSuccessCaseState) {
      CustomToast.show('Case submitted successfully!');
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _selectedFilesNotifier.dispose();
    controller.dispose();
    _caseNoController.dispose();
    _plaintiffController.dispose();
    _defendantController.dispose();
    _plaintiffAdvController.dispose();
    _defendantAdvController.dispose();
    _judgeController.dispose();
    _locationController.dispose();
    _yearController.dispose();
    _proceedingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CaseBloc, CaseState>(
      bloc: BlocProvider.of<CaseBloc>(context),
      listener: _listener,
      child: Scaffold(
        appBar: AppBarWidget(
          context: context,
          showBackArrow: true,
          title: widget.isEdit ? 'Update' : 'Create a New Case',
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<CaseBloc, CaseState>(
      bloc: BlocProvider.of<CaseBloc>(context),
      builder: (context, state) {
        if (state is LoadingCaseState) {
          return const Loader();
        } else if (state is DataSuccessCaseState) {
          return _buildForm(state);
        } else if (state is SubmittingCaseState) {
          return const Loader();
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildForm(DataSuccessCaseState state) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _caseNoController,
                isWhiteBackground: true,
                label: 'Case No',
                validatorCondition: Validator.notEmpty,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _plaintiffController,
                isWhiteBackground: true,
                label: 'Plaintiff',
                validatorCondition: Validator.notEmpty,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _defendantController,
                isWhiteBackground: true,
                label: 'Defendant',
                validatorCondition: Validator.notEmpty,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _plaintiffAdvController,
                isWhiteBackground: true,
                label: 'Plaintiff Advocate Name',
                validatorCondition: Validator.notEmpty,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _defendantAdvController,
                isWhiteBackground: true,
                label: 'Defendant Advocate Name',
                validatorCondition: Validator.notEmpty,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWithDropdown<CaseType>(
                hintText: 'Case Type',
                isWhiteBackground: true,
                onDropdownChanged: (newValue) {
                  _selectedCaseType = newValue;
                },
                builder: (value) {
                  return textWidget(
                    text: value.type,
                    color: Colors.black,
                  );
                },
                dropdownItems: state.caseTypes,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWithDropdown<CaseStatus>(
                hintText: 'Case Status',
                isWhiteBackground: true,
                onDropdownChanged: (newValue) {
                  _selectedCaseStatus = newValue;
                },
                builder: (value) {
                  return textWidget(
                    text: value.statusName,
                    color: Colors.black,
                  );
                },
                dropdownItems: state.caseStatuses,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWithDropdown<CourtType>(
                isWhiteBackground: true,
                hintText: 'Court Type',
                dropdownItems: state.courtTypes,
                onDropdownChanged: (newValue) {
                  _selectedCourtType = newValue;
                },
                builder: (value) {
                  return textWidget(
                    text: value.court,
                    color: Colors.black,
                  );
                },
              ),
              const SizedBox(height: 10),
              CustomTextFieldWithDropdown<Client>(
                hintText: 'Case Customer',
                isWhiteBackground: true,
                onDropdownChanged: (newValue) {
                  _selectedClient = newValue;
                },
                builder: (value) {
                  return textWidget(
                    text: value.getDisplayName(),
                    color: Colors.black,
                  );
                },
                dropdownItems: state.clients,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWithDropdown<bool>(
                hintText: 'Is Customer Plaintiff?',
                isWhiteBackground: true,
                onDropdownChanged: (newValue) {
                  _isCustomerPlaintiff = newValue;
                },
                builder: (value) {
                  return textWidget(
                    text: value ? 'Yes' : 'No',
                    color: Colors.black,
                  );
                },
                dropdownItems: [true, false],
              ),
              const SizedBox(height: 10),
              DatePickerField(
                hintText: 'Case Filling Date',
                isWhiteBackground: true,
                hintColor: false,
                onDateChanged: (DateTime selectedDate) {
                  _caseFilingDate = selectedDate;
                },
                dateFormat: DateFormat('dd-MM-yyyy'),
              ),
              const SizedBox(height: 10),
              DatePickerField(
                hintText: 'Next Hearing Date',
                isWhiteBackground: true,
                hintColor: false,
                onDateChanged: (DateTime selectedDate) {
                  _nextHearingDate = selectedDate;
                },
                dateFormat: DateFormat('dd-MM-yyyy'),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _judgeController,
                isWhiteBackground: true,
                label: 'Judge',
                validatorCondition: Validator.notEmpty,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _locationController,
                isWhiteBackground: true,
                label: 'Court Location',
                validatorCondition: Validator.notEmpty,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _yearController,
                isWhiteBackground: true,
                label: 'Year',
                validatorCondition: Validator.notEmpty,
              ),
              const SizedBox(height: 10),
              CustomTextFieldWithDropdown<AllLawyer>(
                hintText: 'Case Assigned To Lawyer',
                isWhiteBackground: true,
                onDropdownChanged: (newValue) {
                  _selectedLawyer = newValue;
                },
                builder: (value) {
                  return textWidget(
                    text: value.getDisplayName(),
                    color: Colors.black,
                  );
                },
                dropdownItems: state.lawyers,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: _proceedingsController,
                isWhiteBackground: true,
                label: 'Case Proceedings',
                maxLines: 3,
                validatorCondition: Validator.notEmpty,
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  final status =
                      await locator<PermissionService>().getStoragePermission();
                  if (status == PermissionStatus.granted) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => OpenFile(
                          onPressed: (value) {
                            final temp = List.of(_selectedFilesNotifier.value);
                            temp.add(value);
                            _selectedFilesNotifier.value = temp;
                          },
                        ),
                      ),
                    );
                  } else {
                    CustomToast.show(
                      'External Files access is required!',
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
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder(
                valueListenable: _selectedFilesNotifier,
                builder: (context, files, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: files.length,
                    itemBuilder: (context, index) {
                      final file = files[index];
                      return _buildFIleItem(file);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<CaseBloc, CaseState>(
                bloc: BlocProvider.of<CaseBloc>(context),
                builder: (context, state) {
                  if (state is SubmittingCaseState) {
                    return const Loader();
                  }
                  return RoundedElevatedButton(
                    text: widget.isEdit ? 'Update' : 'Submit',
                    onPressed: _onSubmitPressed,
                    borderRadius: 23,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFIleItem(OpenFileModel file) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          color: Colors.green,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    textWidget(
                      text: 'Title:',
                      color: Colors.white,
                      fWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    textWidget(
                      text: file.title,
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    textWidget(
                      text: 'File name:',
                      color: Colors.white,
                      fWeight: FontWeight.w600,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: textWidget(
                        text: FileManager.basename(file.file),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -5,
          right: -5,
          child: GestureDetector(
            onTap: () {
              final temp = List.of(_selectedFilesNotifier.value);
              temp.removeWhere((element) {
                return element.file.path == file.file.path;
              });
              _selectedFilesNotifier.value = temp;
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(2.5),
              child: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
