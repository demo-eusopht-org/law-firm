import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CaseProceedings extends StatefulWidget {
  const CaseProceedings({super.key});

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
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textWidget(
                  text: 'Case Title',
                  fSize: 16.0,
                  fWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'January 1, 2022',
              fSize: 16.0,
              fWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBox('Title 1'),
                    SizedBox(width: 10),
                    buildBox('Title 2'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildBox('Title 3'),
                    SizedBox(width: 10),
                    buildBox('Title 4'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBox(String title) {
    return Expanded(
      child: Container(
        height: 100,
        color: Colors.grey[200],
        alignment: Alignment.center,
        child: textWidget(
          text: title,
          fSize: 16.0,
        ),
      ),
    );
  }
}
