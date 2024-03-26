import 'dart:io';

import 'package:file_manager/file_manager.dart';
import 'package:flutter/material.dart';

import '../../widgets/appbar_widget.dart';
import '../../widgets/text_widget.dart';

class OpenFile extends StatefulWidget {
  final ValueSetter<FileSystemEntity> onPressed;
  const OpenFile({
    super.key,
    required this.onPressed,
  });

  @override
  State<OpenFile> createState() => _OpenFileState();
}

class _OpenFileState extends State<OpenFile> {
  final FileManagerController controller = FileManagerController();

  @override
  void dispose() {
    controller.dispose();
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
      body: PopScope(
        canPop: false,
        onPopInvoked: (value) async {
          final isRoot = await controller.isRootDirectory();
          if (!isRoot) {
            controller.goToParentDirectory();
          }
        },
        child: FileManager(
          controller: controller,
          builder: (context, snapshot) {
            final List<FileSystemEntity> entities = snapshot;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: entities.length,
                itemBuilder: (context, index) {
                  final FileSystemEntity entity = entities[index];
                  final String fileName = FileManager.basename(entity);
                  return _buildFileItem(entity, fileName);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFileItem(
    FileSystemEntity entity,
    String fileName,
  ) {
    return Card(
      elevation: 5,
      color: Colors.white,
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FileManager.isFile(entity)
                ? const Icon(
                    Icons.feed_outlined,
                  )
                : const Icon(
                    Icons.folder,
                    size: 34,
                  ),
            const SizedBox(
              height: 5,
            ),
            textWidget(
              text: fileName,
              fSize: 14.0,
            ),
          ],
        ),
        onTap: () {
          if (FileManager.isDirectory(entity)) {
            controller.openDirectory(entity);
          } else {
            Navigator.pop(context);
            widget.onPressed(entity);
          }
        },
      ),
    );
  }
}
