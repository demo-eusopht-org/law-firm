import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CaseAttachments extends StatefulWidget {
  const CaseAttachments({super.key});

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'March 6, 2024',
              fSize: 16.0,
              fWeight: FontWeight.bold,
            ),
          ),
          // Box layout
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
