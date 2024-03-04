import 'package:case_management/widgets/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';

import '../../widgets/text_widget.dart';
import 'cause_list_detail.dart';

class CauseList extends StatefulWidget {
  const CauseList({super.key});

  @override
  State<CauseList> createState() => _CauseListState();
}

class _CauseListState extends State<CauseList> {
  final List<Map<String, dynamic>> _items = [
    {
      'group': 'Karachi (Central)',
      'items': [
        'Additional District & Sessions Judge IV, Karachi(Central)',
        'Civil Judge & Judicial Magistrate IX, Karachi(Central)',
      ]
    },
    {
      'group': 'Dadu',
      'items': [
        'District & Sessions Judge, Dadu',
        '	Additional District & Sessions Judge I, Dadu',
      ]
    },
    {
      'group': 'Khairpur',
      'items': [
        'District & Sessions Judge, Khairpur',
        'Senior Civil Judge / Assistant Sessions Judge, Kingri',
        'Civil Judge & Judicial Magistrate, Sobhodero',
      ]
    },
    {
      'group': 'Ghotki',
      'items': [
        'Senior Civil Judge / Assistant Sessions Judge, Ghotki',
        'Consumer Protection Court/CJJM, Ghotki',
        'Additional District & Sessions Judge III, Ghotki',
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'Cause List',
      ),
      body: GroupListView(
        sectionsCount: _items.length,
        countOfItemInSection: (int section) {
          return _items[section]['items'].length;
        },
        itemBuilder: (BuildContext context, IndexPath index) {
          final item = _items[index.section]['items'][index.index];
          final serialNumber = index.index + 1;
          return Card(
            color: Colors.white,
            elevation: 5,
            child: ListTile(
              title: Row(
                children: [
                  textWidget(
                    text: '$serialNumber. ',
                    fSize: 10.0,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: textWidget(
                      text: item,
                      fSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => CauseListDetail(),
                  ),
                );
              },
            ),
          );
        },
        groupHeaderBuilder: (BuildContext context, int section) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.green,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  textWidget(
                    text: _items[section]['group'],
                    color: Colors.white,
                    fSize: 18.0,
                    fWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Expanded table(String Text, int flex) {
    return Expanded(
      flex: flex,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        color: Colors.red,
        child: textWidget(
          text: '$Text',
          color: Colors.white,
        ),
      ),
    );
  }
}
