import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../model/cases/all_cases_response.dart';

class CaseProceedings extends StatefulWidget {
  final List<CaseFile> files;
  const CaseProceedings({
    super.key,
    required this.files,
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
        title: 'Proceedings Attachments',
      ),
      // body: ListView(
      //   children: [
      //     SizedBox(
      //       height: 10,
      //     ),
      //     Row(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: textWidget(
      //             text: 'Case Title:',
      //             fSize: 16.0,
      //             fWeight: FontWeight.bold,
      //           ),
      //         ),
      //         Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: textWidget(
      //             text: 'Case Title',
      //             fSize: 16.0,
      //             fWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ],
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: textWidget(
      //         text: 'January 1, 2022',
      //         fSize: 16.0,
      //         fWeight: FontWeight.bold,
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               buildBox('Title 1'),
      //               SizedBox(width: 10),
      //               buildBox('Title 2'),
      //             ],
      //           ),
      //           SizedBox(height: 10),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             children: [
      //               buildBox('Title 3'),
      //               SizedBox(width: 10),
      //               buildBox('Title 4'),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (widget.files.isEmpty) {
      return Center(
        child: Text('No attachments available for this proceeding!'),
      );
    }
    return GroupedListView<CaseFile, DateTime>(
      elements: widget.files,
      groupBy: (file) {
        return file.createdAt;
      },
      itemBuilder: (context, file) {
        return buildBox(file.fileTitle);
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

  Widget buildBox(String title) {
    return Container(
      height: 100,
      color: Colors.grey[200],
      alignment: Alignment.center,
      child: textWidget(
        text: title,
        fSize: 16.0,
      ),
    );
  }
}
