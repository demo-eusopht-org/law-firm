import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AssignedCases extends StatefulWidget {
  const AssignedCases({super.key});

  @override
  State<AssignedCases> createState() => _AssignedCasesState();
}

class _AssignedCasesState extends State<AssignedCases> {
  DateTime? _selectedDate;
  final List<Map<String, String>> assignedCases = [
    {
      'id': '001',
      'Date': '2/28/2024',
      'Status': 'Pending',
      'title': 'Waqas vs Tauqeer',
    },
  ];
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        context: context,
        showBackArrow: false,
        title: 'My Assigned Cases',
        leadingWidth: 0.0,
        action: [
          IconButton(
            icon: Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            onPressed: () {
              _selectDate(context);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: textWidget(
              text: "Today",
              fSize: 20.0,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: assignedCases.length,
              itemBuilder: (context, index) {
                final lawyer = assignedCases[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(text: 'Case No'),
                                  textWidget(
                                    text: '${lawyer['id']}',
                                    fSize: 14.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(text: 'Status'),
                                  textWidget(
                                    text: '${lawyer['Status']}',
                                    fSize: 14.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(text: 'Title'),
                                  textWidget(
                                    text: '${lawyer['title']}',
                                    fSize: 14.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white,
                        elevation: 5,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(text: 'Case No'),
                                  textWidget(
                                    text: '002',
                                    fSize: 14.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(text: 'Status'),
                                  textWidget(
                                    text: 'Approved',
                                    fSize: 14.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(text: 'Title'),
                                  textWidget(
                                    text: 'Ali vs Hussain',
                                    fSize: 14.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
