import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CauseListDetail extends StatefulWidget {
  const CauseListDetail({super.key});

  @override
  State<CauseListDetail> createState() => _CauseListDetailState();
}

class _CauseListDetailState extends State<CauseListDetail> {
  final List<Map<String, String>> data = [
    {
      'sno': '1',
      'caseNo': 'XYZ456',
      'parties': 'Alice vs Bob',
      'under section': 'Sindh Arms Act-23(1) A',
      'fir': '668/23 New Karachi'
    },
    {
      'sno': '2',
      'caseNo': 'XYZ456',
      'parties': 'Alice vs Bob',
      'under section': 'Sindh Arms Act-23(1) A',
      'fir': '668/23 New Karachi'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Cause List Detail',
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 30.0,
          columns: [
            DataColumn(
                label: textWidget(
              text: 'SNO',
              fWeight: FontWeight.w600,
              fSize: 13.0,
            )),
            DataColumn(
                label: textWidget(
              text: 'CASE NO',
              fWeight: FontWeight.w600,
              fSize: 14.0,
            )),
            DataColumn(
                label: textWidget(
              text: 'NAME OF PARTIES',
              fWeight: FontWeight.w600,
              fSize: 14.0,
            )),
            DataColumn(
                label: textWidget(
              text: 'UNDER SECTIONS,ACTS',
              fWeight: FontWeight.w600,
              fSize: 14.0,
            )),
            DataColumn(
                label: textWidget(
              text: 'FIR NO',
              fWeight: FontWeight.w600,
              fSize: 14.0,
            )),
          ],
          rows: data.map((row) {
            return DataRow(
              cells: [
                DataCell(textWidget(
                  text: row['sno']!,
                  fSize: 13.0,
                )),
                DataCell(textWidget(
                  text: row['caseNo']!,
                  fSize: 13.0,
                )),
                DataCell(textWidget(
                  text: row['parties']!,
                  fSize: 13.0,
                )),
                DataCell(textWidget(text: row['under section']!, fSize: 12.0)),
                DataCell(textWidget(
                  text: row['fir']!,
                  fSize: 13.0,
                )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
