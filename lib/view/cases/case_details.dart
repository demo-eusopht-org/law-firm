import 'package:case_management/view/cases/create_new_case.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/button_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../history/view_history.dart';
import 'add_proceedings.dart';

class CaseDetails extends StatefulWidget {
  const CaseDetails({
    super.key,
  });

  @override
  State<CaseDetails> createState() => _CaseDetailsState();
}

class _CaseDetailsState extends State<CaseDetails> {
  final List<Map<String, String>> casesDetails = [
    {
      'id': '001',
      'Date': '2/28/2024',
      'category': 'Property Case',
      'reportedDate': '1/28/2024',
      'Court': 'Sindh High Court',
      'Status': 'Pending',
      'case': 'Advocate Waqas',
      'nexthearing': '3/28/2024',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Case Details',
        action: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CreateNewCase(isEdit: true),
                    ),
                  );
                },
                icon: Icon(
                  Icons.edit,
                ),
                color: Colors.white,
              ),
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
            child: ListView.builder(
              itemCount: casesDetails.length,
              itemBuilder: (context, index) {
                final lawyer = casesDetails[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCard(lawyer, 'Case No', 'id'),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Category',
                        'category',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Reported Date',
                        'reportedDate',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Court',
                        'Court',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Next Hearing',
                        'nexthearing',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Case Assignee',
                        'case',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: size.height * 0.06,
              width: size.width * 0.5,
              child: RoundedElevatedButton(
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
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: size.height * 0.06,
              width: size.width * 0.5,
              child: RoundedElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ViewHistory(),
                    ),
                  );
                },
                text: 'View History',
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCard(Map<String, String> lawyer, String label, String text) {
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
                text: '${lawyer[text]}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
