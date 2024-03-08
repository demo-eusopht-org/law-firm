import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'case_details.dart';
import 'create_new_case.dart';

class Cases extends StatefulWidget {
  const Cases({super.key});

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
              child: Slidable(
                actionPane: SlidableStrechActionPane(),
                actionExtentRatio: 0.25,
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => CaseDetails(),
                      ),
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
                  trailing: Icon(Icons.visibility),
                ),
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Edit',
                    color: Colors.green,
                    icon: Icons.edit,
                    onTap: () {},
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.green,
                    icon: Icons.delete,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
