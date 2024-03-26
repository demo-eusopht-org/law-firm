import 'package:case_management/model/cases/case_status.dart';
import 'package:case_management/model/get_all_lawyers_model.dart';
import 'package:case_management/view/history/bloc/history_bloc.dart';
import 'package:case_management/view/history/bloc/history_events.dart';
import 'package:case_management/view/history/bloc/history_states.dart';
import 'package:case_management/widgets/app_dialogs.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/open_file_model.dart';
import '../../services/locator.dart';
import '../../services/permission_service.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/date_field.dart';
import '../../widgets/dropdown_fields.dart';
import '../../widgets/text_widget.dart';
import 'open_file.dart';

class AddProceedings extends StatefulWidget {
  final String caseNo;
  const AddProceedings({
    super.key,
    required this.caseNo,
  });

  @override
  State<AddProceedings> createState() => _AddProceedingsState();
}

class _AddProceedingsState extends State<AddProceedings> {
  final FileManagerController controller = FileManagerController();
  final _formKey = GlobalKey<FormState>();
  final _selectedFilesNotifier = ValueNotifier<List<OpenFileModel>>([]);
  final _judgeNameController = TextEditingController();
  final _proceedingsController = TextEditingController();
  final _oppositeLawyerController = TextEditingController();
  final _assigneeSwitchController = TextEditingController();
  DateTime? _nextHearingDate;
  CaseStatus? _caseStatus;
  AllLawyer? _nextAssignee;

  Future<void> _onSubmitPressed() async {
    final validate = _validate();
    if (!validate) {
      return;
    }
    BlocProvider.of<HistoryBloc>(context).add(
      CreateProceedingEvent(
        caseNo: widget.caseNo,
        judgeName: _judgeNameController.text,
        status: _caseStatus!,
        proceedings: _proceedingsController.text,
        oppositePartyLawyer: _oppositeLawyerController.text,
        assigneeSwitchReason: _assigneeSwitchController.text,
        nextHearingDate: _nextHearingDate!,
        nextAssignee: _nextAssignee!,
        files: _selectedFilesNotifier.value,
      ),
    );
  }

  bool _validate() {
    final isValidated = _formKey.currentState!.validate();
    if (!isValidated) {
      return false;
    }
    if (_caseStatus == null) {
      CustomToast.show('Please select a case status!');
      return false;
    } else if (_nextHearingDate == null) {
      CustomToast.show('Please select next hearing date!');
      return false;
    } else if (_nextAssignee == null) {
      CustomToast.show('Please select next assignee!');
      return false;
    } else if (_selectedFilesNotifier.value.isEmpty) {
      CustomToast.show('Please select at least one file!');
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        BlocProvider.of<HistoryBloc>(context).add(
          GetDataHistoryEvent(),
        );
      },
    );
  }

  Future<void> _onAddFilesTap() async {
    final status = await locator<PermissionService>().getStoragePermission();
    if (status == PermissionStatus.granted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => OpenFile(
            onPressed: (value) {
              AppDialogs.showFileSelectBottomSheet(
                context: context,
                selectedFile: value,
                onSubmit: (fileModel) {
                  final temp = List.of(_selectedFilesNotifier.value);
                  temp.add(fileModel);
                  _selectedFilesNotifier.value = temp;
                },
              );
            },
          ),
        ),
      );
    } else {
      CustomToast.show('External Files access is needed!');
    }
  }

  @override
  void dispose() {
    _selectedFilesNotifier.dispose();
    _judgeNameController.dispose();
    _proceedingsController.dispose();
    _oppositeLawyerController.dispose();
    _assigneeSwitchController.dispose();
    super.dispose();
  }

  void _listener(BuildContext context, HistoryState state) {
    if (state is SuccessCreateProceedingState) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<HistoryBloc>(context),
      listener: _listener,
      child: Scaffold(
        appBar: AppBarWidget(
          context: context,
          showBackArrow: true,
          title: 'Add Proceedings',
        ),
        body: _buildBody(context),
      ),
    );
  }

  BlocBuilder _buildBody(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      bloc: BlocProvider.of<HistoryBloc>(context),
      builder: (context, state) {
        if (state is LoadingHistoryState) {
          return const Loader();
        } else if (state is DataSuccessState) {
          return _buildForm(state);
        }
        return Center(
          child: Text('Something went wrong!'),
        );
      },
    );
  }

  Widget _buildForm(DataSuccessState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: _judgeNameController,
                hintText: 'Judge name',
                isWhiteBackground: true,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFieldWithDropdown<CaseStatus>(
                hintText: 'Case Status',
                isWhiteBackground: true,
                onDropdownChanged: (newValue) {
                  _caseStatus = newValue;
                },
                builder: (CaseStatus value) {
                  return textWidget(
                    text: value.statusName,
                    color: Colors.black,
                  );
                },
                dropdownItems: state.statuses,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _proceedingsController,
                hintText: 'Case Proceedings',
                isWhiteBackground: true,
                maxLines: 2,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _oppositeLawyerController,
                hintText: 'Opposite Party Lawyer',
                isWhiteBackground: true,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: _assigneeSwitchController,
                hintText: 'Assignee Switch Reason',
                isWhiteBackground: true,
                maxLines: 2,
              ),
              SizedBox(
                height: 10,
              ),
              DatePickerField(
                hintText: 'Next Hearing Date',
                isWhiteBackground: true,
                dateFormat: DateFormat('MMM dd, yyyy'),
                hintColor: true,
                onDateChanged: (DateTime selectedDate) {
                  _nextHearingDate = selectedDate;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextFieldWithDropdown<AllLawyer>(
                hintText: 'Next Assignee',
                isWhiteBackground: true,
                onDropdownChanged: (newValue) {
                  _nextAssignee = newValue;
                },
                builder: (AllLawyer value) {
                  return textWidget(
                    text: value.getDisplayName(),
                    color: Colors.black,
                  );
                },
                dropdownItems: state.lawyers,
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: _onAddFilesTap,
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
              SizedBox(
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
              SizedBox(
                height: 20,
              ),
              RoundedElevatedButton(
                text: 'Submit',
                onPressed: _onSubmitPressed,
                borderRadius: 23,
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
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
                    SizedBox(
                      width: 3,
                    ),
                    textWidget(
                      text: file.title,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    textWidget(
                      text: 'File name:',
                      color: Colors.white,
                      fWeight: FontWeight.w600,
                    ),
                    SizedBox(
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
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(2.5),
              child: Icon(
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
