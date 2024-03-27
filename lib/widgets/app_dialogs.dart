import 'dart:io';

import 'package:case_management/utils/validator.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';

import '../model/open_file_model.dart';

class AppDialogs {
  static Future<void> showFileSelectBottomSheet({
    required BuildContext context,
    required FileSystemEntity selectedFile,
    required ValueSetter<OpenFileModel> onSubmit,
  }) async {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                  text: 'Add File label:',
                  fWeight: FontWeight.bold,
                  fSize: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: controller,
                  validatorCondition: Validator.notEmpty,
                  label: 'File Label',
                  textInputType: TextInputType.text,
                  isWhiteBackground: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: TextEditingController(
                    text: FileManager.basename(selectedFile),
                  ),
                  validatorCondition: Validator.notEmpty,
                  label: 'Selected File',
                  enabled: false,
                  textInputType: TextInputType.text,
                  isWhiteBackground: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: RoundedElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        onSubmit(
                          OpenFileModel(
                            title: controller.text,
                            file: selectedFile,
                          ),
                        );
                      }
                    },
                    text: 'Submit',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showConfirmDialog({
    required BuildContext context,
    required String text,
    required VoidCallback onConfirm,
  }) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: textWidget(text: 'Confirm'),
          content: textWidget(text: text),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
