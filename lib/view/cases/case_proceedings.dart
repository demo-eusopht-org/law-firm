import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../model/cases/all_cases_response.dart';

class CaseProceedings extends StatefulWidget {
  final List<CaseFile> files;
  final String pageTitle;
  final String caseTitle;
  const CaseProceedings({
    super.key,
    required this.files,
    required this.pageTitle,
    required this.caseTitle,
  });

  @override
  State<CaseProceedings> createState() => _CaseProceedingsState();
}

class _CaseProceedingsState extends State<CaseProceedings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: widget.pageTitle,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
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
    if (widget.files.isEmpty) {
      return Center(
        child: Text('No attachments available for this proceeding!'),
      );
    }
    return GroupedListView<CaseFile, String>(
      elements: widget.files,
      groupBy: (file) {
        return file.createdAt.getFormattedDate();
      },
      itemBuilder: (context, file) {
        return _buildBox(file.fileTitle);
      },
      groupHeaderBuilder: (file) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              textWidget(
                text: file.createdAt.getFormattedDate(),
                fWeight: FontWeight.bold,
              ),
              Expanded(
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

  Widget _buildBox(String title) {
    return Container(
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 5),
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: textWidget(
        text: title,
        fSize: 16.0,
      ),
    );
  }
}
