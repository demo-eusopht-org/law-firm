import 'dart:io';

import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_textfield.dart';

class OpenFile extends StatefulWidget {
  const OpenFile({super.key});

  @override
  State<OpenFile> createState() => _OpenFileState();
}

class _OpenFileState extends State<OpenFile> {
  final FileManagerController controller = FileManagerController();
  final TextEditingController titleController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _fileNotifier = ValueNotifier<FileSystemEntity?>(null);

  @override
  void dispose() {
    _fileNotifier.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'File Manager',
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: CustomTextField(
                controller: titleController,
                hintText: 'Enter file title',
                isWhiteBackground: true,
                validatorCondition: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your title';
                  }
                  return null;
                },
              ),
            ),
            Expanded(
              child: FileManager(
                controller: controller,
                builder: (context, snapshot) {
                  final List<FileSystemEntity> entities = snapshot;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: entities.length,
                      itemBuilder: (context, index) {
                        final FileSystemEntity entity = entities[index];
                        final String fileName = FileManager.basename(entity);
                        return ValueListenableBuilder(
                          valueListenable: _fileNotifier,
                          builder: (context, file, child) {
                            return _buildFileItem(file, entity, fileName);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _fileNotifier,
              builder: (context, file, child) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: _fileNotifier.value != null
                      ? RoundedElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {}
                          },
                          text: 'Submit',
                        )
                      : SizedBox.shrink(),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFileItem(
    FileSystemEntity? selectedFile,
    FileSystemEntity entity,
    String fileName,
  ) {
    final isFileSelected =
        selectedFile != null && selectedFile.path == entity.path;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Card(
          elevation: 5,
          color: Colors.white,
          clipBehavior: Clip.none,
          shape: RoundedRectangleBorder(
            side: isFileSelected
                ? BorderSide(
                    color: Colors.pink,
                  )
                : BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FileManager.isFile(entity)
                    ? Icon(
                        Icons.feed_outlined,
                      )
                    : Icon(
                        Icons.folder,
                        size: 34,
                      ),
                SizedBox(
                  height: 5,
                ),
                textWidget(
                  text: '$fileName',
                  fSize: 14.0,
                ),
              ],
            ),
            onTap: () {
              if (FileManager.isDirectory(entity)) {
                controller.openDirectory(entity);
              } else {
                _fileNotifier.value = entity;
              }
            },
          ),
        ),
        if (isFileSelected)
          Positioned(
            top: -5,
            right: -5,
            child: Container(
              padding: EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
          ),
      ],
    );
  }
}
