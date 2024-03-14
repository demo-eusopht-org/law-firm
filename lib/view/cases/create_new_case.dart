import 'package:case_management/model/cases/case_status.dart';
import 'package:case_management/model/cases/case_type.dart';
import 'package:case_management/model/cases/court_type.dart';
import 'package:case_management/model/open_file_model.dart';
import 'package:case_management/view/cases/bloc/case_bloc.dart';
import 'package:case_management/view/cases/bloc/case_events.dart';
import 'package:case_management/view/cases/bloc/case_states.dart';
import 'package:case_management/view/cases/open_file.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final _selectedFilesNotifier = ValueNotifier<List<OpenFileModel>>([]);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<CaseBloc>(context).add(
        GetDataCaseEvent(),
      ),
    );
  }

  @override
  void dispose() {
    _selectedFilesNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: widget.isEdit ? 'Update' : 'Create a New Case',
      ),
      body: _buildBody(context),
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
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildForm(DataSuccessCaseState state) {
    return SingleChildScrollView(
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
              hintText: 'Case No',
            ),
            SizedBox(height: 10),
            CustomTextField(
              isWhiteBackground: true,
              hintText: 'Plaintiff',
            ),
            SizedBox(height: 10),
            CustomTextField(
              isWhiteBackground: true,
              hintText: 'Defendant',
            ),
            SizedBox(height: 10),
            CustomTextField(
              isWhiteBackground: true,
              hintText: 'Plaintiff_Advocate',
            ),
            SizedBox(height: 10),
            CustomTextFieldWithDropdown<CaseType>(
              hintText: 'Case Type',
              isWhiteBackground: true,
              onDropdownChanged: (newValue) {
                print('Case Type: ${newValue.type}');
              },
              builder: (value) {
                return textWidget(
                  text: value.type,
                  color: Colors.black,
                );
              },
              dropdownItems: state.caseTypes,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithDropdown<CaseStatus>(
              hintText: 'Case Status',
              isWhiteBackground: true,
              onDropdownChanged: (newValue) {
                print('Case Type: $newValue');
              },
              builder: (value) {
                return textWidget(
                  text: value.statusName,
                  color: Colors.black,
                );
              },
              dropdownItems: state.caseStatuses,
            ),
            SizedBox(height: 10),
            CustomTextFieldWithDropdown<CourtType>(
              isWhiteBackground: true,
              hintText: 'Court Type',
              dropdownItems: state.courtTypes,
              onDropdownChanged: (newValue) {},
              builder: (value) {
                return textWidget(
                  text: value.court,
                  color: Colors.black,
                );
              },
            ),
            SizedBox(height: 10),
            CustomTextFieldWithDropdown<String>(
              hintText: 'Case Customer Id',
              isWhiteBackground: true,
              onDropdownChanged: (newValue) {
                print('Case Customer Id: $newValue');
              },
              builder: (value) {
                return textWidget(
                  text: value,
                  color: Colors.black,
                );
              },
              dropdownItems: [
                'Tauqeer',
                'Burhan',
                'Waqas',
              ],
            ),
            SizedBox(height: 10),
            CustomTextField(
              isWhiteBackground: true,
              hintText: 'Customer Plantiff',
            ),
            SizedBox(height: 10),
            DatePickerField(
              hintText: 'Case Filling Date',
              isWhiteBackground: true,
              hintColor: true,
              onDateChanged: (DateTime selectedDate) {
                print('Selected date: $selectedDate');
              },
            ),
            SizedBox(height: 10),
            DatePickerField(
              hintText: 'Next Hearing Date',
              isWhiteBackground: true,
              hintColor: true,
              onDateChanged: (DateTime selectedDate) {
                print('Selected date: $selectedDate');
              },
            ),
            SizedBox(height: 10),
            CustomTextField(
              isWhiteBackground: true,
              hintText: 'Judge',
            ),
            SizedBox(height: 10),
            CustomTextFieldWithDropdown<String>(
              hintText: 'Select Court',
              isWhiteBackground: true,
              onDropdownChanged: (newValue) {
                print('Selected Category: $newValue');
              },
              builder: (value) {
                return textWidget(
                  text: value,
                  color: Colors.black,
                );
              },
              dropdownItems: [
                'Sindh High Court',
                'Punjab High Court',
              ],
            ),
            SizedBox(height: 10),
            CustomTextFieldWithDropdown<String>(
              hintText: 'Case Assigneed To',
              isWhiteBackground: true,
              onDropdownChanged: (newValue) {
                print('Selected Category: $newValue');
              },
              builder: (value) {
                return textWidget(
                  text: value,
                  color: Colors.black,
                );
              },
              dropdownItems: [
                'Advocate Waqas',
                'Advocate Jawwad',
              ],
            ),
            SizedBox(height: 10),
            CustomTextField(
              isWhiteBackground: true,
              hintText: 'Case Proceedings',
              maxlines: 2,
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () async {
                final status = await Permission.manageExternalStorage.request();
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
            SizedBox(height: 20),
            RoundedElevatedButton(
              text: widget.isEdit ? 'Update' : 'Submit',
              onPressed: () {
                Navigator.pop(context);
              },
              borderRadius: 23,
            ),
          ],
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
