import 'package:case_management/view/cases/case_details.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'case_attachments.dart';
import 'case_proceedings.dart';
import 'create_new_case.dart';

class Cases extends StatefulWidget {
  bool showTile = false;
  Cases({
    super.key,
    required this.showTile,
  });

  @override
  State<Cases> createState() => _CasesState();
}

class _CasesState extends State<Cases> {
  final List<Map<String, String>> cases = [
    {
      'id': '001',
      'Date': '2/28/2024',
      'Status': 'Pending',
      'description': 'LLB,MBBS',
      'cnic': '12345-6789012-3',
    },
    {
      'id': '002',
      'Date': '2/28/2024',
      'Status': 'Approved',
      'description': 'LLB,MBBS',
      'cnic': '12345-6789012-3',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      floatingActionButton: Container(
        width: size.width * 0.5,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23),
          ),
          backgroundColor: Colors.green,
          child: textWidget(
            text: 'Create a New Case',
            color: Colors.white,
            fSize: 16.0,
            fWeight: FontWeight.w700,
          ),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (context) => CreateNewCase(isEdit: false),
              ),
            );
          },
        ),
      ),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Cases',
      ),
      body: ListView.builder(
        itemCount: cases.length,
        itemBuilder: (context, index) {
          final lawyer = cases[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,
              elevation: 5,
              child: widget.showTile
                  ? ExpansionTile(
                      childrenPadding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(side: BorderSide.none),
                      title: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                textWidget(
                                  text: 'Case No:',
                                  fSize: 14.0,
                                  fWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                textWidget(
                                  text: '${lawyer['id']}',
                                  fSize: 14.0,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                textWidget(
                                  text: 'Date:',
                                  fSize: 14.0,
                                  fWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                textWidget(
                                  text: '${lawyer['Date']}',
                                  fSize: 14.0,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                textWidget(
                                  text: 'Status:',
                                  fSize: 14.0,
                                  fWeight: FontWeight.w600,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                textWidget(
                                  text: '${lawyer['Status']}',
                                  fSize: 14.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildContainer(
                              'View Case',
                              () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => CaseDetails(),
                                ),
                              ),
                            ),
                            buildContainer(
                              'View Attachments',
                              () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => CaseAttachments(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildContainer(
                              'View Proceedings',
                              () => Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => CaseProceedings(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildContainer(
                              'Assign to Lawyer',
                              () => {},
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildContainer(
                          'Assign to Client',
                          () => {},
                        ),
                      ],
                    )
                  : ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.green,
                              title: textWidget(
                                text: "Confirmation",
                              ),
                              content: textWidget(
                                text:
                                    "Are you sure you want to assign the case to Waqas?",
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: textWidget(text: "Yes"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: textWidget(text: "No"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textWidget(
                            text: '${lawyer['id']}',
                            fSize: 14.0,
                          ),
                          textWidget(
                            text: '${lawyer['Date']}',
                            fSize: 14.0,
                          ),
                          textWidget(
                            text: '${lawyer['Status']}',
                            fSize: 14.0,
                          ),
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  Container buildContainer(String text, void Function() onPressed) {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(150, 42),
          backgroundColor: Colors.green,
        ),
        child: textWidget(
          text: text,
          fSize: 13.0,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
