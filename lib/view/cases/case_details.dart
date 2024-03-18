import 'package:case_management/model/cases/all_cases_response.dart';
import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/cases/case_attachments.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/expandable_fab.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../history/view_history.dart';
import 'add_proceedings.dart';

class CaseDetails extends StatefulWidget {
  final Case caseData;
  const CaseDetails({
    super.key,
    required this.caseData,
  });

  @override
  State<CaseDetails> createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ExpandableFab(
        distance: 100,
        children: [
          RoundedElevatedButton(
            borderRadius: 23,
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ViewHistory(
                    caseNo: widget.caseData.caseNo,
                  ),
                ),
              );
            },
            text: 'View History',
          ),
          RoundedElevatedButton(
            borderRadius: 23,
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => AddProceedings(),
                ),
              );
            },
            text: 'Add Proceedings',
          ),
          RoundedElevatedButton(
            borderRadius: 23,
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => CaseAttachments(
                    caseData: widget.caseData,
                  ),
                ),
              );
            },
            text: 'View Attachments',
          ),
        ],
      ),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Case Details',
        action: [
          Row(
            children: [
              // IconButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       CupertinoPageRoute(
              //         builder: (context) => CreateNewCase(isEdit: true),
              //       ),
              //     );
              //   },
              //   icon: Icon(
              //     Icons.edit,
              //   ),
              //   color: Colors.white,
              // ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.delete,
                ),
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildCard(
                      'Case No',
                      widget.caseData.caseNo,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Plaintiff',
                      widget.caseData.plaintiff,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Defendant',
                      widget.caseData.defendant,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Plaintiff Advocate',
                      widget.caseData.plaintiffAdvocate,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Defendant Advocate',
                      widget.caseData.defendantAdvocate,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Case Status',
                      widget.caseData.caseStatus,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Case Type',
                      widget.caseData.caseType,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Reported Date',
                      widget.caseData.caseFilingDate.getFormattedDateTime(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Court Type',
                      widget.caseData.courtType,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Next Hearing',
                      widget.caseData.nextHearingDate.getFormattedDateTime(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Case Assignee',
                      widget.caseData.caseCustomer.displayName,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget buildCard(String label, String text) {
    return SizedBox(
      height: 60,
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget(text: label),
              textWidget(
                text: text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
