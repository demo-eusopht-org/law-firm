import 'package:case_management/view/lawyer/lawyer_details.dart';
import 'package:case_management/view/lawyer/new_lawyer.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../utils/app_assets.dart';

class LawyerScreen extends StatefulWidget {
  const LawyerScreen({super.key});

  @override
  State<LawyerScreen> createState() => _LawyerScreenState();
}

class _LawyerScreenState extends State<LawyerScreen> {
  final List<Map<String, String>> lawyerData = [
    {
      'id': '1',
      'firstName': 'Waqas',
      'lastName': 'Hunain',
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
            text: 'Create a New Lawyer',
            color: Colors.white,
            fSize: 16.0,
            fWeight: FontWeight.w700,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewLawyer(),
              ),
            );
          },
        ),
      ),
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Lawyers',
      ),
      body: ListView.builder(
        itemCount: lawyerData.length,
        itemBuilder: (context, index) {
          final lawyer = lawyerData[index];
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
                        builder: (context) => LawyerDetails(),
                      ),
                    );
                  },
                  leading: Image.asset(
                    AppAssets.lawyer,
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textWidget(
                        text: '${lawyer['firstName']}',
                        fSize: 14.0,
                      ),
                      textWidget(
                        text: '${lawyer['cnic']}',
                        fSize: 14.0,
                      ),
                      textWidget(
                        text: '${lawyer['description']}',
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
