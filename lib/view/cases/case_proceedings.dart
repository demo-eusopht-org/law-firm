import 'dart:io';

import 'package:case_management/model/open_file_model.dart';
import 'package:case_management/services/file_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/utils/constants.dart';
import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/cases/bloc/case_bloc.dart';
import 'package:case_management/view/cases/bloc/case_events.dart';
import 'package:case_management/view/cases/bloc/case_states.dart';
import 'package:case_management/view/cases/open_file.dart';
import 'package:case_management/widgets/app_dialogs.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:case_management/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../model/cases/all_cases_response.dart';

class CaseProceedings extends StatefulWidget {
  final String pageTitle;
  final String caseTitle;
  final String caseNo;

  const CaseProceedings({
    super.key,
    required this.pageTitle,
    required this.caseTitle,
    required this.caseNo,
  });

  @override
  State<CaseProceedings> createState() => _CaseProceedingsState();
}

class _CaseProceedingsState extends State<CaseProceedings> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => BlocProvider.of<CaseBloc>(context).add(
        GetCaseFilesEvent(caseNo: widget.caseNo),
      ),
    );
  }

  void _onSelectFile(FileSystemEntity file) {
    AppDialogs.showFileSelectBottomSheet(
      context: context,
      selectedFile: file,
      onSubmit: (OpenFileModel selectedFile) {
        BlocProvider.of<CaseBloc>(context).add(
          UploadCaseFileEvent(
            file: selectedFile,
            caseNo: widget.caseNo,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: widget.pageTitle,
      ),
      floatingActionButton: _buildFloatingActionButton(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: textWidget(
              text: widget.caseTitle,
              fWeight: FontWeight.bold,
              fSize: 18,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CaseBloc, CaseState>(
      bloc: BlocProvider.of<CaseBloc>(context),
      builder: (context, state) {
        if (state is LoadingCaseState) {
          return const Loader();
        } else if (state is ErrorCaseState) {
          return Center(
            child: textWidget(text: state.message),
          );
        } else if (state is SuccessAllFilesState) {
          return _buildFilesList(state.files);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildFilesList(List<CaseFile> files) {
    if (files.isEmpty) {
      return const Center(
        child: Text('No attachments available for this proceeding!'),
      );
    }
    return GroupedListView<CaseFile, String>(
      elements: files,
      groupBy: (file) {
        return file.createdAt.getFormattedDate();
      },
      itemBuilder: (context, file) {
        return _buildBox(file.fileTitle, file.fileName);
      },
      groupHeaderBuilder: (file) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              textWidget(
                text: file.createdAt.getFormattedDate(),
                fWeight: FontWeight.bold,
              ),
              const Expanded(
                child: Divider(
                  indent: 10,
                  endIndent: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBox(String title, String filename) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 5),
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          textWidget(
            text: title,
            fSize: 16.0,
          ),
          IconButton(
            onPressed: () async {
              final url = Constants.getCaseFileUrl(widget.caseNo, filename);
              final savedPath = await locator<FileService>().download(
                url: url,
                filename: filename,
              );
              if (savedPath == null) {
                CustomToast.show(
                  'Could not download file!',
                );
              } else {
                CustomToast.show(
                  'File downloaded to: $savedPath',
                );
              }
            },
            icon: const Icon(
              Icons.download,
              color: Colors.green,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return RoundedElevatedButton(
      onPressed: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => OpenFile(
            onPressed: _onSelectFile,
          ),
        ),
      ),
      text: 'Add attachment',
    );
  }
}
