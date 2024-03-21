import 'package:case_management/services/local_storage_service.dart';
import 'package:case_management/services/locator.dart';
import 'package:case_management/view/cases/bloc/case_bloc.dart';
import 'package:case_management/widgets/appbar_widget.dart';
import 'package:case_management/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../widgets/text_widget.dart';
import 'bloc/case_events.dart';
import 'bloc/case_states.dart';

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
      'court': 'Sindh High Court',
    },
    {
      'id': '002',
      'Date': '2/28/2024',
      'Status': 'Pending',
      'title': 'Waqas vs Tauqeer',
      'court': 'Sindh High Court',
    },
  ];
  final List<Map<String, String>> tomorrow = [
    {
      'id': '005',
      'Date': '2/28/2024',
      'Status': 'Pending',
      'title': 'Waqas vs Tauqeer',
      'court': 'Sindh High Court',
    },
    {
      'id': '008',
      'Date': '2/28/2024',
      'Status': 'Pending',
      'title': 'Waqas vs Tauqeer',
      'court': 'Sindh High Court',
    },
  ];
  final List<Map<String, String>> allCases = [
    {
      'id': '116',
      'Date': '2/28/2024',
      'Status': 'Pending',
      'title': 'Waqas vs Tauqeer',
      'court': 'Sindh High Court',
    },
    {
      'id': '117',
      'Date': '2/28/2024',
      'Status': 'Pending',
      'title': 'Waqas vs Tauqeer',
      'court': 'Sindh High Court',
    },
    {
      'id': '118',
      'Date': '2/28/2024',
      'Status': 'Pending',
      'title': 'Waqas vs Tauqeer',
      'court': 'Sindh High Court',
    },
    {
      'id': '119',
      'Date': '2/28/2024',
      'Status': 'Pending',
      'title': 'Waqas vs Tauqeer',
      'court': 'Sindh High Court',
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final userId = locator<LocalStorageService>().getData('id');
      BlocProvider.of<CaseBloc>(context).add(
        GetUserCasesEvent(
          userId: userId!,
        ),
      );
    });
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CaseBloc, CaseState>(
      bloc: BlocProvider.of<CaseBloc>(context),
      builder: (context, state) {
        if (state is LoadingCaseState) {
          return const Loader();
        } else if (state is AllCasesState) {
          return _buildCases();
        }
        return Center(
          child: Text('Something went wrong!'),
        );
      },
    );
  }

  Widget _buildCases() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildExpanded(),
      ],
    );
  }

  Expanded buildExpanded() {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'Today',
              fWeight: FontWeight.w600,
              fSize: 18.0,
            ),
          ),
          ...assignedCases.map((lawyer) {
            return _buildLawyerCard(lawyer);
          }).toList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'Tomorrow',
              fWeight: FontWeight.w600,
              fSize: 18.0,
            ),
          ),
          ...tomorrow.map((lawyer) {
            return _buildLawyerCard(lawyer);
          }).toList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: textWidget(
              text: 'All Cases',
              fWeight: FontWeight.w600,
              fSize: 18.0,
            ),
          ),
          ...allCases.map((lawyer) {
            return _buildLawyerCard(lawyer);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildLawyerCard(Map<String, String> lawyer) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Slidable(
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          child: ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(text: 'Case No:'),
                    textWidget(
                      text: '${lawyer['id']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(text: 'Date:'),
                    textWidget(
                      text: '${lawyer['Date']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(text: 'Status:'),
                    textWidget(
                      text: '${lawyer['Status']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(text: 'Title:'),
                    textWidget(
                      text: '${lawyer['title']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(text: 'Court:'),
                    textWidget(
                      text: '${lawyer['court']}',
                      fSize: 14.0,
                    ),
                  ],
                ),
              ],
            ),
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
  }
}
