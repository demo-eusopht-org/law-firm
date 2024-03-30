import 'package:case_management/model/cases/case_history_response.dart';
import 'package:case_management/utils/date_time_utils.dart';
import 'package:case_management/view/cases/case_proceedings.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';

class HistoryDetail extends StatefulWidget {
  final CaseHistory history;
  final String caseNo;
  const HistoryDetail({
    super.key,
    required this.history,
    required this.caseNo,
  });

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Proceeding Detail',
      ),
      body: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCard(
                  'Hearing Date',
                  widget.history.hearingDate.getFormattedDate(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Card(
                    color: Colors.white,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textWidget(text: 'Hearing Proceedings:'),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 2,
                            child: textWidget(
                              text: widget.history.hearingProceedings,
                              maxline: 4,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildCard(
                  'Opposite Party Lawyer',
                  widget.history.oppositePartyAdvocate,
                ),
                const SizedBox(
                  height: 10,
                ),
                if (widget.history.caseAssignedTo != null)
                  _buildCard(
                    'Case Assignee',
                    widget.history.caseAssignedTo!.displayName,
                  ),
                if (widget.history.caseAssignedTo != null)
                  const SizedBox(
                    height: 10,
                  ),
                _buildCard(
                  'Judge',
                  widget.history.judgeName,
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildCard(
                  'Status',
                  widget.history.caseStatusName,
                ),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: RoundedElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CaseProceedings(
                            files: widget.history.files,
                            caseTitle: 'Case no: ${widget.caseNo}',
                            pageTitle: 'Proceeding Attachments',
                            caseNo: widget.caseNo,
                          ),
                        ),
                      );
                    },
                    text: 'View Attachments',
                    borderRadius: 23,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildCard(String label, String text) {
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
