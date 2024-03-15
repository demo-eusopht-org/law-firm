import 'package:case_management/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../model/cases/all_cases_response.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/text_widget.dart';

class CaseAttachments extends StatefulWidget {
  final Case caseData;
  const CaseAttachments({
    super.key,
    required this.caseData,
  });

  @override
  State<CaseAttachments> createState() => _CaseAttachmentsState();
}

class _CaseAttachmentsState extends State<CaseAttachments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Case Attachments',
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textWidget(
                  text: 'Case Title:',
                  fSize: 16.0,
                  fWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textWidget(
                    text: widget.caseData.caseTitle,
                    fSize: 15.0,
                    fWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: GroupedListView<CaseFile, DateTime>(
              elements: widget.caseData.caseFiles,
              groupBy: (file) {
                return file.createdAt;
              },
              itemBuilder: (context, file) {
                return buildBox(file.fileTitle);
              },
              groupComparator: (date1, date2) {
                return date1.compareTo(date2);
              },
              groupHeaderBuilder: (file) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: textWidget(
                    text: file.createdAt.getFormattedDate(),
                    fSize: 16.0,
                    fWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
          // Expanded(
          //   child: GroupedListView<CaseFile, DateTime>(
          //     elements: widget.caseData.caseFiles,
          //     // groupBy: (file) {
          //     //   // return file.
          //     // },
          //     children: [
          //       SizedBox(
          //         height: 10,
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: textWidget(
          //           text: 'January 1, 2022',
          //           fSize: 16.0,
          //           fWeight: FontWeight.bold,
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 buildBox('Title 1'),
          //                 SizedBox(width: 10),
          //                 buildBox('Title 2'),
          //               ],
          //             ),
          //             SizedBox(height: 10),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 buildBox('Title 3'),
          //                 SizedBox(width: 10),
          //                 buildBox('Title 4'),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: textWidget(
          //           text: 'March 6, 2024',
          //           fSize: 16.0,
          //           fWeight: FontWeight.bold,
          //         ),
          //       ),
          //       // Box layout
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 buildBox('Title 1'),
          //                 SizedBox(width: 10),
          //                 buildBox('Title 2'),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
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
