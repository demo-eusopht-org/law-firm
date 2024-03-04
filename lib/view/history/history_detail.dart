import 'package:case_management/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/text_widget.dart';

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({super.key});

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  final List<Map<String, String>> historyDetail = [
    {
      'Date': '2/28/2024',
      'Status': 'Pending',
      'description':
          'sdsnsndndddddddsdsdnsdddsjddjsdsdsdsnsndndddddddsdsdnsdddsjddjsdsdsdsnsndndddddddsdsdnsdddsjddjsdsd',
      'judge': 'Advocate Waqas',
      'party': 'Advocate Salman',
      'assigne': 'Advocate Waqas',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'History Detail',
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: historyDetail.length,
              itemBuilder: (context, index) {
                final lawyer = historyDetail[index];
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildCard(lawyer, 'Hearing Date', 'Date'),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        constraints: BoxConstraints(minWidth: double.infinity),
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
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: textWidget(
                                    text: '${lawyer['description']}',
                                    maxline: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Opposite Party Lawyer',
                        'party',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Case Assigne',
                        'assigne',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Judge',
                        'judge',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildCard(
                        lawyer,
                        'Status',
                        'Status',
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
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
