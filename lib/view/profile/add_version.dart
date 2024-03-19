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

import '../../widgets/text_widget.dart';
import '../../widgets/toast.dart';

class AddVersion extends StatefulWidget {
  const AddVersion({super.key});

  @override
  State<AddVersion> createState() => _AddVersionState();
}

class _AddVersionState extends State<AddVersion> {
  final _selectedFileNotifier = ValueNotifier<PlatformFile?>(null);

  TextEditingController versionController = TextEditingController();
  TextEditingController releaseController = TextEditingController();
  TextEditingController forceController = TextEditingController();
  bool? selectedValue;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _openFilePicker(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        _selectedFileNotifier.value = result.files.first;
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
                  controller: versionController,
                  textInputType: TextInputType.phone,
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
                    selectedValue = newValue;
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
                  textInputType: TextInputType.number,
                  hintText: 'Select File',
                  isWhiteBackground: true,
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
                          print('check');
                          BlocProvider.of<ProfileBloc>(context).add(
                            UpdateVersionEvent(
                              release_notes: releaseController.text.trim(),
                              version_number: versionController.text.trim(),
                              force_update: versionController.text.trim(),
                              file: _selectedFileNotifier.value!,
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
