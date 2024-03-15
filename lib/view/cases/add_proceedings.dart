import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../model/open_file_model.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/date_field.dart';
import '../../widgets/dropdown_fields.dart';
import '../../widgets/text_widget.dart';
import 'open_file.dart';

class AddProceedings extends StatefulWidget {
  const AddProceedings({super.key});

  @override
  State<AddProceedings> createState() => _AddProceedingsState();
}

class _AddProceedingsState extends State<AddProceedings> {
  final FileManagerController controller = FileManagerController();
  final _selectedFilesNotifier = ValueNotifier<List<OpenFileModel>>([]);

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
        title: 'Add Proceedings',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  hintText: 'Judge name',
                  isWhiteBackground: true,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFieldWithDropdown<String>(
                  hintText: 'Case Status',
                  isWhiteBackground: true,
                  onDropdownChanged: (newValue) {
                    print('Case Type: $newValue');
                  },
                  builder: (String value) {
                    return textWidget(
                      text: value,
                      color: Colors.black,
                    );
                  },
                  dropdownItems: [
                    'Approved',
                    'Pending',
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Case Proceedings',
                  isWhiteBackground: true,
                  maxlines: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Opposite Party Lawyer',
                  isWhiteBackground: true,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Assignee Switch Reason',
                  isWhiteBackground: true,
                  maxlines: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                DatePickerField(
                  hintText: 'Next Hearing Date',
                  isWhiteBackground: true,
                  hintColor: true,
                  onDateChanged: (DateTime selectedDate) {
                    print('Selected date: $selectedDate');
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFieldWithDropdown<String>(
                  hintText: 'Next Assignee',
                  isWhiteBackground: true,
                  onDropdownChanged: (newValue) {
                    print('Case Type: $newValue');
                  },
                  builder: (String value) {
                    return textWidget(
                      text: value,
                      color: Colors.black,
                    );
                  },
                  dropdownItems: [
                    'Waqas',
                    'Salman',
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () async {
                    final status =
                        await Permission.manageExternalStorage.request();
                    if (status == PermissionStatus.granted) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => OpenFile(
                            onPressed: (value) {
                              final temp =
                                  List.of(_selectedFilesNotifier.value);
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
                SizedBox(
                  height: 20,
                ),
                RoundedElevatedButton(
                  text: 'Submit',
                  onPressed: () {},
                  borderRadius: 23,
                ),
              ],
            ),
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
