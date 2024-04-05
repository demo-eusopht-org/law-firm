import 'dart:io';

import 'package:case_management/services/locator.dart';
import 'package:case_management/services/permission_service.dart';
import 'package:case_management/utils/validator.dart';
import 'package:case_management/view/admin/bloc/admin_bloc.dart';
import 'package:case_management/view/admin/bloc/admin_events.dart';
import 'package:case_management/view/cases/open_file.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/custom_textfield.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' hide context;
import 'package:permission_handler/permission_handler.dart';

import '../../../widgets/appbar_widget.dart';

class UploadTemplatePage extends StatefulWidget {
  const UploadTemplatePage({super.key});

  @override
  State<UploadTemplatePage> createState() => _UploadTemplatePageState();
}

class _UploadTemplatePageState extends State<UploadTemplatePage> {
  final _fileTitleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _fileNotifier = ValueNotifier<FileSystemEntity?>(null);

  Future<void> _onTapFileTextField() async {
    final status = await locator<PermissionService>().getStoragePermission();
    if (status == PermissionStatus.granted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => OpenFile(
            onPressed: (file) {
              _fileNotifier.value = file;
            },
          ),
        ),
      );
    } else {
      CustomToast.show('File access permission needed!');
    }
  }

  void _onSubmitTap() {
    if (_formKey.currentState!.validate()) {
      final file = _fileNotifier.value;
      if (file != null) {
        BlocProvider.of<AdminBloc>(context).add(
          UploadTemplateAdminEvent(
            file: File(file.path),
            fileTitle: _fileTitleController.text,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    _fileTitleController.dispose();
    _fileNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        title: 'Upload Template',
        showBackArrow: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(
              controller: _fileTitleController,
              isWhiteBackground: true,
              label: 'File title',
              validatorCondition: Validator.notEmpty,
            ),
            const SizedBox(
              height: 10,
            ),
            ValueListenableBuilder(
              valueListenable: _fileNotifier,
              builder: (context, value, child) {
                return GestureDetector(
                  onTap: _onTapFileTextField,
                  child: CustomTextField(
                    controller: TextEditingController(
                      text: value != null ? basename(value.path) : null,
                    ),
                    enabled: false,
                    isWhiteBackground: true,
                    label: 'File',
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            RoundedElevatedButton(
              onPressed: _onSubmitTap,
              text: 'Submit',
            ),
          ],
        ),
      ),
    );
  }
}
