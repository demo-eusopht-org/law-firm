import 'package:case_management/view/profile/profile_bloc/profile_bloc.dart';
import 'package:case_management/view/profile/profile_bloc/profile_events.dart';
import 'package:case_management/view/profile/profile_bloc/profile_states.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/dropdown_fields.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/open_file_model.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/toast.dart';

class AddVersion extends StatefulWidget {
  const AddVersion({super.key});

  @override
  State<AddVersion> createState() => _AddVersionState();
}

class _AddVersionState extends State<AddVersion> {
  final _selectedFilesNotifier = ValueNotifier<List<OpenFileModel>>([]);
  TextEditingController versionController = TextEditingController();
  TextEditingController releaseController = TextEditingController();
  TextEditingController forceController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static void _openFilePicker(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        print('File picked: ${result.files.first.path}');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Add Version',
      ),
      body: BlocListener(
        bloc: BlocProvider.of<ProfileBloc>(context),
        listener: (context, state) {
          if (state is SuccessProfileState) {
            CustomToast.show('file submitted successfully!');
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  textInputType: TextInputType.number,
                  hintText: 'Version Number',
                  isWhiteBackground: true,
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter app version';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: releaseController,
                  textInputType: TextInputType.number,
                  hintText: 'Release Notes',
                  isWhiteBackground: true,
                  maxlines: 2,
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter relase notes';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextFieldWithDropdown(
                  hintText: 'Forceupdate',
                  isWhiteBackground: true,
                  onDropdownChanged: (newValue) {
                    print('forceupdate: $newValue');
                  },
                  builder: (value) {
                    return textWidget(
                      text: value ? 'Yes' : 'No',
                      color: Colors.black,
                    );
                  },
                  dropdownItems: [true, false],
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onTap: () => _openFilePicker(context),
                  readonly: true,
                  controller: releaseController,
                  textInputType: TextInputType.number,
                  hintText: 'Select File',
                  isWhiteBackground: true,
                  validatorCondition: (value) {
                    if (value!.isEmpty) {
                      return 'Please select file';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<ProfileBloc, ProfileState>(
                  bloc: BlocProvider.of<ProfileBloc>(context),
                  builder: (context, state) {
                    if (state is LoadingProfileState) {
                      return const Loader();
                    }
                    return RoundedElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<ProfileBloc>(context).add(
                            UpdateVersionEvent(
                              release_notes: releaseController.text.trim(),
                              version_number: double.parse(
                                versionController.text.trim(),
                              ),
                              force_update: int.parse(
                                versionController.text.trim(),
                              ),
                              files: _selectedFilesNotifier.value,
                            ),
                          );
                        }
                      },
                      text: 'Submit',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
