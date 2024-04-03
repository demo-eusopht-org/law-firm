import 'package:case_management/model/cases/all_cases_response.dart';
import 'package:case_management/utils/constants.dart';
import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/cases/bloc/case_bloc.dart';
import 'package:case_management/view/cases/bloc/case_events.dart';
import 'package:case_management/view/cases/case_proceedings.dart';
import 'package:case_management/widgets/app_dialogs.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/expandable_fab.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildCreateButton(context),
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
              if (configNotifier.value.contains(Constants.deleteCase))
                IconButton(
                  onPressed: () {
                    AppDialogs.showConfirmDialog(
                      context: context,
                      text: 'Are you sure you want to delete this case?',
                      onConfirm: () {
                        BlocProvider.of<CaseBloc>(context).add(
                          DeleteCaseEvent(caseNo: widget.caseData.caseNo),
                        );
                        Navigator.pop(context);
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                  ),
                  color: Colors.red,
                ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
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
                    const SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Plaintiff',
                      widget.caseData.plaintiff,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Defendant',
                      widget.caseData.defendant,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Plaintiff Advocate',
                      widget.caseData.plaintiffAdvocate,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Defendant Advocate',
                      widget.caseData.defendantAdvocate,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Case Status',
                      widget.caseData.caseStatus,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Case Type',
                      widget.caseData.caseType,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Reported Date',
                      widget.caseData.caseFilingDate.getFormattedDateTime(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildCard(
                      'Court Type',
                      widget.caseData.courtType,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.caseData.nextHearingDate != null)
                      buildCard(
                        'Next Hearing',
                        widget.caseData.nextHearingDate!.getFormattedDateTime(),
                      ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (widget.caseData.caseCustomer != null)
                      buildCard(
                        'Case Assignee',
                        widget.caseData.caseCustomer!.displayName,
                      ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Visibility _buildCreateButton(BuildContext context) {
    return Visibility(
      visible: configNotifier.value.contains(Constants.createCase),
      child: ExpandableFab(
        distance: 110,
        children: [
          RoundedElevatedButton(
            borderRadius: 23,
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => ViewHistory(
                    caseData: widget.caseData,
                  ),
                ),
              );
            },
            text: 'View Proceedings',
          ),
          if (configNotifier.value.contains(Constants.addProceedings))
            RoundedElevatedButton(
              borderRadius: 23,
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => AddProceedings(
                      caseNo: widget.caseData.caseNo,
                    ),
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
                  builder: (context) => CaseProceedings(
                    caseTitle: 'Case Title: ${widget.caseData.caseTitle}',
                    pageTitle: 'Case Attachments',
                    caseNo: widget.caseData.caseNo,
                  ),
                ),
              );
            },
            text: 'Add Attachments',
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
