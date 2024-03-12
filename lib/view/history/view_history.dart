import 'package:case_management/view/history/history_detail.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:file_manager/file_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../model/open_file_model.dart';

class ViewHistory extends StatefulWidget {
  const ViewHistory({super.key});

  @override
  State<ViewHistory> createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  final FileManagerController controller = FileManagerController();
  final _selectedFilesNotifier = ValueNotifier<List<OpenFileModel>>([]);
  final List<Map<String, String>> history = [
    {
      'Date': '2/28/2024',
      'description': 'sdsnsndndddddddsdsdnsdddsjddjsdsd...',
      'judge': 'Advocate Waqas',
      'status': "Pending",
      'case': '001',
    },
    {
      'Date': '4/28/2024',
      'description': 'sdsnsndndddddddsdsdnsdddsjddjsdsd...',
      'judge': 'Advocate Ali',
      'status': "Pending",
      'case': '002',
    },
    {
      'Date': '2/28/2024',
      'description': 'sdsnsndndddddddsdsdnsdddsjddjsdsd...',
      'judge': 'Advocate Waqas',
      'status': "Pending",
      'case': '003',
    },
    {
      'Date': '4/28/2024',
      'description': 'sdsnsndndddddddsdsdnsdddsjddjsdsd...',
      'judge': 'Advocate Ali',
      'status': "Pending",
      'case': '004',
    },
    {
      'Date': '1/4/2024',
      'description': 'sdsnsndndddddddsdsdnsdddsjddjsdsd...',
      'judge': 'Advocate Salman',
      'status': "Pending",
      'case': '005',
    },
    {
      'Date': '2/10/2024',
      'description': 'sdsnsndndddddddsdsdnsdddsjddjsdsd...',
      'judge': 'Advocate Jawwad',
      'status': "Pending",
      'case': '006',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: true,
        title: 'View History',
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return TimelineTile(
            hasIndicator: true,
            alignment: TimelineAlign.manual,
            lineXY: 0.1,
            isFirst: index == 0,
            isLast: index == history.length - 1,
            indicatorStyle: IndicatorStyle(
              drawGap: true,
              width: 80,
              height: 30,
              indicator: Center(
                child: textWidget(
                  text: '12-12-2023',
                  fSize: 11.0,
                ),
              ),
            ),
            beforeLineStyle: LineStyle(
              color: Colors.red,
              thickness: 3,
            ),
            // startChild: textWidget(
            //   text: item['Date']!,
            //   fSize: 12.0,
            //   fWeight: FontWeight.w700,
            // ),
            endChild: Padding(
              padding: const EdgeInsets.all(6.0),
              child: buildCardhistory(
                item,
                'description',
                'Hearing Description',
                'judge',
                'Judge',
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildCardhistory(
    Map<String, String> item,
    String label,
    String title,
    String description,
    String descTitle,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => HistoryDetail(),
          ),
        );
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: 'Case No:',
                    fSize: 13.0,
                    fWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  textWidget(text: '${item['case']}')
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: '$title:',
                    fSize: 13.0,
                    fWeight: FontWeight.w600,
                  ),
                  textWidget(text: '${item[label]}')
                ],
              ),

              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  textWidget(
                    text: '$descTitle:',
                    fSize: 13.0,
                    fWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  textWidget(text: ' ${item[description]}')
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: 'Status:',
                    fSize: 13.0,
                    fWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  textWidget(text: '${item['status']}')
                ],
              ),
              // textWidget(text: 'Status ${item['status']}'),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.green,
                  size: 24,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
